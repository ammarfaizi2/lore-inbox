Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVLMSX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVLMSX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLMSX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:23:59 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:17137 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932507AbVLMSX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:23:58 -0500
Date: Tue, 13 Dec 2005 13:23:12 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 1/2] asus_acpi: Invert read of wled proc file to show correct
 state of LED.
In-reply-to: <113449813159-git-send-email-bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@ubuntu.com>
Reply-to: Ben Collins <bcollins@ubuntu.com>
Message-id: <1134498192250-git-send-email-bcollins@ubuntu.com>
MIME-version: 1.0
X-Mailer: git-send-email
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User with this equipment stated that writes to this file worked correctly,
but that reads were showing inverted state (1 for off, 0 for on).
Following the same style for reads, introduced an invert flag to read_led,
and used it for wled.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/acpi/asus_acpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

applies-to: f7e55af855531331113cbddb98688f3901d48425
d23291aeab378d85b93eda31f043a41449a5b474
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
---
0.99.9k


