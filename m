Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTEKOHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEKOHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:07:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25577 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261438AbTEKOH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:07:29 -0400
Date: Sun, 11 May 2003 16:20:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Atul Mukker <Atul.Mukker@lsil.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.21-rc2-ac1: compile error with both AMI Megaraid drivers
Message-ID: <20030511142005.GI1107@fs.tum.de>
References: <200305101412.h4AEC3107645@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305101412.h4AEC3107645@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 10:12:03AM -0400, Alan Cox wrote:
>...
> Linux 2.4.21rc1-ac4
>...
> o	Merge new AMI Megaraid driver as megaraid2	(Atul Mukker)
>...

This fails when trying to build both AMI Megaraid drivers statically 
into the kernel.

The following patch fixes it:

--- linux-2.4.21-rc2-ac1-full/drivers/scsi/Config.in.old	2003-05-11 16:14:23.000000000 +0200
+++ linux-2.4.21-rc2-ac1-full/drivers/scsi/Config.in	2003-05-11 16:15:42.000000000 +0200
@@ -66,7 +66,9 @@
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support (old driver)' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID support (new driver)' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
+   dep_tristate 'AMI MegaRAID support (new driver)' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+fi
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

