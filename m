Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUICJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUICJsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUICJr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:47:56 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:44697 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S269586AbUICJot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:44:49 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.9-rc1-mm3 i8042 compilation
Date: Fri, 3 Sep 2004 09:43:10 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org>
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OCCOBqJxysjDzPM"
Message-Id: <200409030943.10516.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OCCOBqJxysjDzPM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 03 September 2004 10:48, Andrew Morton wrote:
> +acpi-based-i8042-keyboard-aux-controller-enumeration.patch

This one is broken:

drivers/input/serio/i8042.c: In function `acpi_i8042_kbd_add':
drivers/input/serio/i8042.c:1133: error: `i8042_data_reg' undeclared (first 
usein this function)
drivers/input/serio/i8042.c:1133: error: (Each undeclared identifier is 
reported only once
drivers/input/serio/i8042.c:1133: error: for each function it appears in.)
drivers/input/serio/i8042.c:1134: error: `i8042_command_reg' undeclared (first 
use in this function)
drivers/input/serio/i8042.c:1135: error: `i8042_status_reg' undeclared (first 
use in this function)

Looks like it's assigning values to variables that are neither declared nor 
used anywhere - so the fix is fairly easy (attached).

LLaP
bero

--Boundary-00=_OCCOBqJxysjDzPM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.9-rc1-mm3-i8042-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-rc1-mm3-i8042-compile.patch"

--- linux-2.6.8/drivers/input/serio/i8042.c.ark	2004-09-03 09:40:56.000000000 +0200
+++ linux-2.6.8/drivers/input/serio/i8042.c	2004-09-03 09:41:12.000000000 +0200
@@ -1130,9 +1130,6 @@
 		acpi_device_name(device), acpi_device_bid(device),
 		i8042.port1, i8042.port2, i8042.irq);
 
-	i8042_data_reg = i8042.port1;
-	i8042_command_reg = i8042.port2;
-	i8042_status_reg = i8042.port2;
 	i8042_kbd_values.irq = i8042.irq;
 
 	return 0;

--Boundary-00=_OCCOBqJxysjDzPM--
