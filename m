Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSJVUa0>; Tue, 22 Oct 2002 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJVUa0>; Tue, 22 Oct 2002 16:30:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11487 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264853AbSJVUaU>;
	Tue, 22 Oct 2002 16:30:20 -0400
Date: Tue, 22 Oct 2002 22:49:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <1035319088.31873.149.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210222243200.23215-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Oct 2002, Alan Cox wrote:

> Actually I know a few. 2Tb is cheap - its one pci controller and eight
> ide disks.

what we can do is to still use the linear mapping, ie. to impose the limit
only on fremap() users. This is ugly but works. It needs quite some
hacking though, since at the point of pagecache-pte zapping we dont have a
vma handy, so we cannot tell from the pte alone whether it's mapped
linearly or not. We could perhaps use the free bit in the pte to signal
this condition, but i'm not sure whether this is possible on every
architecture. Are there architectures that has no freely OS-usable bit in
the pte?

the limit will become even more prominent once i've moved the protection
bits into the swap pte format as well - that reduces the fremap() limit to
0.5 Tb, for 32-bit ptes.

(there's no real reason to keep the offset in the pte in the linearly
mapped case anyway, besides some vague 'symmetry' arguments.)

	Ingo

