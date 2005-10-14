Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVJNSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVJNSmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVJNSmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:42:35 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:54189 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750856AbVJNSme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:42:34 -0400
Subject: Re: 2.6.14-rc4-rt4
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
From: John Rigg <lk@sound-man.co.uk>
Message-Id: <E1EQUbp-0001Lq-Bh@localhost.localdomain>
Date: Fri, 14 Oct 2005 19:48:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri October 14 Badari Pulavarty wrote:

>I am able to apply cleanly. I am trying to see if it fixes my problem
>or not.

Something in 2.6.14-rc4-rt4 breaks compilation with my config (with or
without the extra patch) with following error message:

  CC      kernel/ktimers.o
kernel/ktimers.c: In function 'check_ktimer_signal':
kernel/ktimers.c:1100: error: request for member 'tv' in something not a structure or union

Am about to try applying the change in the patch to -rt1, which I know
compiles.

John

>--- linux-2.6.14-rc4.org/arch/x86_64/kernel/vsyscall.c  2005-10-07 10:27:33.000000000 -0700
>+++ linux-2.6.14-rc4/arch/x86_64/kernel/vsyscall.c      2005-10-14 05:11:02.000000000 -0700
>@@ -34,7 +34,7 @@
> #include <asm/errno.h>
> #include <asm/io.h>
>
>-#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
>+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr))) notrace
> #define force_inline __attribute__((always_inline)) inline
>
> int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
>
