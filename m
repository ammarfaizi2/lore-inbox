Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTGIJEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbTGIJD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:03:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265870AbTGIJD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:03:58 -0400
Date: Wed, 9 Jul 2003 02:18:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3
Message-Id: <20030709021849.31eb3aec.akpm@osdl.org>
In-Reply-To: <200307091106.00781.schlicht@uni-mannheim.de>
References: <20030708223548.791247f5.akpm@osdl.org>
	<200307091106.00781.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> This gives following compile error when compiling the kernel with APM support 
>  for UP:
> 
>  arch/i386/kernel/apm.c: In function `apm_bios_call':
>  arch/i386/kernel/apm.c:600: error: incompatible types in assignment
>  arch/i386/kernel/apm.c: In function `apm_bios_call_simple':
>  arch/i386/kernel/apm.c:643: error: incompatible types in assignment
> 
>  The attached patch fixes this...

Seems complex.  I just have this:


diff -puN arch/i386/kernel/apm.c~cpumask-apm-fix-2 arch/i386/kernel/apm.c
--- 25/arch/i386/kernel/apm.c~cpumask-apm-fix-2	2003-07-08 23:09:23.000000000 -0700
+++ 25-akpm/arch/i386/kernel/apm.c	2003-07-08 23:28:50.000000000 -0700
@@ -528,7 +528,7 @@ static inline void apm_restore_cpus(cpum
  *	No CPU lockdown needed on a uniprocessor
  */
  
-#define apm_save_cpus()	0
+#define apm_save_cpus()		CPU_MASK_NONE
 #define apm_restore_cpus(x)	(void)(x)
 
 #endif

_

