Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbSJLL1M>; Sat, 12 Oct 2002 07:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbSJLL1M>; Sat, 12 Oct 2002 07:27:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57105 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262892AbSJLL1L>; Sat, 12 Oct 2002 07:27:11 -0400
Date: Sat, 12 Oct 2002 12:32:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de
Subject: 2.5.42 broke ARM zImage/Image
Message-ID: <20021012123256.C12955@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get 2.5.42 to build on ARM, and I've finally run out of
ideas for things to try to get arch/arm/boot/Makefile and
arch/arm/boot/compressed/Makefile to work correctly.

What I'm seeing is:

/home/rmk/bin/arm-linux-ld -p -X -T vmlinux.lds head.o misc.o piggy.o /home/rmk/arm-linux/lib/gcc-lib/arm-linux/2.95.3/libgcc.a -o vmlinux
/home/rmk/bin/arm-linux-ld:vmlinux.lds:14: parse error
make[2]: *** [vmlinux] Error 1
make[1]: *** [compressed/vmlinux] Error 2
make: *** [zImage] Error 2

This appears to be because ZRELADDR is not passed from arch/arm/boot/Makefile
to arch/arm/boot/compressed/Makefile.  You may think this is fairly trivial
to fix, just export it.  However, it is already exported with a bunch of
other symbols.  Other symbols seem to make it through to compressed/Makefile
though.

I've tried many things, like including $(TOPDIR) Rules.make at the top of
arch/arm/boot/Makefile, but this doesn't seem to make any difference what
so ever.

Help!

Unless this can be solved, I'm going to be pushing _compile only_ tested
stuff to Linus in the forthcoming weeks until someone can provide some
hints as to what and why this broke.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

