Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVIEVbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVIEVbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVIEVaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:30:30 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:45647 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932596AbVIEVaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:30:01 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 22/24] V4L: Makes the input event device for IR matchable
 by udev rules.
Message-ID: <431cb7f8.R57/zZ0yZA2tx8n8%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.DuSnVMRmN8Veg+dg2df1WSw3co/P/AAL+CrZgzdcoi40HNvO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.DuSnVMRmN8Veg+dg2df1WSw3co/P/AAL+CrZgzdcoi40HNvO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.DuSnVMRmN8Veg+dg2df1WSw3co/P/AAL+CrZgzdcoi40HNvO
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-22-patch.diff"

- Makes the input event device created by the V4L drivers for the
  infrared remote matchable by udev rules.

Signed-off-by: Rudo Thomas <rudo@matfyz.cz>
Signed-off-by: Michael Fair <michael@daclubhouse.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-input.c       |    1 +
 linux/drivers/media/video/ir-kbd-gpio.c           |    1 +
 linux/drivers/media/video/saa7134/saa7134-input.c |    1 +
 3 files changed, 3 insertions(+)

diff -u /tmp/dst.1212 linux/drivers/media/video/ir-kbd-gpio.c
--- /tmp/dst.1212	2005-09-05 11:43:16.000000000 -0300
+++ linux/drivers/media/video/ir-kbd-gpio.c	2005-09-05 11:43:16.000000000 -0300
@@ -353,6 +353,7 @@
 		ir->input.id.vendor  = sub->core->pci->vendor;
 		ir->input.id.product = sub->core->pci->device;
 	}
+	ir->input.dev = &sub->core->pci->dev;
 
 	if (ir->polling) {
 		INIT_WORK(&ir->work, ir_work, ir);
diff -u /tmp/dst.1212 linux/drivers/media/video/cx88/cx88-input.c
--- /tmp/dst.1212	2005-09-05 11:43:17.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-input.c	2005-09-05 11:43:17.000000000 -0300
@@ -445,6 +445,7 @@
 		ir->input.id.vendor = pci->vendor;
 		ir->input.id.product = pci->device;
 	}
+	ir->input.dev = &pci->dev;
 
 	/* record handles to ourself */
 	ir->core = core;
diff -u /tmp/dst.1212 linux/drivers/media/video/saa7134/saa7134-input.c
--- /tmp/dst.1212	2005-09-05 11:43:17.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2005-09-05 11:43:17.000000000 -0300
@@ -564,6 +564,7 @@
 		ir->dev.id.vendor  = dev->pci->vendor;
 		ir->dev.id.product = dev->pci->device;
 	}
+	ir->dev.dev = &dev->pci->dev;
 
 	/* all done */
 	dev->remote = ir;

--=_431cb7f8.DuSnVMRmN8Veg+dg2df1WSw3co/P/AAL+CrZgzdcoi40HNvO--
