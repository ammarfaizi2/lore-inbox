Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWF1Qzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWF1Qzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWF1Qzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751465AbWF1Qze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:34 -0400
Date: Wed, 28 Jun 2006 18:55:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: [2.6 patch] i386: KEXEC must depend on (!SMP && X86_LOCAL_APIC)
Message-ID: <20060628165533.GJ13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following issue with CONFIG_SMP=y and 
CONFIG_X86_VOYAGER=y:

<--  snip  -->

...
  CC      arch/i386/kernel/crash.o
arch/i386/kernel/crash.c: In function ‘crash_nmi_callback’:
arch/i386/kernel/crash.c:113: error: implicit declaration of function ‘disable_local_APIC’

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm3-full/arch/i386/Kconfig.old	2006-06-28 18:13:15.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/i386/Kconfig	2006-06-28 18:21:32.000000000 +0200
@@ -748,7 +748,7 @@
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && (!SMP || X86_LOCAL_APIC)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot

