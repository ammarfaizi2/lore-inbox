Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUE2NBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUE2NBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUE2NBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:01:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27339 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264648AbUE2NBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:01:10 -0400
Date: Sat, 29 May 2004 15:01:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: golbi@mat.uni.torun.pl, wrona@mat.uni.torun.pl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] POSIX_MQUEUE depends on NET
Message-ID: <20040529130102.GO16099@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX_MQUEUE=y and NET=n results in the following compile error in 
2.6.7-mm1:

<--  snip  -->

...
  LD      .tmp_vmlinux1
ipc/built-in.o(.text+0x50fd): In function `__do_notify':
: undefined reference to `netlink_sendskb'
ipc/built-in.o(.text+0x52a1): In function `remove_notification':
: undefined reference to `netlink_sendskb'
ipc/built-in.o(.text+0x5c23): In function `sys_mq_notify':
: undefined reference to `netlink_detachskb'
ipc/built-in.o(.text+0x5c50): In function `sys_mq_notify':
: undefined reference to `__kfree_skb'
ipc/built-in.o(.text+0x5d34): In function `sys_mq_notify':
: undefined reference to `alloc_skb'
ipc/built-in.o(.text+0x5da9): In function `sys_mq_notify':
: undefined reference to `netlink_getsockbyfilp'
ipc/built-in.o(.text+0x5dd6): In function `sys_mq_notify':
: undefined reference to `netlink_attachskb'
ipc/built-in.o(.text+0x5dfb): In function `sys_mq_notify':
: undefined reference to `skb_over_panic'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.6.7-rc1-mm1-full/init/Kconfig.old	2004-05-29 14:39:13.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/init/Kconfig	2004-05-29 14:39:25.000000000 +0200
@@ -92,7 +92,7 @@
 
 config POSIX_MQUEUE
 	bool "POSIX Message Queues"
-	depends on EXPERIMENTAL
+	depends on NET && EXPERIMENTAL
 	---help---
 	  POSIX variant of message queues is a part of IPC. In POSIX message
 	  queues every message has a priority which decides about succession


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

