Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVJQJMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJQJMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJQJMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:12:35 -0400
Received: from alpha.polcom.net ([217.79.151.115]:30115 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932213AbVJQJMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:12:35 -0400
Date: Mon, 17 Oct 2005 11:15:22 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Jens Axboe <axboe@suse.de>
Cc: li nux <lnxluv@yahoo.com>, Erik Mouw <erik@harddisk-recovery.com>,
       colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
In-Reply-To: <20051017090310.GR2811@suse.de>
Message-ID: <Pine.LNX.4.63.0510171109250.21130@alpha.polcom.net>
References: <20050831080744.GM4018@suse.de> <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com>
 <20051017090310.GR2811@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Jens Axboe wrote:
>> how to correct this problem ?
>
> See your buffer address, it's not aligned. You need to align that as
> well. This is needed because the hardware will dma directly to the user
> buffer, and to be on the safe side we require the same alignment as the
> block layer will normally generate for file system io.
>
> So in short, just align your read buffer to the same as your block size
> and you will be fine. Example:
>
> #define BS      (4096)
> #define MASK    (BS - 1)
> #define ALIGN(buf)      (((unsigned long) (buf) + MASK) & ~(MASK))
>
> char *ptr = malloc(BS + MASK);
> char *buf = (char *) ALIGN(ptr);
>
> read(fd, buf, BS);

Shouldn't one use posix_memalign(3) for that?


Grzegorz Kulewski
