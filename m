Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKDV4h>; Mon, 4 Nov 2002 16:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSKDV4h>; Mon, 4 Nov 2002 16:56:37 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:16067 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262804AbSKDV4h>; Mon, 4 Nov 2002 16:56:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 4 Nov 2002 14:02:57 -0800
Message-Id: <200211042202.OAA00458@baldur.yggdrasil.com>
To: viro@math.psu.edu
Subject: Re: Patch(2.5.45): Eliminate unchecked kfree(disk->random)
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
>On Mon, 4 Nov 2002, Adam J. Richter wrote:

>> 	alloc_disk in linux-2.5.45/drivers/block/genhd.c calls
>> rand_initialize_disk, which can set disk->random to NULL on kmalloc
>> failure.  disk_release does a kfree(disk->random) without checking.

>kfree(NULL) is guaranteed to be OK and is a very common idiom.  Talk
>to Linus about that - it's a religious issue and FWIW I'm on the same
>side ("free(NULL) should be allowed").  IIRC, Linus had claimed quite
>a few times that change of kfree() that would break kfree(NULL) would
>be considered as a bug.

	Oops, sorry for not checking that possibility before posting.

	I'd still like to see this patch integrated as a clean-up (it
does delete a few lines and should shrink vmlinux by a few bytes), but
it can certainly wait until post-crunch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
