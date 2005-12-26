Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVLZCPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVLZCPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVLZCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 21:15:42 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:40606 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750976AbVLZCPl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 21:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JU9SWVkkwn/0DVpZYOoooWZQrS0qF5DIqRcApQshHLhgzSd+wgVdfiD/mScr3+G0h+uo7f/hLix+7FU3dPQPXpPmDgT4IHM9HrUUDs3bq94k0IUm+OzqMp2th+7jy42jzUb2aFQWIZiqKG5vVy9mxbmLwNSOUD6Ez64AKXyq4BM=
Message-ID: <2cd57c900512251815r16422013p@mail.gmail.com>
Date: Mon, 26 Dec 2005 10:15:39 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Axel Kittenberger <axel.kernel@kittenberger.net>
Subject: Re: Possible Bootloader Optimization in inflate (get rid of unnecessary 32k Window)
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <200512221352.23393.axel.kernel@kittenberger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512221352.23393.axel.kernel@kittenberger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/22, Axel Kittenberger <axel.kernel@kittenberger.net>:
> Hello, Whom do I talk to about acceptance of Patches in the Bootloader?
>
> I have seen, and coded once some time ago for priv. uses, do infalte the
> gziped linux kernel at boottime in "arch/i386/boot/compressed/misc.c" and "
> windowlib/inflate.c" the deflation algorthimn uses a 32k backtrack window.
> Whenever it is full, it copies it .... into the memory.
>
> While this window makes a lot of sense in an userspace application like
> gunzip, it does not make a lot sense in the bootloader. As userspace
> application the window is flushed to a file when full. The bootloader
> "flushes" it to memory (copies it in memory). That 1 time copy of the whole
> kernel can be optimized away, since we do not keep track of a window since
> the inflater can read what it has written right in the computer memory, while
> it unpacks the kernel.
>
> What would the optimization be worth?
> * A faster uncompressing of the kernel, since a total 1-time memcopy of the
> whole kernel is been optimized away.
> * I'm not sure about the size, the memory or disk footprint. If the 32k static
> (!) memory array in compressed/misc.c, I don't know if it safes 32k running
> memory, or 32k on-disk size. Since I don't know the indepth working of these.

Neither for saving running memory (discarded), nor on-disk size
(window[WSIZE] resides in BSS).

>
> Before I code this again (I know that this optimization has worked with a 2.4

I think 2.6 didn't change much in this field.

> kernel), I want to ask, would such patch be accepted? now or once ever? who
> should I forward this?

"H. Peter Anvin" <hpa@zytor.com>, and akpm, and even Linus. I'd like
to see your patch. It would be instructive.


-- Coywolf
