Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUG2O0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUG2O0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUG2OWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:22:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:30102 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265041AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 41/47] link (some) serio ports to their parent devices
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110196869@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101963506@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.36, 2004-06-29 01:36:29-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/serio/ambakmi.c	Thu Jul 29 14:38:57 2004
+++ b/drivers/input/serio/ambakmi.c	Thu Jul 29 14:38:57 2004
@@ -141,6 +141,7 @@
 	strlcpy(io->name, dev->dev.bus_id, sizeof(io->name));
 	strlcpy(io->phys, dev->dev.bus_id, sizeof(io->phys));
 	io->port_data	= kmi;
+	io->dev.parent	= &dev->dev;
 
 	kmi->io 	= io;
 	kmi->base	= ioremap(dev->res.start, KMI_SIZE);
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	Thu Jul 29 14:38:57 2004
+++ b/drivers/input/serio/gscps2.c	Thu Jul 29 14:38:57 2004
@@ -385,6 +385,7 @@
 	serio->open		= gscps2_open;
 	serio->close		= gscps2_close;
 	serio->port_data	= ps2port;
+	serio->dev.parent	= &dev->dev;
 
 	list_add_tail(&ps2port->node, &ps2port_list);
 
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	Thu Jul 29 14:38:57 2004
+++ b/drivers/input/serio/pcips2.c	Thu Jul 29 14:38:57 2004
@@ -159,6 +159,7 @@
 	strlcpy(serio->name, pci_name(dev), sizeof(serio->name));
 	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
 	serio->port_data	= ps2if;
+	serio->dev.parent	= &dev->dev;
 	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	ps2if->base		= pci_resource_start(dev, 0);
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	Thu Jul 29 14:38:57 2004
+++ b/drivers/input/serio/sa1111ps2.c	Thu Jul 29 14:38:57 2004
@@ -252,6 +252,7 @@
 	strlcpy(serio->name, dev->dev.bus_id, sizeof(serio->name));
 	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
 	serio->port_data	= ps2if;
+	serio->dev.parent	= &dev->dev;
 	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	sa1111_set_drvdata(dev, ps2if);

