Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUIAP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUIAP6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIAP6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:58:03 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:57778 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267251AbUIAPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:43 -0400
Date: Wed, 1 Sep 2004 16:51:20 +0100
Message-Id: <200409011551.i81FpKKf000590@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix leak in eicon debug code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/isdn/hardware/eicon/debug.c linux-2.6/drivers/isdn/hardware/eicon/debug.c
--- bk-linus/drivers/isdn/hardware/eicon/debug.c	2004-08-31 23:13:09.000000000 +0100
+++ linux-2.6/drivers/isdn/hardware/eicon/debug.c	2004-09-01 13:31:10.000000000 +0100
@@ -891,6 +891,7 @@ void diva_mnt_add_xdi_adapter (const DES
     if (clients[id].hDbg && (clients[id].request == d->request)) {
       diva_os_leave_spin_lock (&dbg_q_lock, &old_irql, "register");
       diva_os_leave_spin_lock (&dbg_adapter_lock, &old_irql1, "register");
+      diva_os_free(0, pmem);
       return;
     }
     if (clients[id].hDbg) { /* slot is busy */
