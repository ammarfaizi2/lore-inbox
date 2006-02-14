Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWBNTTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWBNTTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWBNTTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:19:15 -0500
Received: from [81.2.110.250] ([81.2.110.250]:65253 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1422667AbWBNTTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:19:14 -0500
Subject: PATCH: rio driver, boot code (1 of 3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, apkm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 19:22:18 +0000
Message-Id: <1139944938.11979.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch expands the HOST_DISABLE macro in rioboot.c. This is good
anyway to remove obfuscation but also neccessary so that indent will
process the file correctly.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.16-rc3/drivers/char/rio/rioboot.c	2006-02-14 17:08:55.000000000 +0000
+++ linux-2.6.16-rc3/drivers/char/rio/rioboot.c	2006-02-14 19:07:26.551366016 +0000
@@ -493,14 +493,10 @@
 		if ( RWORD(HostP->__ParmMapR) == OldParmMap ) {
 			rio_dprintk (RIO_DEBUG_BOOT, "parmmap 0x%x\n", RWORD(HostP->__ParmMapR));
 			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail\n");
-
-#define	HOST_DISABLE \
-		HostP->Flags &= ~RUN_STATE; \
-		HostP->Flags |= RC_STUFFED; \
-		RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
-		continue
-
-			HOST_DISABLE;
+			HostP->Flags &= ~RUN_STATE; \
+			HostP->Flags |= RC_STUFFED; \
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
+			continue
 		}
 
 		rio_dprintk (RIO_DEBUG_BOOT, "Running 0x%x\n", RWORD(HostP->__ParmMapR));
@@ -528,7 +524,10 @@
 		if ( (RWORD(ParmMapP->links) & 0xFFFF) != 0xFFFF ) {
 			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
 			rio_dprintk (RIO_DEBUG_BOOT, "Links = 0x%x\n",RWORD(ParmMapP->links));
-			HOST_DISABLE;
+			HostP->Flags &= ~RUN_STATE; \
+			HostP->Flags |= RC_STUFFED; \
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
+			continue
 		}
 
 		WWORD(ParmMapP->links , RIO_LINK_ENABLE);
@@ -550,7 +549,10 @@
 							!RWORD(ParmMapP->init_done) ) {
 			rio_dprintk (RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
 			rio_dprintk (RIO_DEBUG_BOOT, "Timedout waiting for init_done\n");
-			HOST_DISABLE;
+			HostP->Flags &= ~RUN_STATE; \
+			HostP->Flags |= RC_STUFFED; \
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );\
+			continue
 		}
 
 		rio_dprintk (RIO_DEBUG_BOOT, "Got init_done\n");

