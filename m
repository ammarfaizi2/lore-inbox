Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWJXQlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWJXQlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWJXQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:25538 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030327AbWJXQj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:39:58 -0400
Message-Id: <20061024163813.437824000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:17 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 04/16] spufs: "stataus" isnt a word.
Content-Disposition: inline; filename=spufs-status-spelling-fix.diff
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -102,7 +102,7 @@ static inline int check_spu_isolate(stru
 	 *     saved at this time.
 	 */
 	isolate_state = SPU_STATUS_ISOLATED_STATE |
-	    SPU_STATUS_ISOLATED_LOAD_STAUTUS | SPU_STATUS_ISOLATED_EXIT_STAUTUS;
+	    SPU_STATUS_ISOLATED_LOAD_STATUS | SPU_STATUS_ISOLATED_EXIT_STATUS;
 	return (in_be32(&prob->spu_status_R) & isolate_state) ? 1 : 0;
 }
 
@@ -1046,12 +1046,12 @@ static inline int suspend_spe(struct spu
 	 */
 	if (in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING) {
 		if (in_be32(&prob->spu_status_R) &
-		    SPU_STATUS_ISOLATED_EXIT_STAUTUS) {
+		    SPU_STATUS_ISOLATED_EXIT_STATUS) {
 			POLL_WHILE_TRUE(in_be32(&prob->spu_status_R) &
 					SPU_STATUS_RUNNING);
 		}
 		if ((in_be32(&prob->spu_status_R) &
-		     SPU_STATUS_ISOLATED_LOAD_STAUTUS)
+		     SPU_STATUS_ISOLATED_LOAD_STATUS)
 		    || (in_be32(&prob->spu_status_R) &
 			SPU_STATUS_ISOLATED_STATE)) {
 			out_be32(&prob->spu_runcntl_RW, SPU_RUNCNTL_STOP);
@@ -1085,7 +1085,7 @@ static inline void clear_spu_status(stru
 	 */
 	if (!(in_be32(&prob->spu_status_R) & SPU_STATUS_RUNNING)) {
 		if (in_be32(&prob->spu_status_R) &
-		    SPU_STATUS_ISOLATED_EXIT_STAUTUS) {
+		    SPU_STATUS_ISOLATED_EXIT_STATUS) {
 			spu_mfc_sr1_set(spu,
 					MFC_STATE1_MASTER_RUN_CONTROL_MASK);
 			eieio();
@@ -1095,7 +1095,7 @@ static inline void clear_spu_status(stru
 					SPU_STATUS_RUNNING);
 		}
 		if ((in_be32(&prob->spu_status_R) &
-		     SPU_STATUS_ISOLATED_LOAD_STAUTUS)
+		     SPU_STATUS_ISOLATED_LOAD_STATUS)
 		    || (in_be32(&prob->spu_status_R) &
 			SPU_STATUS_ISOLATED_STATE)) {
 			spu_mfc_sr1_set(spu,
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -291,8 +291,8 @@ struct spu_problem {
 #define SPU_STATUS_INVALID_INSTR        0x20
 #define SPU_STATUS_INVALID_CH           0x40
 #define SPU_STATUS_ISOLATED_STATE       0x80
-#define SPU_STATUS_ISOLATED_LOAD_STAUTUS 0x200
-#define SPU_STATUS_ISOLATED_EXIT_STAUTUS 0x400
+#define SPU_STATUS_ISOLATED_LOAD_STATUS 0x200
+#define SPU_STATUS_ISOLATED_EXIT_STATUS 0x400
 	u8  pad_0x4028_0x402c[0x4];				/* 0x4028 */
 	u32 spu_spe_R;						/* 0x402c */
 	u8  pad_0x4030_0x4034[0x4];				/* 0x4030 */

--

