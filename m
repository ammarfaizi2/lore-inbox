Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUE2NJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUE2NJI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUE2NJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:09:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53450 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264664AbUE2NJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:09:02 -0400
Date: Sat, 29 May 2004 15:08:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sds@epoch.ncsc.mil, jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] SECURITY_SELINUX depends on NET
Message-ID: <20040529130857.GP16099@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SECURITY_SELINUX=y and NET=n results in the following compile error in 
2.6.7-mm1:

<--  snip  -->

...
  LD      .tmp_vmlinux1
security/built-in.o(.text+0x97e4): In function `selnl_notify':
: undefined reference to `alloc_skb'
security/built-in.o(.text+0x988a): In function `selnl_notify':
: undefined reference to `netlink_broadcast'
security/built-in.o(.text+0x989e): In function `selnl_notify':
: undefined reference to `skb_over_panic'
security/built-in.o(.text+0x98ca): In function `selnl_notify':
: undefined reference to `__kfree_skb'
security/built-in.o(.init.text+0x2eb): In function `selnl_init':
: undefined reference to `netlink_kernel_create'
security/built-in.o(.init.text+0x303): In function `selnl_init':
: undefined reference to `netlink_set_nonroot'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue:


--- linux-2.6.7-rc1-mm1-full/security/selinux/Kconfig.old	2004-05-29 14:14:37.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/security/selinux/Kconfig	2004-05-29 14:22:42.000000000 +0200
@@ -1,6 +1,6 @@
 config SECURITY_SELINUX
 	bool "NSA SELinux Support"
-	depends on SECURITY
+	depends on SECURITY && NET
 	default n
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

