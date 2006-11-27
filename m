Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758267AbWK0Ovm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbWK0Ovm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758266AbWK0Ovm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:51:42 -0500
Received: from nebensachen.de ([195.225.107.202]:53485 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S1758250AbWK0Ovl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:51:41 -0500
X-Hashcash: 1:20:061127:linux-ide@vger.kernel.org::paJtBF/EefTqCLoN:0000000000000000000000000000000000000EnS
X-Hashcash: 1:20:061127:stable@vger.kernel.org::QF6115/YC01xqDEb:0000000000000000000000000000000000000000+1j
From: Elias Oltmanns <eo@nebensachen.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
X-Hashcash: 1:20:061127:linux-kernel@vger.kernel.org::9VAZSrM+MkD2J1E3:0000000000000000000000000000000005XrG
Mail-Copies-To: nobody
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 27 Nov 2006 15:51:33 +0100
Message-ID: <87k61h3pu2.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Due to a typo in ide_start_power_step, the result of a function rather
than its pointer is assigned to args->handler. The patch applies to
2.6.19-rc6 but the problem exists in the stable branch as well.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ide-io.c.patch

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 2614f41..48a249d 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -213,7 +213,7 @@ static ide_startstop_t ide_start_power_s
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */

--=-=-=--
