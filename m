Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWBHD0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWBHD0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWBHDSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57728 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751140AbWBHDSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:22 -0500
To: torvalds@osdl.org
Subject: [PATCH 06/29] restore power-off on sparc32
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Message-Id: <E1F6fqY-0006Bq-0X@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1137631248 -0500

Fixing Eric's breakage created when he overloaded pm_power_off and ended
up disabling poweroff on a bunch of platforms...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

304cd3efe6f2aefdb568d201aba55d1400915ca2
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index fbb05a4..118cac8 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -54,7 +54,7 @@ void (*pm_idle)(void);
  * This is done via auxio, but could be used as a fallback
  * handler when auxio is not present-- unused for now...
  */
-void (*pm_power_off)(void);
+void (*pm_power_off)(void) = machine_power_off;
 
 /*
  * sysctl - toggle power-off restriction for serial console 
-- 
0.99.9.GIT

