Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSAWKTx>; Wed, 23 Jan 2002 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAWKTo>; Wed, 23 Jan 2002 05:19:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50305 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289768AbSAWKTb>;
	Wed, 23 Jan 2002 05:19:31 -0500
Date: Wed, 23 Jan 2002 02:18:19 -0800 (PST)
Message-Id: <20020123.021819.21955581.davem@redhat.com>
To: drobbins@gentoo.org
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi, lwn@lwn.net
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1011779573.9368.40.camel@inventor.gentoo.org>
In-Reply-To: <1011779573.9368.40.camel@inventor.gentoo.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This means that the fix belongs in the DRM drivers, specifically
DRM(mmap_dma) should clear the cacheability bits in the
vma->vm_page_prot at mmap time.

I always thought the idea was that the AGP device accessed main memory
through GART with full cache coherency with the processor.  This
should be pretty easy to implement since the PCI controller has to do
this already.

I'm really surprised that both the NVIDIA driver and DRM both get this
wrong.

Actually, the AMD guys say this:

	This situation is fundamentally illegal because GART is non-coherent and
	all translations that the processor could use to access the AGP memory
	must, therefore, be non-cacheable.  Although we have seen no intentional
	access to the AGP memory by the processor via the 4MB cacheable
	translation we have seen legitimate, speculative, accesses performed by
	the processor.

"access by the processor" to the 4MB cacheable translation or
somewhere else?  This needs clarification.

Disabling 4MB translations has zero effect on the problem they say is
the root all of this.  The mappings given to the OpenGL driver to the
GART memory is still going to be cacheable, thus the problem ought to
still exist.

As usual, AMD's commentary brings more questions than it answers.
