Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272168AbRH3L5j>; Thu, 30 Aug 2001 07:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272169AbRH3L5a>; Thu, 30 Aug 2001 07:57:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22470 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S272168AbRH3L5S>;
	Thu, 30 Aug 2001 07:57:18 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 Aug 2001 11:57:31 GMT
Message-Id: <200108301157.LAA313949@vlet.cwi.nl>
To: bcrl@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] blkgetsize64 ioctl
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben LaHaise <bcrl@redhat.com>

    The patch below reserves an ioctl for getting the size in blocks of a
    device as a long long instead of long as the old ioctl did.  The patch for
    this to e2fsprogs sneaked in a bit too early.  There is a conflict with
    the ia64 get/set sector ioctls, but I that's less common than e2fsprogs.


    +#define BLKGETSIZE64 _IO(0x12,109)    /* return device size (long long *arg) */

There are more conflicts with the numbering.

But more interestingly, I don't think we need the size in blocks.
We need the size in bytes.

(In 32-bit space we need the 8 or 9 or 10 bits extra provided by
counting blocks instead of bytes, but it causes quite a few problems.
In 64-bit space we can avoid all problems and work in bytes.
(Or even in bits.))

Andries

