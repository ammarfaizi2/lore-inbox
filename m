Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbSJMNJl>; Sun, 13 Oct 2002 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJMNJk>; Sun, 13 Oct 2002 09:09:40 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:34003 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261516AbSJMNJd>; Sun, 13 Oct 2002 09:09:33 -0400
Message-ID: <4649460.1034514705718.JavaMail.nobody@web11.us.oracle.com>
Date: Sun, 13 Oct 2002 05:11:45 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: felix.seeger@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 compile error in timers/timer_tsc.c
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_124_6447144.1034514705715"
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_124_6447144.1034514705715
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Hi
> I get this:
>   gcc -Wp,-MD,arch/i386/kernel/timers/.timer.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=timer   -c -o arch/i386/kernel/timers/timer.o 
> arch/i386/kernel/timers/timer.c
>   gcc -Wp,-MD,arch/i386/kernel/timers/.timer_tsc.o.d -D__KERNEL__ -Iinclude 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=timer_tsc   -c -o arch/i386/kernel/timers/timer_tsc.o 
> arch/i386/kernel/timers/timer_tsc.c
> arch/i386/kernel/timers/timer_tsc.c: In function `time_cpufreq_notifier':
> arch/i386/kernel/timers/timer_tsc.c:181: `CPUFREQ_PRECHANGE' undeclared (first 
> use in this function)

[snip]

Attached patch (which simply includes<linux/cpufreq.h>) makes it compile. Don't know
 whether it's the Right Fix (TM), so...

--alessandro
------=_Part_124_6447144.1034514705715
Content-Type: application/octet-stream; name=cpufreq.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cpufreq.diff

--- timer_tsc.c.orig	Sun Oct 13 00:43:36 2002
+++ timer_tsc.c	Sun Oct 13 00:43:11 2002
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>
+#include <linux/cpufreq.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>

------=_Part_124_6447144.1034514705715--

