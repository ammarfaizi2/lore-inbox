Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262761AbREVTxn>; Tue, 22 May 2001 15:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbREVTxd>; Tue, 22 May 2001 15:53:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7328 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262761AbREVTxW>;
	Tue, 22 May 2001 15:53:22 -0400
Date: Tue, 22 May 2001 21:52:45 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105221952.VAA78718.aeb@vlet.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> patch below adds the missing half of kdev_t -
> for block devices we already have a unique pointer
> and that adds a similar animal for character devices.

Very good.
(Of course I did precisely the same, but am a bit slower in
submitting things during a stable series or code freeze.)

One remark, repeating what I wrote on some web page:
-----
A struct block_device provides the connection between a device number
and a struct block_device_operations. 
...
Clearly, we also want to associate a struct char_device_operations
to a character device number. When we do this, all bdev code will
have to be duplicated for cdev, so there seems no point in having
bdev code - kdev, for both bdev and cdev, seems more elegant. 
-----

And a second remark: don't forget that presently the point where
bdev is introduced is not quite right. We must only introduce it
when we really have a device, not when there only is a device
number (like on a mknod call).

Andries
