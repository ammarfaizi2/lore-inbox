Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752869AbWKBNay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbWKBNay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbWKBNay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:30:54 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:16885 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752868AbWKBNax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:30:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AKE7OPN6UVqKtU+rYZb0FL0rhZL1t31OKb5bhdSOt71Y51gZNmCtoA4s0rPm1TYZw1+M3KEQ5/m9dNPWrfy8m+4ybVuKVUTcqnJ3yswC+v58rDCRtBdBApNG3c8xFkNjuaCwP9wLx4vEGW6U0l0fm/ZEGn0Hv2+Bd/pY35y7PEM=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 6/6] fix compile time warning in acpi video.c
Date: Sat, 4 Nov 2006 21:30:34 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611042130.34677.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix compile time warning in acpi video.c

signed-off-by   Luming.yu@gmail.com
---
[patch 6/6] fix compile time warning
 video.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 4ad109f..4a2520b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -560,13 +560,11 @@ static void acpi_pci_data_handler(acpi_h
 
 static struct acpi_pci_data * acpi_pci_get (struct acpi_device *device)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_pci_data *data = NULL;
 	struct acpi_pci_data *pdata = NULL;
 	char *pathname = NULL;
 	struct acpi_buffer buffer = { 0, NULL };
-	acpi_handle handle = NULL;
 	struct pci_dev *dev;
 	struct pci_bus *bus;
 
@@ -576,7 +574,7 @@ static struct acpi_pci_data * acpi_pci_g
 
 	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return -ENOMEM;
+		return NULL;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
