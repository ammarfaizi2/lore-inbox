Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271257AbTGQAFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271258AbTGQAFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:05:50 -0400
Received: from sponsa.its.UU.SE ([130.238.7.36]:58334 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S271257AbTGQAFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:05:49 -0400
Date: Thu, 17 Jul 2003 02:15:27 +0200 (MEST)
Message-Id: <200307170015.h6H0FRBX019953@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: m3thos@netcabo.pt
Subject: Re: 2.6.0-test1  doesn't compile on PPC iBook2.2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 22:14:40 +0100, Miguel Sousa Filipe wrote:
>   CC      arch/ppc/kernel/time.o
>arch/ppc/kernel/time.c: In function `do_settimeofday':
>arch/ppc/kernel/time.c:247: conflicting types for `new_nsec'
>arch/ppc/kernel/time.c:245: previous declaration of `new_nsec'
>arch/ppc/kernel/time.c:247: conflicting types for `new_sec'
>arch/ppc/kernel/time.c:244: previous declaration of `new_sec'
>make[1]: *** [arch/ppc/kernel/time.o] Error 1
>make: *** [arch/ppc/kernel] Error 2

Apply the following patch:

--- linux-2.6.0-test1/arch/ppc/kernel/time.c.~1~	2003-07-14 13:17:24.000000000 +0200
+++ linux-2.6.0-test1/arch/ppc/kernel/time.c	2003-07-14 19:06:58.000000000 +0200
@@ -244,7 +244,7 @@
 	time_t wtm_sec, new_sec = tv->tv_sec;
 	long wtm_nsec, new_nsec = tv->tv_nsec;
 	unsigned long flags;
-	int tb_delta, new_nsec, new_sec;
+	int tb_delta;
 
 	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
