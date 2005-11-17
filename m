Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVKQX5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVKQX5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVKQX5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:57:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965135AbVKQX5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:57:02 -0500
Date: Fri, 18 Nov 2005 00:57:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ebiederm@xmission.com, rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: [2.6 patch] i386 KEXEC must depend on X86_CMPXCHG64
Message-ID: <20051117235700.GJ11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with 
CONFIG_X86_CMPXCHG64=n:

<--  snip  -->

...
  CC      arch/i386/kernel/machine_kexec.o
arch/i386/kernel/machine_kexec.c: In function 'identity_map_page':
arch/i386/kernel/machine_kexec.c:78: error: implicit declaration of function 'set_64bit'
make[1]: *** [arch/i386/kernel/machine_kexec.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm1-full/arch/i386/Kconfig.old	2005-11-18 00:44:29.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/arch/i386/Kconfig	2005-11-18 00:45:11.000000000 +0100
@@ -662,7 +662,7 @@
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && X86_CMPXCHG64
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot

