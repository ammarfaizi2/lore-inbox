Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVCOMT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVCOMT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVCOMT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:19:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261194AbVCOMTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:19:35 -0500
Date: Tue, 15 Mar 2005 13:19:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: shemminger@osdl.org, bridge@osdl.org, chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.co,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050315121930.GE3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_BRIDGE=y and 
CONFIG_ATM_LANE=m:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o(.init.text+0x3ad1): In function `br_init':
: undefined reference to `br_fdb_get_hook'
net/built-in.o(.init.text+0x3adb): In function `br_init':
: undefined reference to `br_fdb_put_hook'
net/built-in.o(.exit.text+0xa2): In function `br_deinit':
: undefined reference to `br_fdb_get_hook'
net/built-in.o(.exit.text+0xac): In function `br_deinit':
: undefined reference to `br_fdb_put_hook'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/bridge/br.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.11-mm3-modular/net/bridge/br.c.old	2005-03-15 03:23:10.000000000 +0100
+++ linux-2.6.11-mm3-modular/net/bridge/br.c	2005-03-15 03:24:05.000000000 +0100
@@ -22,7 +22,7 @@
 
 #include "br_private.h"
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+#if defined(CONFIG_ATM_LANE) || (defined(CONFIG_ATM_LANE_MODULE) && defined(MODULE))
 #include "../atm/lec.h"
 #endif
 
@@ -39,7 +39,7 @@
 	brioctl_set(br_ioctl_deviceless_stub);
 	br_handle_frame_hook = br_handle_frame;
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+#if defined(CONFIG_ATM_LANE) || (defined(CONFIG_ATM_LANE_MODULE) && defined(MODULE))
 	br_fdb_get_hook = br_fdb_get;
 	br_fdb_put_hook = br_fdb_put;
 #endif
@@ -60,7 +60,7 @@
 
 	synchronize_net();
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+#if defined(CONFIG_ATM_LANE) || (defined(CONFIG_ATM_LANE_MODULE) && defined(MODULE))
 	br_fdb_get_hook = NULL;
 	br_fdb_put_hook = NULL;
 #endif

