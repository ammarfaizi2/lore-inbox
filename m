Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbRF0Cck>; Tue, 26 Jun 2001 22:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbRF0Ccb>; Tue, 26 Jun 2001 22:32:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64454 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263473AbRF0CcS>;
	Tue, 26 Jun 2001 22:32:18 -0400
Date: Wed, 27 Jun 2001 04:32:16 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106270232.EAA456067.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: mm and Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After sending util-linux out, I booted a kernel that had kdev_t
a pointer type, to see whether that still works.
And all (minus md/lvm/nfs that didnt compile) was fine
except that kswapd produced an oops. Investigation shows
that it was caused by the combination of what <linux/swap.h> calls
"Ugly ugly ugly HACK" and what <linux/kdev_t.h> judges with "yuk".

So, maybe we must remove one or both of these sore spots.
The second one is the use of a special constant B_FREE
as device value to indicate that the buffer is free.
I'll look at this tomorrow but perhaps someone knows:
must the constant B_FREE (used only in fs/buffer.c) be nonzero?
If so, then we probably need a bitfield to indicate "free".
Otherwise we can use 0 ("no device") as value.

Andries
