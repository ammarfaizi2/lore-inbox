Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263191AbTCSWAj>; Wed, 19 Mar 2003 17:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbTCSWAi>; Wed, 19 Mar 2003 17:00:38 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:1690 "HELO
	colossus.systems.pipex.net") by vger.kernel.org with SMTP
	id <S263191AbTCSWAi>; Wed, 19 Mar 2003 17:00:38 -0500
From: Angus Sawyer <angus.sawyer@dsl.pipex.com>
Reply-To: angus.sawyer@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] floppy driver oopses on forced unload (against 2.5.65)
Date: Wed, 19 Mar 2003 22:11:35 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303192211.35980.angus.sawyer@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Prevent OOPS on removing floppy driver with "rmmod -f floppy".

floppy.c would attempt to unregister resources for nonexistent device.  

Patch stops the driver attempting to register and unregister the nonexistent 
device by removing the drive from the allowed drives mask (defaults to 
present). 



 drivers/block/floppy.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/block/floppy.c~floppy-unload-fix drivers/block/floppy.c
--- linux-2.5.65/drivers/block/floppy.c~floppy-unload-fix	Wed Mar 19 18:44:15 
2003
+++ linux-2.5.65-/drivers/block/floppy.c	Wed Mar 19 21:33:22 2003
@@ -3649,6 +3649,8 @@ static void __init config_types(void)
 				name = default_drive_params[type].name;
 				allowed_drive_mask |= 1 << drive;
 			}
+			else
+				allowed_drive_mask &= ~(1 << drive);
 		} else {
 			params = &default_drive_params[0].params;
 			sprintf(temparea, "unknown type %d (usb?)", type);

_

