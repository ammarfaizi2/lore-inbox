Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbTGIJKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbTGIJKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:10:00 -0400
Received: from waste.org ([209.173.204.2]:57278 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265848AbTGIJJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:09:59 -0400
Date: Wed, 9 Jul 2003 04:24:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3
Message-ID: <20030709092433.GA27280@waste.org>
References: <20030708223548.791247f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708223548.791247f5.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 10:35:48PM -0700, Andrew Morton wrote:
>  Merged
> 
> -cpumask_t-1.patch
> -gcc-bug-workaround.patch
> -sparse-apic-fix.patch
> -nuke-cpumask_arith.patch
> -p4-clockmod-cpumask-fix.patch
> 
>  Folded into cpumask_t-1.patch
> 
> +cpumask_t-s390-fix.patch
> +kgdb-cpumask_t.patch
> +cpumask_t-x86_64-fix.patch
> +sparc64-cpumask_t-fix.patch
> 
>  cpumask_t fixes

UP APM has broken since -mm2, looks like something like this is
needed (compiles, untested):

diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/arch/i386/kernel/apm.c patched/arch/i386/kernel/apm.c
--- orig/arch/i386/kernel/apm.c	2003-07-09 04:07:06.000000000 -0500
+++ patched/arch/i386/kernel/apm.c	2003-07-09 04:19:52.000000000 -0500
@@ -528,7 +528,7 @@
  *	No CPU lockdown needed on a uniprocessor
  */
  
-#define apm_save_cpus()	0
+#define apm_save_cpus()	(current->cpus_allowed)
 #define apm_restore_cpus(x)	(void)(x)
 
 #endif

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
