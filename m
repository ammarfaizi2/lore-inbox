Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJGVky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJGVky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUJGViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:38:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:28811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268229AbUJGVhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:37:01 -0400
Date: Thu, 7 Oct 2004 14:40:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3: build problem on dual-Opteron w/ NUMA
Message-Id: <20041007144045.29e64ef0.akpm@osdl.org>
In-Reply-To: <200410072301.39399.rjw@sisk.pl>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410072301.39399.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday 07 of October 2004 10:51, Andrew Morton
> > 
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/
> 
> It does not build on a dual-Opteron box w/ NUMA:
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x1fc1): In function 
> `late_hpet_init':
> : undefined reference to `hpet_alloc'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The .config is available at:
> http://www.sisk.pl/kernel/041007/2.6.9-rc3-mm3-NUMA.config

akpm:/home/akpm> grep HPET 2.6.9-rc3-mm3-NUMA.config
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_HPET is not set

I'll take a punt and assume that CONFIG_HPET_TIMER requires CONFIG_HPET.


diff -puN arch/x86_64/Kconfig~hpet-dependency-fix arch/x86_64/Kconfig
--- 25/arch/x86_64/Kconfig~hpet-dependency-fix	Thu Oct  7 14:38:35 2004
+++ 25-akpm/arch/x86_64/Kconfig	Thu Oct  7 14:38:50 2004
@@ -60,6 +60,7 @@ config EARLY_PRINTK
 
 config HPET_TIMER
 	bool
+	depends on HPET
 	default y
 	help
 	  Use the IA-PC HPET (High Precision Event Timer) to manage
diff -puN arch/i386/Kconfig~hpet-dependency-fix arch/i386/Kconfig
--- 25/arch/i386/Kconfig~hpet-dependency-fix	Thu Oct  7 14:39:03 2004
+++ 25-akpm/arch/i386/Kconfig	Thu Oct  7 14:39:13 2004
@@ -429,6 +429,7 @@ config X86_OOSTORE
 
 config HPET_TIMER
 	bool "HPET Timer Support"
+	depends on HPET
 	help
 	  This enables the use of the HPET for the kernel's internal timer.
 	  HPET is the next generation timer replacing legacy 8254s.
_

