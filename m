Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136020AbRDVKgf>; Sun, 22 Apr 2001 06:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136021AbRDVKgY>; Sun, 22 Apr 2001 06:36:24 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:60420 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S136020AbRDVKgP>; Sun, 22 Apr 2001 06:36:15 -0400
Date: Sun, 22 Apr 2001 12:35:02 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Is the empty initializers bug fixed in gcc-3.0?
Message-ID: <Pine.LNX.4.33.0104221232330.10966-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This piece of code from include/linux/spinlock.h (linux-2.4.3) works
around a compiler bug with empty initializers. Does anybody know if this
bug has been fixed in gcc-3.0?

/*
 * Your basic spinlocks, allowing only a single CPU anywhere
 *
 * Most gcc versions have a nasty bug with empty initializers.
 */
#if (__GNUC__ > 2)
  typedef struct { } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
#else
  typedef struct { int gcc_is_buggy; } spinlock_t;
  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
#endif

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

