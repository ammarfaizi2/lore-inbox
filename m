Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269585AbUHZUSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269585AbUHZUSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269567AbUHZUNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:13:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50659 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269494AbUHZUE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:04:57 -0400
Date: Thu, 26 Aug 2004 22:04:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch][5/6] asm-i386/smpboot.h: fix gcc 3.4 compilation
Message-ID: <20040826200444.GG12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to build 2.4.28-pre2 using
gcc 3.4:

<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=process  -c -o process.o process.c
In file included from process.c:47:
/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include/asm/smpboot.h: 
In function `target_cpus':
/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include/asm/smpboot.h:133: 
error: label at end of compound statement
make[1]: *** [process.o] Error 1
make[1]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/arch/i386/kernel'

<--  snip  -->


The patch below fixes this issue.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-full/include/asm-i386/smpboot.h.old	2004-08-26 19:45:06.000000000 +0200
+++ linux-2.4.28-pre2-full/include/asm-i386/smpboot.h	2004-08-26 19:48:47.000000000 +0200
@@ -130,8 +130,8 @@
 			cpu = (cpu+1)%smp_num_cpus;
 			return cpu_to_physical_apicid(cpu);
 		default:
+			return cpu_online_map;
 	}
-	return cpu_online_map;
 }
 #else
 #define target_cpus() (cpu_online_map)

