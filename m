Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbTDNTQX (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTDNTQX (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:16:23 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:55050 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263908AbTDNTQU (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:16:20 -0400
Date: Mon, 14 Apr 2003 21:28:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304141133390.19302-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304142103290.5042-100000@serv>
References: <Pine.LNX.4.44.0304141133390.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003, Linus Torvalds wrote:

> > Expansion into what?
> 
> That's the point - Andries patch is a pure extension of the number space 
> into user space. 
> 
> If you think that clashes with anything else, than that "anything else" is 
> _broken_. 

It doesn't has to clash, but it only encourages waste. Encoding all kinds 
of information into dev_t has to plan for the worst case and that's the 
only reason to immediately go to 64 bits and most of the number space is 
simply unused and wasted.

> > The knowledge about dev_t is already reduced to a minimum in a lot of 
> > block device drivers. register_blkdev() is already pretty much a dummy and 
> > not a requirement anymore.
> 
> So why do you think Andries patch clashes?
> 
> Also, I don't think your patch is proper. The point about having a single
> disk number space means that IDE and SCSI disks would show up there too -
> users simply shouldn't need to care about the differences (which is not
> just major numbers, but also the silly difference in how the partitioning
> splits minor numbers).

Look at it this way: the whole range from 0 to ... is one big major 
number, so old device numbers show up their as well.
Only user space "knows" about the special from some of the bits, but the 
kernel certainly doesn't care.

> But at the same time, for backwards compatibility clearly they have to
> show up in the _old_ places too. Which really implies that there needs to
> be a mapping function for the old numbers into the proper block device
> queues etc, so that people can still use the old /dev nodes when they
> upgrade their kernel.

Why should the kernel care about this? Most programs only want to open 
/dev/sd... Until the system tools are updated they will only see the old 
numbers anyway, later they won't care anymore either.
You didn't want that a device shows twice under devfs (e.g. as sda and 
scsi/host0/bus0/target0/lun0). How is that suddenly different?

bye, Roman

