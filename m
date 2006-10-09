Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWJITQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWJITQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWJITQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:16:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37344 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751601AbWJITQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:16:26 -0400
Date: Mon, 9 Oct 2006 14:15:52 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: rubini@vision.unipv.it, oakad@yahoo.com, masbock@us.ibm.com,
       sascha@saschahauer.de, bunk@stusta.de, ankita@in.ibm.com
Subject: Kconfig include order of drivers/misc
Message-ID: <20061009140135.G64302@pkunk.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am contemplating a patch which would move the drivers/sn/ioc4.c code
into drivers/misc, as the SGI IOC4 device may soon not be limited to
operation on the SGI SN2 platform.  However, to maintain proper Kconfig
dependency ordering, this will require me to move drivers/misc before
drivers/ide in the drivers/Kconfig file.

My examination of this change seems to indicate this should not cause
any problems for the drivers hosted under drivers/misc, however I wanted
to run it by those who have recently (i.e. since "git" began hosting
the Linux source) touched the drivers/misc/Kconfig file.

Do any of you anticipate a problem with the following change?

Thanks,
Brent

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 263e86d..f394634 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -14,6 +14,10 @@ source "drivers/pnp/Kconfig"

 source "drivers/block/Kconfig"

+# misc before ide - BLK_DEV_SGIIOC4 depends on SGI_IOC4
+
+source "drivers/misc/Kconfig"
+
 source "drivers/ide/Kconfig"

 source "drivers/scsi/Kconfig"
@@ -52,8 +56,6 @@ source "drivers/w1/Kconfig"

 source "drivers/hwmon/Kconfig"

-source "drivers/misc/Kconfig"
-
 source "drivers/mfd/Kconfig"

 source "drivers/media/Kconfig"

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
