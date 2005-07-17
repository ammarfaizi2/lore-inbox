Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVGQUeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGQUeB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVGQUeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:34:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28943 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261385AbVGQUd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:33:59 -0400
Date: Sun, 17 Jul 2005 22:33:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerrit Huizenga <gh@us.ibm.com>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>,
       Vivek Kashyap <vivk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] CKRM_TYPE_SOCKETCLASS must depend on INET
Message-ID: <20050717203354.GC3753@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CKRM_TYPE_SOCKETCLASS=y, NET=n, INET=n results in the following link 
error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `cb_sockclass_listen_stop':
ckrm_sockc.c:(.text+0x27e2b): undefined reference to `sk_free'
kernel/built-in.o: In function `ckrm_sock_forced_reclassify_ns':
ckrm_sockc.c:(.text+0x280d5): undefined reference to 
`tcp_v4_lookup_listener'
ckrm_sockc.c:(.text+0x280e4): undefined reference to `lock_sock'
ckrm_sockc.c:(.text+0x28134): undefined reference to `release_sock'
ckrm_sockc.c:(.text+0x28154): undefined reference to `sk_free'
kernel/built-in.o: In function `ckrm_sock_reclassify_class':
ckrm_sockc.c:(.text+0x2851e): undefined reference to `lock_sock'
ckrm_sockc.c:(.text+0x2853b): undefined reference to `release_sock'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/init/Kconfig.old	2005-07-17 21:45:25.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/init/Kconfig	2005-07-17 21:46:03.000000000 +0200
@@ -184,7 +184,7 @@
 
 config CKRM_TYPE_SOCKETCLASS
 	bool "Class Manager for socket groups"
-	depends on CKRM && RCFS_FS
+	depends on INET && CKRM && RCFS_FS
 	default y
 	help
 	  SOCKET provides the extensions for CKRM to track per socket

