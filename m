Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbREVU4H>; Tue, 22 May 2001 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbREVUz5>; Tue, 22 May 2001 16:55:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46249 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262814AbREVUzk>;
	Tue, 22 May 2001 16:55:40 -0400
Date: Tue, 22 May 2001 22:54:49 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105222054.WAA79836.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They are entirely different. Too different sets of operations.

Maybe you didnt understand what I meant.
both bdev and cdev take care of the correspondence
device number <---> struct with operations.

The operations are different, but all bdev/cdev code is identical.

So the choice is between two uglies:
(i) have some not entirely trivial amount of code twice in the kernel
(ii) have a union at the point where the struct operations
is assigned.

I preferred the union.

>> And a second remark: don't forget that presently the point where
>> bdev is introduced is not quite right. We must only introduce it
>> when we really have a device, not when there only is a device
>> number (like on a mknod call).

> That's simply wrong. kdev_t is used for unopened objects quite often.

Yes, but that was my design mistake in 1995.
I think you'll find if you continue on this way,
as I found and already wrote in kdev_t.h
that it is bad to carry pointers around for unopened and unknown devices.

So, I think that the setup must be changed a tiny little bit
and distinguish meaningless numbers from devices.

Andries
