Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQLKDAr>; Sun, 10 Dec 2000 22:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbQLKDA2>; Sun, 10 Dec 2000 22:00:28 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:26637 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129450AbQLKDAS>; Sun, 10 Dec 2000 22:00:18 -0500
Date: Sun, 10 Dec 2000 20:29:44 -0600
To: Linus Torvalds <torvalds@transmeta.com>, Ralf Baechle <ralf@gnu.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre8
Message-ID: <20001210202944.Y6567@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10012101014000.3153-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012101014000.3153-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 10, 2000 at 10:18:00AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Linus]
>  - pre8:

Small thinko in arch/mips64/Makefile, looks like.

--- 2.4.0test12pre8/arch/mips64/Makefile~	Sun Dec 10 20:07:02 2000
+++ 2.4.0test12pre8/arch/mips64/Makefile	Sun Dec 10 20:13:07 2000
@@ -33,7 +33,7 @@
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-CFLAGS		+= -I $(TOPDIR)/include/asm $(CFLAGS)
+CFLAGS		:= -I $(TOPDIR)/include/asm $(CFLAGS)
 CFLAGS		+= -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls


But that brings up the question: why does mips64 need to specify the
'-I $(TOPDIR)/include/asm-mips64' at all?  A quick grep through
arch/mips64 and include/asm-mips64 does not reveal any reason.

So AFAICS it should actually be

--- 2.4.0test12pre8/arch/mips64/Makefile~	Sun Dec 10 20:07:02 2000
+++ 2.4.0test12pre8/arch/mips64/Makefile	Sun Dec 10 20:13:07 2000
@@ -33,7 +33,6 @@
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-CFLAGS		+= -I $(TOPDIR)/include/asm $(CFLAGS)
 CFLAGS		+= -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls


Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
