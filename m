Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbTGIJYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbTGIJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:24:09 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:1030 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265886AbTGIJYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:24:04 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@osdl.org>,
       Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: Re: 2.5.74-mm3
Date: Wed, 9 Jul 2003 11:38:07 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307091106.00781.schlicht@uni-mannheim.de> <20030709021849.31eb3aec.akpm@osdl.org>
In-Reply-To: <20030709021849.31eb3aec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/J+C/lr2RPX5B5R"
Message-Id: <200307091138.07580.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/J+C/lr2RPX5B5R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 09 July 2003 11:18, Andrew Morton wrote:

Hi Andrew,

> >  arch/i386/kernel/apm.c: In function `apm_bios_call':
> >  arch/i386/kernel/apm.c:600: error: incompatible types in assignment
> >  arch/i386/kernel/apm.c: In function `apm_bios_call_simple':
> >  arch/i386/kernel/apm.c:643: error: incompatible types in assignment
> >  The attached patch fixes this...
> Seems complex.  I just have this:
>
>
> diff -puN arch/i386/kernel/apm.c~cpumask-apm-fix-2 arch/i386/kernel/apm.c
> --- 25/arch/i386/kernel/apm.c~cpumask-apm-fix-2	2003-07-08
> 23:09:23.000000000 -0700 +++ 25-akpm/arch/i386/kernel/apm.c	2003-07-08
> 23:28:50.000000000 -0700 @@ -528,7 +528,7 @@ static inline void
> apm_restore_cpus(cpum
>   *	No CPU lockdown needed on a uniprocessor
>   */
>
> -#define apm_save_cpus()	0
> +#define apm_save_cpus()		CPU_MASK_NONE
>  #define apm_restore_cpus(x)	(void)(x)
>
>  #endif
>
better use the attached one ;)

ciao, Marc

--Boundary-00=_/J+C/lr2RPX5B5R
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="15_fixup-apm-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="15_fixup-apm-small.patch"

diff -puN arch/i386/kernel/apm.c~cpumask-apm-fix-2 arch/i386/kernel/apm.c
--- 25/arch/i386/kernel/apm.c~cpumask-apm-fix-2	2003-07-08 23:09:23.000000000 -0700
+++ 25-akpm/arch/i386/kernel/apm.c	2003-07-08 23:28:50.000000000 -0700
@@ -222,6 +222,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/cpumask.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -528,7 +529,7 @@ static inline void apm_restore_cpus(cpum
  *	No CPU lockdown needed on a uniprocessor
  */
  
-#define apm_save_cpus()	0
+#define apm_save_cpus()		CPU_MASK_NONE
 #define apm_restore_cpus(x)	(void)(x)
 
 #endif

--Boundary-00=_/J+C/lr2RPX5B5R--

