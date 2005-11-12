Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVKLVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVKLVQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVKLVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:16:22 -0500
Received: from mail.isurf.ca ([66.154.97.68]:19133 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964818AbVKLVQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:16:21 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: sziwan@users.sourceforge.net
Subject: [RESEND] [PATCH] drivers/acpi/asus_acpi.c unsigned comparison
Date: Sat, 12 Nov 2005 16:16:14 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511121616.14940.ace@staticwave.ca>
X-Length: 1010
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It helps if I attach the patch.

proc_write_brn, and proc_write_disp both use a parameter "count" to store the result from parse_arg.
The return of parse_arg is an int, but count is declared as an unsigned int, and later checked versus zero,
which is meaningless. This patch fixes the declaration of count in both functions.

Thanks to LinuxICC (http://linuxicc.sf.net)

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index fec895a..9dfd0cd 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -748,7 +748,7 @@ proc_read_brn(char *page, char **start, 
 
 static int
 proc_write_brn(struct file *file, const char __user * buffer,
-	       unsigned long count, void *data)
+	       long count, void *data)
 {
 	int value;
 
@@ -798,7 +798,7 @@ proc_read_disp(char *page, char **start,
  */
 static int
 proc_write_disp(struct file *file, const char __user * buffer,
-		unsigned long count, void *data)
+		long count, void *data)
 {
 	int value;
 


-- 
Gabriel A. Devenyi
ace@staticwave.ca
