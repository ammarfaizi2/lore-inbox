Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUG2RAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUG2RAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUG2Q70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:59:26 -0400
Received: from styx.suse.cz ([82.119.242.94]:63895 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265101AbUG2Q6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:58:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] move input/serio closer to the top of drivers/Makefile so serio_bus is available early
X-Mailer: gregkh_patchbomb_levon_offspring
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 18:59:59 +0200
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10911203991518@twilight.ucw.cz>
In-Reply-To: <20040729165939.GA21130@ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1807.3.2, 2004-07-19 22:34:23-05:00, dtor_core@ameritech.net
  Input: move input/serio closer to the top of drivers/Makefile so
         serio_bus is available early
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	Thu Jul 29 18:52:08 2004
+++ b/drivers/Makefile	Thu Jul 29 18:52:08 2004
@@ -15,6 +15,9 @@
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
+# we also need input/serio early so serio bus is initialized by the time
+# serial drivers start registering their serio ports
+obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ net/ media/
@@ -37,7 +40,6 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
-obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_I2O)		+= message/

