Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTBKHEa>; Tue, 11 Feb 2003 02:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTBKHEa>; Tue, 11 Feb 2003 02:04:30 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:21155 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267158AbTBKHE3>; Tue, 11 Feb 2003 02:04:29 -0500
Message-Id: <200302110714.h1B7EA3A006209@eeyore.valparaiso.cl>
To: Art Haas <ahaas@airmail.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is -fno-strict-aliasing still needed? 
In-Reply-To: Your message of "Mon, 10 Feb 2003 14:04:34 CST."
             <20030210200434.GA376@debian> 
Date: Tue, 11 Feb 2003 08:14:09 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas <ahaas@airmail.net> said:
> I ask because I've just built a kernel without using that flag -
> linus-2.5 BK from this morning, probably missing the 2.5.60 release by
> a few hours.

The problem with strict aliasing is that it allows the compiler to assume
that in:

     void somefunc(int *foo, int *bar)

foo and bar will _*never*_ point to the same memory area (at the same
struct, or into the same array, etc). There is no way to check for this in
the compiler in general (the function and the call might be in different
files, many functions are being called via pointers, ...).

That it did not bite you (yet, or perhaps you haven't noticed) doesn't mean
anything. Perhaps the compiler didn't make use of it (as of this version),
perhaps you did not hit a problem with optimized code (yet). Or perhaps the
kernel is clean WRT this. Your bet.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
