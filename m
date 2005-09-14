Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVINPyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVINPyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVINPyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:54:36 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:65214 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030209AbVINPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:54:34 -0400
Date: Wed, 14 Sep 2005 17:54:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/7] s390: crypto driver patch take 2.
Message-ID: <20050914155436.GC11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/7] s390: crypto driver patch take 2.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Got confused with the crypto update. The last patch added a call to
destroy_workqueue() for a non-existent workqueue with the comment
"Remove device workqueue on module unload". This is nonsense.
Remove the offending hunk again.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/z90main.c |    3 ---
 1 files changed, 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2005-09-14 16:47:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2005-09-14 16:48:16.000000000 +0200
@@ -682,9 +682,6 @@ z90crypt_cleanup_module(void)
 	del_timer(&config_timer);
 	del_timer(&cleanup_timer);
 
-	if (z90_device_work)
-		destroy_workqueue(z90_device_work);
-
 	destroy_z90crypt();
 
 	PRINTKN("Unloaded.\n");
