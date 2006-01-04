Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWADWFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWADWFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWADWFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:05:32 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:8180 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030335AbWADWAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:00:35 -0500
Date: Wed, 04 Jan 2006 17:00:12 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 06/15] asus_acpi: Invert read of wled proc file to show correct
 state of LED.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00NW494T1L@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/acpi/asus_acpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

4d2e320add8e00550bae442d12e9c980310076a9
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index fec895a..20e53c4 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -490,13 +490,13 @@ proc_read_info(char *page, char **start,
  */
 
 /* Generic LED functions */
-static int read_led(const char *ledname, int ledmask)
+static int read_led(const char *ledname, int ledmask, int invert)
 {
 	if (ledname) {
 		int led_status;
 
 		if (read_acpi_int(NULL, ledname, &led_status))
-			return led_status;
+			return (invert) ? !led_status : led_status;
 		else
 			printk(KERN_WARNING "Asus ACPI: Error reading LED "
 			       "status\n");
@@ -552,7 +552,7 @@ proc_read_mled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->mled_status, MLED_ON));
+		       read_led(hotk->methods->mled_status, MLED_ON, 0));
 }
 
 static int
@@ -570,7 +570,7 @@ proc_read_wled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->wled_status, WLED_ON));
+		       read_led(hotk->methods->wled_status, WLED_ON, 1));
 }
 
 static int
@@ -588,7 +588,7 @@ proc_read_tled(char *page, char **start,
 	       void *data)
 {
 	return sprintf(page, "%d\n",
-		       read_led(hotk->methods->tled_status, TLED_ON));
+		       read_led(hotk->methods->tled_status, TLED_ON, 0));
 }
 
 static int
-- 
1.0.5
