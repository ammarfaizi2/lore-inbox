Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWDJFqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWDJFqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWDJFqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:46:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19896 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750997AbWDJFqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:46:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 08:46:17 +0300
User-Agent: KMail/1.8.2
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
References: <200604100844.12151.vda@ilport.com.ua>
In-Reply-To: <200604100844.12151.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pEfOENl39s3HIQf"
Message-Id: <200604100846.17877.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pEfOENl39s3HIQf
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 10 April 2006 08:44, Denis Vlasenko wrote:
> I also spotted two bugs in the process, patches
> for those will follow.

Fix ahc_pci_write_config's (wrong order of arguments).

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_pEfOENl39s3HIQf
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.6.16.aic7_41.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.16.aic7_41.patch"

Fix a bug uncovered by previous change

diff -urpN linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_pci.c linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic7xxx_pci.c
--- linux-2.6.16.aic7/drivers/scsi/aic7xxx/aic7xxx_pci.c	Sun Apr  9 22:11:13 2006
+++ linux-2.6.16.aic7_2/drivers/scsi/aic7xxx/aic7xxx_pci.c	Sun Apr  9 22:09:45 2006
@@ -2036,12 +2036,12 @@ ahc_pci_resume(struct ahc_softc *ahc)
 	 * that the OS doesn't know about and rely on our chip
 	 * reset handler to handle the rest.
 	 */
-	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4,
-			     ahc->bus_softc.pci_softc.devconfig);
-	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.command);
-	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.csize_lattime);
+	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG,
+			     ahc->bus_softc.pci_softc.devconfig, /*bytes*/4);
+	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND,
+			     ahc->bus_softc.pci_softc.command, /*bytes*/1);
+	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
+			     ahc->bus_softc.pci_softc.csize_lattime, /*bytes*/1);
 	if ((ahc->flags & AHC_HAS_TERM_LOGIC) != 0) {
 		struct	seeprom_descriptor sd;
 		u_int	sxfrctl1;

--Boundary-00=_pEfOENl39s3HIQf--
