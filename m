Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTLMTEC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTLMTEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:04:02 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:63248 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265284AbTLMTD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:03:58 -0500
To: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT fs sanity check patch
References: <20031203072219F.yokota@netlab.is.tsukuba.ac.jp>
	<87d6b6ujl0.fsf@devron.myhome.or.jp>
	<20031214031630A.yokota@netlab.is.tsukuba.ac.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 14 Dec 2003 04:03:47 +0900
In-Reply-To: <20031214031630A.yokota@netlab.is.tsukuba.ac.jp>
Message-ID: <87fzfofsks.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp> writes:

> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Subject: Re: FAT fs sanity check patch
> Date: Wed, 03 Dec 2003 22:17:15 +0900
> 
> > > Because some MS windows based FAT filesystem disk formatter generetes
> > > wrong super bloacks.
> 
> > BTW, did this happen in MS windows of which version?
> 
>  I tested on Windows 95 and Windows Me.
> But I think it can happen on all version of MS-Windows.

Nope, win2k didn't this at least.

> I found why MS-Windows uses wrong numbers.
> 
> Usually, MO-disk uses "super floppy" format. And all "super floppy" format
> disk contains wrong numbers. But "plain (Fixed disk)" format disk contains
> correct number.
>
> In "super floppy" format, boot sector's media number is 0xf0 (== 1.44MB 2HD
> IBM-PC floppy format).
> And FAT entry's media number is 0xf8 (== Fixed disk).
> 
> Media number can takes 0xf0-0xff.
> Other media number values are used for other format disks.
> For example, 1.2MB 2HC NEC-PC9801 floppy format uses 0xf9.

I know.
 
> Usually, these two values must be same. But "super floppy" format
> disk uses different value.
> 
> Why this format uses different value?
> I think MS-Windows changes disk cache's caching strategy based on
> boot sector's media ID value.
> 
> Because any removeable media can eject any time, so disk cache
> (espeially write cache) is not usable for removeable disks.

So?

> MO disk can treat as Fixed disk, except disk caching strategy.
> Because MO disk is removeable.
> 
> Anyway, this bad hack is not useful for Linux. Linux uses
> mount/unmount command to flush disk cache.

Bad hack? Why? Do you know how mount operation is dangerous and it's
difficult for fatfs? Do you want to handle the any format as FAT?

This is completely unrelated to handling the cache.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
