Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULUAoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULUAoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULUAod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:44:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261504AbULUAl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:41:58 -0500
Date: Tue, 21 Dec 2004 01:41:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI NCR53C9x.c: some cleanups (fwd)
Message-ID: <20041221004153.GI21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 15 Nov 2004 03:18:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI NCR53C9x.c: some cleanups

The patch below contains some cleanups.

Please review the fact that the function esp_command currently has zero 
users.


diffstat output:
 drivers/scsi/NCR53C9x.c |   15 ++-------------
 drivers/scsi/NCR53C9x.h |    1 -
 2 files changed, 2 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR53C9x.h.old	2004-11-13 16:27:49.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR53C9x.h	2004-11-13 16:27:41.000000000 +0100
@@ -660,7 +660,6 @@
 extern irqreturn_t esp_intr(int, void *, struct pt_regs *);
 extern const char *esp_info(struct Scsi_Host *);
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
 extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(struct Scsi_Host *shost, char *buffer, char **start, off_t offset, int length,
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR53C9x.c.old	2004-11-13 16:24:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR53C9x.c	2004-11-13 16:28:23.000000000 +0100
@@ -100,7 +100,7 @@
 irqreturn_t esp_intr(int irq, void *dev_id, struct pt_regs *pregs);
 
 /* Debugging routines */
-struct esp_cmdstrings {
+static struct esp_cmdstrings {
 	unchar cmdchar;
 	char *text;
 } esp_cmd_strings[] = {
@@ -505,7 +505,7 @@
 }
 
 /* This places the ESP into a known state at boot time. */
-void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
+static void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
 {
 	volatile unchar trash;
 
@@ -1271,17 +1271,6 @@
 	return 0;
 }
 
-/* Only queuing supported in this ESP driver. */
-int esp_command(Scsi_Cmnd *SCpnt)
-{
-#ifdef DEBUG_ESP
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCpnt->device->host->hostdata;
-#endif
-
-	ESPLOG(("esp%d: esp_command() called...\n", esp->esp_id));
-	return -1;
-}
-
 /* Dump driver state. */
 static void esp_dump_cmd(Scsi_Cmnd *SCptr)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

