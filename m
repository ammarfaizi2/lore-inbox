Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWIDKEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWIDKEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIDKEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:04:44 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:8142 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751327AbWIDKEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:04:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=UlzBiQzMuCKt7QWlOgycJzdUPB3IzRg+FRZUxoi10ioByN7yGRn1cRroUvuTNufT1frOe5fDj5XUvcYTQAk6DeSi6vvDsq6inu6gseVT5K7Z/y6zpkbYfUAJYbyusRUkJXXTDZ/DNUjucj3C86/ggDn3RFI+gDIi3RYP7X8bUdE=
Date: Mon, 4 Sep 2006 12:04:05 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: jeff@garzik.org
Cc: alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: 2.6.18-rc5-mm1 ich_pata_cbl_detect returns a value despite being void
Message-ID: <20060904120405.GC1581@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling 2.6.18-rc5-mm1 issues the following warning:
  CC      drivers/ata/ata_piix.o
  drivers/ata/ata_piix.c: In function 'ich_pata_cbl_detect':
  drivers/ata/ata_piix.c:612: warning: 'return' with a value, in
  function returning void

This was introduced by the
libata-add-40pin-short-cable-support-honour-drive.patch.
The attached patch fixes the issue by assigning ap->cbl.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <deweerdt@free.fr>
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index e4d7873..c9c8341 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -608,8 +608,10 @@ static void ich_pata_cbl_detect(struct a
 	while (lap->device) {
 		if (lap->device == pdev->device &&
 		    lap->subvendor == pdev->subsystem_vendor &&
-		    lap->subdevice == pdev->subsystem_device)
-		    	return ATA_CBL_PATA40_SHORT;
+		    lap->subdevice == pdev->subsystem_device) {
+			ap->cbl = ATA_CBL_PATA40_SHORT;
+		    	return;
+		}
 		lap++;
 	}
 

-- 
VGER BF report: U 0.500037
