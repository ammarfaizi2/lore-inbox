Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGaXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGaXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVGaXau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:30:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17371 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262081AbVGaX30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:29:26 -0400
Message-ID: <42ED5ED3.9060209@pobox.com>
Date: Sun, 31 Jul 2005 19:29:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch] libata fix
Content-Type: multipart/mixed;
 boundary="------------000002090103040500040007"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000002090103040500040007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the damnable-annoying[1] fix described in the attached 
diffstat/changelog/patch.

	Jeff


[1] the option is truly a boolean, that enables or disables a menu (not 
any code).  But it won't work as a boolean apparently :/  Roman doesn't 
have any better suggestions, so oh well.


--------------000002090103040500040007
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


commit faa725332f39329288f52b7f872ffda866ba5b09
Author: Adrian Bunk <bunk@stusta.de>
Date:   Wed Jul 27 01:06:35 2005 -0700

    [PATCH] SCSI_SATA has to be a tristate
    
    SCSI=m must disallow static drivers.
    
    The problem is that all the SATA drivers depend on SCSI_SATA.
    
    With SCSI=m and SCSI_SATA=y this allows the static enabling of the SATA
    drivers with unwanted effects, e.g.:
    - SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y
      -> SCSI_ATA_ADMA is built statically but scsi/built-in.o is not linked
         into the kernel
    - SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y, SCSI_SATA_AHCI=m
      -> SCSI_ATA_ADMA and libata are built statically but
         scsi/built-in.o is not linked into the kernel,
         SCSI_SATA_AHCI is built modular (unresolved symbols due to missing
                                          libata)
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Cc: Jeff Garzik <jgarzik@pobox.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -424,7 +424,7 @@ config SCSI_IN2000
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers

--------------000002090103040500040007--
