Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272263AbRHXROw>; Fri, 24 Aug 2001 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272265AbRHXROm>; Fri, 24 Aug 2001 13:14:42 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:3844 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S272264AbRHXROa>; Fri, 24 Aug 2001 13:14:30 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108241714.TAA01403@green.mif.pg.gda.pl>
Subject: Re: Linux 2.4.8-ac10
To: Martin.Knoblauch@TeraPort.de
Date: Fri, 24 Aug 2001 19:14:39 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Linux 2.4.8-ac10
> > 
> > From: Alan Cox (laughing@shared-source.org)
> > o Put config hooks in to make qlogicfc firmware (me)
> >         optionally loadable for weird hardware
> >         | Needs a suitable firmware file adding ..
> 
>  shouldn't the question about the FW only be asked if the FC driver is
> actually requested? I have not requested the driver, but get asked (make
> oldconfig) about the FW.

Somebodyd did a typo:

   if [ "%CONFIG_SCSI_QLOGIC_FC" != "n" ]; then
        ^^^
Also indentation of question texts should step by 2, not 3.

BTW, wouldn't it better to use deb_mbool here ?
Patch for all three fixes follows.

Andrzej
*******************************************
--- drivers/scsi/Config.in.old	Fri Aug 24 19:03:51 2001
+++ drivers/scsi/Config.in	Fri Aug 24 19:08:05 2001
@@ -153,9 +153,7 @@
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate 'Qlogic ISP SCSI support' CONFIG_SCSI_QLOGIC_ISP $CONFIG_SCSI
    dep_tristate 'Qlogic ISP FC SCSI support' CONFIG_SCSI_QLOGIC_FC $CONFIG_SCSI
-   if [ "%CONFIG_SCSI_QLOGIC_FC" != "n" ]; then
-      bool '   Include loadable firmware in driver' CONFIG_SCSI_QLOGIC_FC_FIRMWARE
-   fi
+   dep_mbool '  Include loadable firmware in driver' CONFIG_SCSI_QLOGIC_FC_FIRMWARE $CONFIG_SCSI_QLOGIC_FC
    dep_tristate 'Qlogic QLA 1280 SCSI support' CONFIG_SCSI_QLOGIC_1280 $CONFIG_SCSI
 fi
 if [ "$CONFIG_X86" = "y" ]; then

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
