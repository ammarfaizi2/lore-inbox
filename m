Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVJQJQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVJQJQi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVJQJQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:16:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8788 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932222AbVJQJQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:16:37 -0400
Date: Mon, 17 Oct 2005 11:17:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: li nux <lnxluv@yahoo.com>, Erik Mouw <erik@harddisk-recovery.com>,
       colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20051017091710.GT2811@suse.de>
References: <20050831080744.GM4018@suse.de> <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com> <20051017090310.GR2811@suse.de> <Pine.LNX.4.63.0510171109250.21130@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510171109250.21130@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17 2005, Grzegorz Kulewski wrote:
> On Mon, 17 Oct 2005, Jens Axboe wrote:
> >>how to correct this problem ?
> >
> >See your buffer address, it's not aligned. You need to align that as
> >well. This is needed because the hardware will dma directly to the user
> >buffer, and to be on the safe side we require the same alignment as the
> >block layer will normally generate for file system io.
> >
> >So in short, just align your read buffer to the same as your block size
> >and you will be fine. Example:
> >
> >#define BS      (4096)
> >#define MASK    (BS - 1)
> >#define ALIGN(buf)      (((unsigned long) (buf) + MASK) & ~(MASK))
> >
> >char *ptr = malloc(BS + MASK);
> >char *buf = (char *) ALIGN(ptr);
> >
> >read(fd, buf, BS);
> 
> Shouldn't one use posix_memalign(3) for that?

Dunno if one 'should', one 'can' if one wants to. I prefer to do it
manually so I don't have to jump through #define hoops to get at it
(which, btw, still doesn't expose it on this machine).

-- 
Jens Axboe

