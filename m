Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286747AbRL1FnN>; Fri, 28 Dec 2001 00:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286751AbRL1FnG>; Fri, 28 Dec 2001 00:43:06 -0500
Received: from osiris.silug.org ([64.240.156.225]:46250 "EHLO osiris.silug.org")
	by vger.kernel.org with ESMTP id <S286747AbRL1Fms>;
	Fri, 28 Dec 2001 00:42:48 -0500
Date: Thu, 27 Dec 2001 23:42:34 -0600
From: Steven Pritchard <steve@silug.org>
To: "Steven P. Cole" <elenstev@mesatop.com>,
        "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Configure.help entry fix
Message-ID: <20011227234234.A353@osiris.silug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then entry in Configure.help for CONFIG_BLK_DEV_3W_XXXX_RAID starts
out "3ware is the only hardware ATA-Raid product in Linux to date."
This is a mistake, since the driver for the Adaptec 2400A card
(dpt_i2o) is in the kernel.

I've included a patch below to fix that, plus add a note about a data
corruption issue that users should be aware of.  I suppose the entry
should probably also include the standard "If you want to compile this
driver as a module..." block also...

On a side note, shouldn't CONFIG_BLK_DEV_3W_XXXX_RAID really be
something like CONFIG_SCSI_3W_XXXX_RAID?

Steve
-- 
steve@silug.org           | Southern Illinois Linux Users Group
(618)398-7360             | See web site for meeting details.
Steven Pritchard          | http://www.silug.org/

--- Documentation/Configure.help.orig	Fri Dec 21 11:41:53 2001
+++ Documentation/Configure.help	Thu Dec 27 23:34:49 2001
@@ -917,9 +917,13 @@
 
 3ware Hardware ATA-RAID support
 CONFIG_BLK_DEV_3W_XXXX_RAID
-  3ware is the only hardware ATA-Raid product in Linux to date.
-  This card is 2,4, or 8 channel master mode support only.
-  SCSI support required!!!
+  This driver supports the 3ware Escalade 5000, 6000, and 7000-series
+  IDE RAID controllers.
+
+  Note that RAID 5 on 6000-series controllers requires a recent
+  firmware revision.  Running old firmware or old versions of the
+  driver on a degraded RAID 5 array can cause data corruption on the
+  array.  See 3ware's web site for firmware updates.
 
   <http://www.3ware.com/>
 
