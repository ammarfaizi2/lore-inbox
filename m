Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281811AbRKQTjQ>; Sat, 17 Nov 2001 14:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281812AbRKQTjE>; Sat, 17 Nov 2001 14:39:04 -0500
Received: from smtp.jadedirect.com ([143.96.9.53]:27148 "EHLO
	cnwchcm6.cnw.co.nz") by vger.kernel.org with ESMTP
	id <S281811AbRKQTjA>; Sat, 17 Nov 2001 14:39:00 -0500
Message-Id: <200111171938.IAA14721@cnwchcm6.cnw.co.nz>
Date: Sat, 17 Nov 2001 19:38:57 -0000
To: <linux-kernel@vger.kernel.org>
Subject: Re: Alpha XLT 366 fails to boot kernel >= 2.4.14
From: "Matthew Gregan" <mgregan@jade.co.nz>
X-Mailer: TWIG 2.7.4
Cc: <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Gregan <mgregan@jade.co.nz> said:

Linus, please consider including the attached patch in 2.4.15.

> My Alpha XLT 366 fails to boot kernels 2.4.14 and higher - the problem
> appears to be related to the cpu_hz struct added in (I think)
> 2.4.14-pre8 or detection of the CPU (EV5, EV56, etc.)

I'm now fairly sure the problem lies in the min/max settings in cpu_hz.

See: http://www.support.compaq.com/alpha-tools/info/system-codes.html

There are EV5 CPUs listed from 250 up to 366 MHz, and EV56 CPUs listed 
from 333 up to 667 MHz.

> I have attached a patch to fix cpu_hz, which gets the machine booting
> with 2.4.15-pre5.

I've included an updated patch that sets the min/max values in cpu_hz in 
arch/alpha/kernel/time.c to more correct values for EV5 and EV56 - I 
haven't verified that the other CPU types have correct min/max values.

diff -urN linux-2.4.15-pre5.orig/arch/alpha/kernel/time.c linux-2.4.15-pre5/arch/alpha/kernel/time.c
--- linux-2.4.15-pre5.orig/arch/alpha/kernel/time.c     Sun Nov 18 00:17:55 2001
+++ linux-2.4.15-pre5/arch/alpha/kernel/time.c  Sun Nov 18 08:00:20 2001
@@ -186,8 +186,8 @@
                [EV4_CPU]    = {  150000000,  300000000 },
                [LCA4_CPU]   = {  150000000,  300000000 },      /* guess */
                [EV45_CPU]   = {  200000000,  300000000 },
-               [EV5_CPU]    = {  266000000,  333333333 },
-               [EV56_CPU]   = {  366000000,  667000000 },
+               [EV5_CPU]    = {  250000000,  433000000 },
+               [EV56_CPU]   = {  333000000,  667000000 },
                [PCA56_CPU]  = {  400000000,  600000000 },      /* guess */
                [PCA57_CPU]  = {  500000000,  600000000 },      /* guess */
                [EV6_CPU]    = {  466000000,  600000000 },

Cheers,
Matthew.

-- 
Matthew Gregan                                     Operations Consultant
JADE Direct Central Systems                            NZ: 0 800 65 2266
Aoraki Corporation Limited                             AU: 1 800 12 0181
PO Box 20-152, Christchurch 8005                     Cell: +64 2977 8839
New Zealand                                           Fax: +64 3358 7156



