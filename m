Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265742AbSKAUwU>; Fri, 1 Nov 2002 15:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265746AbSKAUwU>; Fri, 1 Nov 2002 15:52:20 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9105 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265742AbSKAUvz>;
	Fri, 1 Nov 2002 15:51:55 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 1 Nov 2002 21:57:49 +0100 (MET)
Message-Id: <UTC200211012057.gA1KvnH22138.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: mount
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll feed it

OK

> statbuf.st_rdev>>8
>                ^^^

> switching to major(statbuf.st_rdev) would probably be a good idea

Now that you suggested this, done.
But a good idea?

Since 1995 I have off and on run a system with 32-bit or 64-bit dev_t.
But <sys/sysmacros.h> has
    # define major(dev) ((int)(((dev) >> 8) & 0xff))
    # define minor(dev) ((int)((dev) & 0xff))
and I really mean
    statbuf.st_rdev>>8
not
    (statbuf.st_rdev>>8) & 0xff
so a private macro major() is needed, different from the glibc one.

Andries


[You must have seen my setup a few times: if all nonzero bits
are among the last 16, then read it as 8+8, otherwise, if
all nonzero bits are among the last 32, read it as 16+16,
otherwise read it as 32+32. That way old device numbers
do not change when dev_t grows. That way some ambiguity in
isofs mastering is resolved cleanly.]
