Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbSJIShz>; Wed, 9 Oct 2002 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSJISg2>; Wed, 9 Oct 2002 14:36:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7088 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262424AbSJISfs>;
	Wed, 9 Oct 2002 14:35:48 -0400
Date: Wed, 9 Oct 2002 11:43:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091143490.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.730, 2002-10-09 11:40:34-07:00, mochel@osdl.org
  IDE: make ide_drive_remove() call driver's ->cleanup().
  
  This was accidentally dropped before, but re-added now to completely mimic
  behavior of the reboot notifier IDE used to have. 

diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed Oct  9 11:41:35 2002
+++ b/drivers/ide/ide.c	Wed Oct  9 11:41:35 2002
@@ -3428,8 +3428,13 @@
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
 	ide_driver_t * driver = drive->driver;
 
-	if (driver && driver->standby)
-		driver->standby(drive);
+	if (driver) {
+		if (driver->standby)
+			driver->standby(drive);
+		if (driver->cleanup)
+			driver->cleanup(drive);
+	}
+	
 	return 0;
 }
 

