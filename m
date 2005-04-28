Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVD1HXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVD1HXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVD1HXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:23:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:20664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261911AbVD1HXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:23:33 -0400
Date: Thu, 28 Apr 2005 00:22:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, pavel@suse.cz, zwane@linuxpower.ca
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-Id: <20050428002254.461fcf32.akpm@osdl.org>
In-Reply-To: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
>  disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
>  original S4 SMP patch.



On ia64, with tiger_defconfig:

kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
: undefined reference to `disable_nonboot_cpus'
kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
: undefined reference to `enable_nonboot_cpus'
kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
: undefined reference to `enable_nonboot_cpus'


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/suspend.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/suspend.h~suspend-resume-smp-support-fix include/linux/suspend.h
--- 25/include/linux/suspend.h~suspend-resume-smp-support-fix	Thu Apr 28 15:12:21 2005
+++ 25-akpm/include/linux/suspend.h	Thu Apr 28 15:13:13 2005
@@ -58,7 +58,7 @@ static inline int software_suspend(void)
 }
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_SOFTWARE_SUSPEND)
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
_

