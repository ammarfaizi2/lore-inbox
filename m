Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283411AbRLDUZC>; Tue, 4 Dec 2001 15:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283389AbRLDUXr>; Tue, 4 Dec 2001 15:23:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43172 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283408AbRLDUXK>;
	Tue, 4 Dec 2001 15:23:10 -0500
Date: Tue, 04 Dec 2001 12:22:54 -0800 (PST)
Message-Id: <20011204.122254.110116318.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: alan@lxorguk.ukuu.org.uk, arjanv@redhat.com, linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15372.63827.716885.948119@napali.hpl.hp.com>
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com>
	<E16BC09-0001Ql-00@the-village.bc.nu>
	<15372.63827.716885.948119@napali.hpl.hp.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Tue, 4 Dec 2001 08:26:59 -0800
   
   I think the issue at hand is whether, longer term, it is desirable to
   move all bounce buffer handling into the PCI DMA layer or whether
   Linux should continue to make bounce buffer management visible to
   drivers.  I'd be interested in hearing opinions.

Well, this whole ia64 situation should be the example that shows that
for severely broken 64-bit platforms, like IA64, doing the bounce
buffering in the PCI DMA layer is a lose.  The HIGHMEM option is the
optimal one in this case, and I think that is fine.

If what you are asking is should we tweak the APIs again so that
situations like current IA64 can be done more sanely in the PCI DMA
layer, I say definitely no.

There really is no excuse for the current IA64 hardware situation,
there were probably well over 3 or 4 major 64-bit platforms from
competitors, whose PCI controllers were pretty well documented
publicly, from which Intel could have derived a working 64-bit
platform PCI controller design.

When a saner IA64 hardware implementation comes about (if ever), you
can make CONFIG_IA64_WHATEVER_PLATFORM which undoes the HIGHMEM stuff
and enables PCI DMA support code for those chipsets.  As Alan has
suggested.  That is a perfectly fine way of dealing with this.

Franks a lot,
David S. Miller
davem@redhat.com

