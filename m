Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSKDVbV>; Mon, 4 Nov 2002 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKDVbV>; Mon, 4 Nov 2002 16:31:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6103 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262823AbSKDVbU>;
	Mon, 4 Nov 2002 16:31:20 -0500
Date: Mon, 4 Nov 2002 16:37:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: tytso@mit.edu, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Patch(2.5.45): Eliminate unchecked kfree(disk->random)
In-Reply-To: <20021104132954.A337@baldur.yggdrasil.com>
Message-ID: <Pine.GSO.4.21.0211041634470.2336-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Nov 2002, Adam J. Richter wrote:

> 	alloc_disk in linux-2.5.45/drivers/block/genhd.c calls
> rand_initialize_disk, which can set disk->random to NULL on kmalloc
> failure.  disk_release does a kfree(disk->random) without checking.

kfree(NULL) is guaranteed to be OK and is a very common idiom.  Talk
to Linus about that - it's a religious issue and FWIW I'm on the same
side ("free(NULL) should be allowed").  IIRC, Linus had claimed quite
a few times that change of kfree() that would break kfree(NULL) would
be considered as a bug.

