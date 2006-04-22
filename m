Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWDVSdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWDVSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWDVSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:33:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750875AbWDVSdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:33:24 -0400
Date: Sat, 22 Apr 2006 08:05:48 -0700
Message-Id: <200604221505.k3MF5mql022083@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] revert bh_lru_lock() to preempt_disable()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The bh_lru_lock() was set to disable interrupt to protect
from IPI's, which are only on SMP . So I don't think it's needed
in UP PREEMPT_RT configs. 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/fs/buffer.c
===================================================================
--- linux-2.6.16.orig/fs/buffer.c
+++ linux-2.6.16/fs/buffer.c
@@ -1326,7 +1326,7 @@ struct bh_lru {
 
 static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+#if defined(CONFIG_SMP) 
 #define bh_lru_lock()	local_irq_disable()
 #define bh_lru_unlock()	local_irq_enable()
 #else
