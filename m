Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbRGOXMO>; Sun, 15 Jul 2001 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbRGOXLz>; Sun, 15 Jul 2001 19:11:55 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:10245 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267120AbRGOXLn>;
	Sun, 15 Jul 2001 19:11:43 -0400
Message-Id: <200107151421.f6FELj7H003177@sleipnir.valparaiso.cl>
To: kaih@khms.westfalen.de (Kai Henningsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: __KERNEL__ removal 
In-Reply-To: Your message of "15 Jul 2001 13:53:00 +0200."
             <84uhW6amw-B@khms.westfalen.de> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 15 Jul 2001 10:21:44 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) said:

[...]

> ... but if we are looking for a clean solution to types and constants that  
> are needed to communicate between kernel and user space, IMO the thing to  
> do is to define these in some sort of generic format, and have a tool to  
> generate actual headers from that according to whatever kernel, libc or  
> whoever wants to see. Possibly more than one tool as requirements differ.

Much easier, plain C, no special tools:

   include/linux/...
   include/asm/...
   include/glibc/...

where .../glibc/xyz.h contains the shared parts, and the others feel
free to include that as needed.

The real problem is that the interfaces _do_ change, as new syscalls,
ioctls, and constants show up (so "one set of .h for userland, cast in
stone for all eternity" won't _ever_ do), and that parts of the userland
are tightly bound to the kernel, and _need_ inside knowledge (strace, the
tools for manipulating modules, ...). Plus glibc and userland also
changes...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
