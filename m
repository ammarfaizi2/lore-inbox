Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJVVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJVVKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJVVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:10:23 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39125 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750709AbWJVVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:10:22 -0400
Date: Sun, 22 Oct 2006 23:09:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Amit Choudhary <amit2030@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't
 then....
In-Reply-To: <84144f020610221322v2683a66bmf837ada1edea72e0@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0610222306240.22903@yvahk01.tjqt.qr>
References: <20061022195809.30126.qmail@web55607.mail.re4.yahoo.com>
 <84144f020610221322v2683a66bmf837ada1edea72e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1786028654-1161551375=:22903"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1786028654-1161551375=:22903
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


>> So, if memory allocation to 'a' fails, it is going to kfree 'b'. But since
>> 'b'
>> is not initialized, kfree may crash (unless DEBUG is defined).

... in which case we will be notified:

$ cat test.c
#include <linux/slab.h>

void func(void) {
    char *a, *b;
    if((a = kmalloc(10, GFP_KERNEL)) == NULL)
        goto err;
    if((b = kmalloc(10, GFP_KERNEL)) == NULL)
        goto err;

 err:
    kfree(a);
    kfree(b);
    return;
}

$ make -C /erk/kernel/linux-2.6.19-rc2 M=$PWD
  CC [M]  /dev/shm/test.o
/dev/shm/test.c: In function ‘func’:
/dev/shm/test.c:4: warning: ‘b’ may be used uninitialized in this 
function


Compared to the whole source tree, the kernel has very few "may be 
uninitialized" spots. And stochastically, it is quite unlikely that all 
of them are caused by a construct like the above.


>> I have seen the same case at many places when allocating in a loop.
>
> So you found a bug. Why not send a patch to fix it?


	-`J'
-- 
--1283855629-1786028654-1161551375=:22903--
