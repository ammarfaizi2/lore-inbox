Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWECSyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWECSyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWECSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:54:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:1039 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750730AbWECSyR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:54:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WjHTofxyY2wWw3GB3EsyffNc5+TD+isg3J34lCzP9pX79gnMIk+l6xlI/aZDkR6nWCT8ho6yhp0WApGkQ24XwR91fC7zgeCMD7pTI2WPZdNmtqLq0PlqHqapyXxZe4oAhnh3zq/pfpkWWT3G0s0+ajnaoKsYsy06EC9ZMNMiOXg=
Message-ID: <6934efce0605031154l225caee8yc217c6e63c0dd441@mail.gmail.com>
Date: Wed, 3 May 2006 11:54:16 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apropos borrowing: borrow the compression from Squashfs.

We borrow much more than the compression from cramfs.  We plan to
borrow some ideas about compression from squashfs.

> > I've heard people say, "XIP is stupid.  Why on earth would I use
> > expensive slow flash instead of cheap fast RAM?"
> > [...]  If I
> > take libfoo.so which is about 2MiB and throw it in JFFS2, it
> > compresses to about 1MiB in flash.  If I store libfoo.so as an XIP
> > file (uncompressed) in XIP CRAMFS or AXFS it takes up 2MiB of flash. That is
> > 1MiB extra flash for XIP.  But the JFFS2 version would need
> > 2MiB of RAM to store that library when used while the XIP system uses
> > 0MiB. That means XIP uses +1MiB of flash and -2MiB of RAM for
> > libfoo.so.  So for any extra flash used for XIP, it can save twice
> > that amount of RAM.  The end result can be lower cost systems on the
> > small end.  The secret is to choose what to make XIP and what to
> > compress on flash.
>
> If 2 MB of RAM are cheaper [as you say] than 1 MB of Flash, where's the
> advantage when XIP uses more flash?

I didn't mean to suggest I thought 2MB of RAM is cheaper 1MB.  People
say that, yes.  I say that is false.  Mwave.com will sell you several
1GB SD card flash at <$40 while 1GB of DDR2 will cost >$100.  That's
actually a strawman argument, just to demonstrate what is possible ;) 
The economics are different at the embedded side, the RAM isn't the
same as what is used in PCs and neither is the Flash.  Also the prices
are mostly laid out in contracts between large companies and are not
public.  I don't really want to get into a discussion of Flash pricing
and economics, I don't think it appropriate for this forum.  Please
lets leave it at some people have done this, are doing it, and want to
do it in the future (see Mark Lords comment earlier).  It gets
complicated.  Some systems it makes sense for, some it doesn't.


We took Familiar Linux 0.8.3 Opie verision and built two versions, one
that used jffs2 on NAND and another that used XIP cramfs on NOR.  We
optimized the XIP cramfs to only uncompress commonly used libraries
and binaries.  The XIP build used 8MiB more flash.  It saved about
20MiB of RAM and was 3X faster at bootup.  (Summary support on jffs2
closed the gap to 2X boot up but made the jffs2 use _more_ flash than
the XIP).  The jffs2 version volume wouldn't run the PIM apps and the
browser and Quake at the same time with only 32MiB of RAM.  The XIP
version would.  The jffs2 version used 42MiB and the XIP 50MiB. 
Rounding to rational chip sizes that's 32MiB RAM/64MiB Flash versus
64MiB RAM/64MiB Flash.

The point of axfs is to reduce that 8MiB to the absolute minimum.  In
general application XIP give the system designer the to flexible trade
Flash for RAM and RAM for Flash to squeeze the system into the optimal
cheapest it can be.  AXFS will give more flexiblity with a mainstream
solution.
