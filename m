Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263848AbTCUTGf>; Fri, 21 Mar 2003 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbTCUTF0>; Fri, 21 Mar 2003 14:05:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11531 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S263848AbTCUTDf>; Fri, 21 Mar 2003 14:03:35 -0500
Date: Fri, 21 Mar 2003 14:14:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.65] Broken gcc test
Message-ID: <Pine.LNX.4.44.0303211407180.7786-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that a test for the frame pointer gcc bug was incorrectly added 
to the build process, rejecting all 2.96 compilers (which generate better 
code than 3.2) instead of just the broken ones.




  gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=main -DKBUILD_MODNAME=main -c -o init/main.o init/main.c
init/main.c:49:2: #error This compiler cannot compile correctly with frame 
pointers enabled
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

oddball:davidsen> gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)

