Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVIKTEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVIKTEe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVIKTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:04:34 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:33499 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S1750719AbVIKTEd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:04:33 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: pluto2 patch
Date: Sun, 11 Sep 2005 21:04:10 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509112104.12953.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I receive about 200 dmesg messages in 1 minut this fixes it, I think we can 
easily remove this error message:

--- /usr/src/linux/drivers/media/dvb/pluto2/pluto2.c    2005-09-11 
14:09:19.000000000 +0200
+++ /usr/src/linux/drivers/media/dvb/pluto2/pluto2.c    2005-09-11 
14:10:17.000000000 +0200
@@ -291,8 +291,8 @@
                        i += 188;
                valid = i / 188;
                if (nbpackets != valid) {
-                       dev_err(&pluto->pdev->dev, "nbpackets=%u valid=%u\n",
-                                       nbpackets, valid);
+       /*              dev_err(&pluto->pdev->dev, "nbpackets=%u valid=%u\n",
+                                       nbpackets, valid); */
                        nbpackets = valid;
                }
        }

Thanks for applying!

There is another bug when card is removed, driver says card hung many times.
This part of code is responsible for it:

        if (tscr == 0xffffffff) {
                // FIXME: maybe recover somehow
                dev_err(&pluto->pdev->dev, "card hung up :(\n");
                return IRQ_HANDLED;

There should be probably 
                if (tscr == 0xffffffff) && !pcmcia_card_removed
to fix this.

Do anybody know exact name of this funtion in pcmcia code? 

Thanks
Michal
