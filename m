Return-Path: <linux-kernel-owner+w=401wt.eu-S1751749AbXACANi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXACANi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbXACANi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:13:38 -0500
Received: from web50110.mail.yahoo.com ([206.190.38.38]:34190 "HELO
	web50110.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751749AbXACANh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:13:37 -0500
Message-ID: <20070103001336.84797.qmail@web50110.mail.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=0FhOlnI8IDeIQARDxjKM2Otx4G9Wo0JGd7BljwrMUrS63lDpJ4gL6m0rMvaAdIrS3h4q/xOgEL13MDYy6oxoCZXUZ2pMf5+MxWkZhMweZIBiiiB23TV9KT4IyK19N+kgH5xvhMM8JfR/IRYkytGU57jl5RHb8WKXzS+dpE3/k3Q=;
X-YMail-OSG: jpkuJJsVM1mF1_gxJYek8olQ_O9_hSajKC4UIzPzOeR9w3H3r3xBaq62o4euheyJaA--
Date: Tue, 2 Jan 2007 16:13:36 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 1/2] EDAC: e752x-bit-mask-fix
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Brian Pomerantz <bapper@mvista.com>

Description:
    The fatal vs. non-fatal mask for the sysbus FERR status is
incorrect
    according to the E7520 datasheet.  This patch corrects the mask to
correctly
    handle fatal and non-fatal errors.

Signed-off-by: Brian Pomerantz <bapper@mvista.com>
Signed-off-by: Dave Jiang <djiang@mvista.com>
Signed-off-by: Doug Thompson <norsk5@xmission.com>

 e752x_edac.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.18/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.18.orig/drivers/edac/e752x_edac.c
+++ linux-2.6.18/drivers/edac/e752x_edac.c
@@ -561,17 +561,17 @@ static void e752x_check_sysbus(struct e7
 	error32 = (stat32 >> 16) & 0x3ff;
 	stat32 = stat32 & 0x3ff;
 
-	if(stat32 & 0x083)
-		sysbus_error(1, stat32 & 0x083, error_found, handle_error);
+	if(stat32 & 0x087)
+		sysbus_error(1, stat32 & 0x087, error_found, handle_error);
 
-	if(stat32 & 0x37c)
-		sysbus_error(0, stat32 & 0x37c, error_found, handle_error);
+	if(stat32 & 0x378)
+		sysbus_error(0, stat32 & 0x378, error_found, handle_error);
 
-	if(error32 & 0x083)
-		sysbus_error(1, error32 & 0x083, error_found, handle_error);
+	if(error32 & 0x087)
+		sysbus_error(1, error32 & 0x087, error_found, handle_error);
 
-	if(error32 & 0x37c)
-		sysbus_error(0, error32 & 0x37c, error_found, handle_error);
+	if(error32 & 0x378)
+		sysbus_error(0, error32 & 0x378, error_found, handle_error);
 }
 
 static void e752x_check_membuf (struct e752x_error_info *info,

