Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbRCXQQR>; Sat, 24 Mar 2001 11:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRCXQQH>; Sat, 24 Mar 2001 11:16:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:4308 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131709AbRCXQPw>;
	Sat, 24 Mar 2001 11:15:52 -0500
Date: Sat, 24 Mar 2001 17:13:59 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103241613.RAA08378.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, jgarzik@mandrakesoft.com
Subject: Re: Larger dev_t
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, tytso@MIT.EDU, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also for 2.5, kdev_t needs to go away, along with all those arrays

Yes, it has been said many times, and I get the impression
that many people actually did it.

Maybe everybody with code or at least a detailed setup
should demonstrate what was done so that we can compare merits
of several approaches.

The stuff I sent earlier today was the dev_t part.
The next part I hope to send one of these days is the
interface between dev_t and kdev_t.
(Most people think that kdev_t is an integer, I think that
it is a pointer. Since dev_t now can be large and arrays
cannot be used, we need some hash lookup to find the
structure corresponding to the number. And the code is
roughly speaking identical to Al's bdev code, only now used
both for bdev and cdev.)

(Funny enough Al's code does not solve the only small problem
I had six years ago: a mknod with funny numbers does not mean
that some such device actually exists. In reality we only
want to convert number into device pointer when the device is
opened, but the current kernel code does
	init_special_inode(inode, mode, rdev);
for a mknod, and if it was a block device
	inode->i_bdev = bdget(rdev);
so that it does allocate a struct to this nonsense device.)

Andries
