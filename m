Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUF1FwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUF1FwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUF1Fg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:36:57 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:30595 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264702AbUF1FWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:22:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 14/19] bind serio ports and their parents
Date: Mon, 28 Jun 2004 00:22:14 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280020.01085.dtor_core@ameritech.net> <200406280021.21090.dtor_core@ameritech.net>
In-Reply-To: <200406280021.21090.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280022.16273.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1788, 2004-06-27 16:01:48-05:00, dtor_core@ameritech.net
  Input: link serio ports to their parent devices in ambakmi,
         gscps2, pcips2 and sa1111ps2 drivers
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 ambakmi.c   |    1 +
 gscps2.c    |    1 +
 pcips2.c    |    1 +
 sa1111ps2.c |    1 +
 4 files changed, 4 insertions(+)


===================================================================



diff -Nru a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	2004-06-27 17:51:19 -05:00
+++ b/drivers/input/serio/ambakmi.c	2004-06-27 17:51:19 -05:00
@@ -141,6 +141,7 @@
 	strlcpy(io->name, dev->dev.bus_id, sizeof(io->name));
 	strlcpy(io->phys, dev->dev.bus_id, sizeof(io->phys));
 	io->port_data	= kmi;
+	io->dev.parent	= &dev->dev;
 
 	kmi->io 	= io;
 	kmi->base	= ioremap(dev->res.start, KMI_SIZE);
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	2004-06-27 17:51:19 -05:00
+++ b/drivers/input/serio/gscps2.c	2004-06-27 17:51:19 -05:00
@@ -385,6 +385,7 @@
 	serio->open		= gscps2_open;
 	serio->close		= gscps2_close;
 	serio->port_data	= ps2port;
+	serio->dev.parent	= &dev->dev;
 
 	list_add_tail(&ps2port->node, &ps2port_list);
 
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	2004-06-27 17:51:19 -05:00
+++ b/drivers/input/serio/pcips2.c	2004-06-27 17:51:19 -05:00
@@ -159,6 +159,7 @@
 	strlcpy(serio->name, pci_name(dev), sizeof(serio->name));
 	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
 	serio->port_data	= ps2if;
+	serio->dev.parent	= &dev->dev;
 	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	ps2if->base		= pci_resource_start(dev, 0);
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	2004-06-27 17:51:19 -05:00
+++ b/drivers/input/serio/sa1111ps2.c	2004-06-27 17:51:19 -05:00
@@ -252,6 +252,7 @@
 	strlcpy(serio->name, dev->dev.bus_id, sizeof(serio->name));
 	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
 	serio->port_data	= ps2if;
+	serio->dev.parent	= &dev->dev;
 	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	sa1111_set_drvdata(dev, ps2if);
