Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbSJGTZd>; Mon, 7 Oct 2002 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbSJGTX7>; Mon, 7 Oct 2002 15:23:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5286 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262564AbSJGTXw>;
	Mon, 7 Oct 2002 15:23:52 -0400
Date: Mon, 7 Oct 2002 12:31:15 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: alan@lxorguk.ukuu.org.uk, <viro@math.psu.edu>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210071220020.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071231040.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.696.19.1, 2002-10-07 09:52:31-07:00, mochel@osdl.org
  IDE: only register drives that are present with the driver core.

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
+++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
@@ -986,8 +986,8 @@
 			 "%s","IDE Drive");
 		disk->disk_dev.parent = &hwif->gendev;
 		disk->disk_dev.bus = &ide_bus_type;
-		device_register(&disk->disk_dev);
-
+		if (hwif->drives[unit].present)
+			device_register(&disk->disk_dev);
 		hwif->drives[unit].disk = disk;
 	}
 

