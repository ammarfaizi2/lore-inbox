Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280923AbRKORng>; Thu, 15 Nov 2001 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKORn1>; Thu, 15 Nov 2001 12:43:27 -0500
Received: from lol1122.lss.emc.com ([168.159.27.122]:3716 "EHLO
	lol1122.lss.emc.com") by vger.kernel.org with ESMTP
	id <S280809AbRKORnQ>; Thu, 15 Nov 2001 12:43:16 -0500
Date: Thu, 15 Nov 2001 12:43:11 -0500
Message-Id: <200111151743.fAFHhBU01902@lol1122.lss.emc.com>
To: linux-kernel@vger.kernel.org
From: Preston Crow <pc-lkml141101@crowcastle.net>
Subject: Re: Compile failed on fs.o for 2.4.15-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strange.  While adding a #include for <linux/spinlock.h> didn't work,
tossing in the #define for atomic_dec_and_lock() did the trick.

So now in fs/dcache.c, I have:


#include <linux/cache.h>
#include <linux/module.h>

#include <asm/uaccess.h>
#define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)

#define DCACHE_PARANOIA 1
/* #define DCACHE_DEBUG 1 */



I know that this isn't the right fix; hopefully that will be in -pre5.
Well, now that it compiles, it's time to boot...

[Please CC responses to me]

--PC
