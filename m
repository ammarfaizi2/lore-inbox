Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757516AbWK1WIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbWK1WIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757484AbWK1WIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:08:49 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:20203 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1757516AbWK1WIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:08:48 -0500
Date: Tue, 28 Nov 2006 14:09:05 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dmitry.torokhov@gmail.com
Subject: [PATCH 2/2] joystick/analog: force HWEIGHT for module
Message-Id: <20061128140905.6a9cbb07.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

input/joystick/analog (=m) uses hweight*(), but those functions are
only linked into the kernel image if it is used inside the kernel image,
not in loadable modules.  Let modules force HWEIGHT to be
built into the kernel image.  Otherwise build fails:

  Building modules, stage 2.
  MODPOST 94 modules
WARNING: "hweight16" [drivers/input/joystick/analog.ko] undefined!
WARNING: "hweight8" [drivers/input/joystick/analog.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/input/joystick/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19-rc6-git10.orig/drivers/input/joystick/Kconfig
+++ linux-2.6.19-rc6-git10/drivers/input/joystick/Kconfig
@@ -17,6 +17,7 @@ if INPUT_JOYSTICK
 config JOYSTICK_ANALOG
 	tristate "Classic PC analog joysticks and gamepads"
 	select GAMEPORT
+	select FORCE_HWEIGHT
 	---help---
 	  Say Y here if you have a joystick that connects to the PC
 	  gameport. In addition to the usual PC analog joystick, this driver


---
