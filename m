Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTDULX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDULX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:23:59 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:18374 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263813AbTDULX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:23:58 -0400
Date: Mon, 21 Apr 2003 13:35:57 +0200 (MEST)
Message-Id: <200304211135.h3LBZvb5019982@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org
Subject: build failure due to scripts/modpost.c compile error since 2.5.67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.67 and .68 don't build on RH6.2 / glibc-2.1.3 / i386.
The initial 'make oldconfig' results in:

make -f scripts/Makefile.build obj=scripts
  gcc -Wp,-MD,scripts/.modpost.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/modpost.o scripts/modpost.c
scripts/modpost.c: In function `handle_modversions':
scripts/modpost.c:302: `STT_REGISTER' undeclared (first use in this function)
scripts/modpost.c:302: (Each undeclared identifier is reported only once
scripts/modpost.c:302: for each function it appears in.)
make[1]: *** [scripts/modpost.o] Error 1
make: *** [scripts] Error 2

2.5.67 added a check for a SPARC-specific elf thingy (STT_REGISTER)
in modpost.c and include/linux/elf.h. However, script/modpost.c
#includes glibc's elf.h not the kernel's. Older glibcs don't have
this constant, resulting in a compile error.

#ifndef STT_REGISTER at the offending code in modpost.c works
around the problem, but I assume the real fix is to make modpost.c
#include from the kernel's include dir instead.

/Mikael
