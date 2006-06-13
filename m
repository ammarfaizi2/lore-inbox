Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWFMVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWFMVNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWFMVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:13:18 -0400
Received: from xenotime.net ([66.160.160.81]:59289 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932256AbWFMVNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:13:16 -0400
Date: Tue, 13 Jun 2006 14:16:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: John Richard Moser <nigelenki@comcast.net>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: Packing data in kernel memory
Message-Id: <20060613141600.c736e183.rdunlap@xenotime.net>
In-Reply-To: <448F2602.2030402@comcast.net>
References: <448F0893.1080706@comcast.net>
	<Pine.LNX.4.61.0606132217110.11918@yvahk01.tjqt.qr>
	<20060613133227.1eee4578.rdunlap@xenotime.net>
	<448F2602.2030402@comcast.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 16:54:26 -0400 John Richard Moser wrote:

> Randy.Dunlap wrote:
> > On Tue, 13 Jun 2006 22:18:55 +0200 (MEST) Jan Engelhardt wrote:
> > 
> >>> Subject: Packing data in kernel memory
> >>>
> >> Can't you just use mlock(), if you want to keep it in RAM?
> >>
> >> Or do you need it in kernel memory, because you need it in the lowmem area? 
> >> Or for interaction with other kernel code?
> >>
> >>> Is there a way to pack and store arbitrary data in the kernel, or do I
> >>> need to roll my own?
> > 
> > Sounds a bit like a slab cache to me.
> > 
> 
> OK cool, can I make that non-swappable?

kernel (allocated) memory is non-swappable.

> I'm going to be trying to do
> this between where kernel swaps a page out and swapped page actually is
> written to disk.  The result will be a "Swap Zone," in-memory storage of
> pages that the rest of the kernel thinks have been swapped to disk.
> (Code here will use the swap interface, so the rest of the kernel thinks
> it's just swapping; I'll handle whether to pull it out of memory or off
> disk behind that)
> 
> The need for packing pages comes because eventually (using above
> infrastructure) I'll be taking sets of 32KiB of data and compressing it;
> I don't want to pad up to 4095 excess unused bytes if that stuff
> compresses to 28KiB+1 :)  (more likely 16KiB+1 +/-8KiB)
> 
> This is all, of course, assuming I ever figure out how the heck to get
> in the middle of the swapping process.  I'm looking at mm/page_io.c
> swap_writepage() and friends and scratching my head.  I have no idea wtf...
> 
> 
> >> Write a device driver, kmalloc some buffer, and copy data via a write 
> >> function from userspace to that buffer. Should be trivial.
> >>
> >>> 1 excess pages, 4 units wasted memory.
> >> Of course, kmalloc only works up to some boundary AFIACS.
> > 
> > 128 KB on some arches.  More on a few IIRC.

---
~Randy
