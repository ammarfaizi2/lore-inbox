Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275808AbTHOI6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275810AbTHOI6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:58:15 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:5578 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S275808AbTHOI6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:58:13 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-rc2, modular ide, missing dependencies in drivers/ide/Config.in? 
Organisation: Dresden University of Technology
From: Jean Wolter <jw5@os.inf.tu-dresden.de>
Content-Type: text/plain; charset=US-ASCII
Date: 15 Aug 2003 10:58:12 +0200
Message-ID: <86znib47rv.fsf@os.inf.tu-dresden.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tried to build a kernel with modular IDE drivers (CONFIG_IDE=m)
and got unresolved symbols during make modules_install. The reason was
CONFIG_BLK_DEV_CMD640=y which has to be set to 'm' when you try to
build IDE drivers as modules.

I think the IDE chipset bugfix/support should depend on
CONFIG_BLK_DEV_IDE to force building them as modules if the IDE driver
is build as a module:

--- linux-2.4.22-rc2-orig/drivers/ide/Config.in Wed Aug 13 11:28:08 2003
+++ linux-2.4.22-rc2/drivers/ide/Config.in      Wed Aug 13 22:12:37 2003
@@ -27,7 +27,7 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86 $CONFIG_BLK_DEV_IDE

The same holds for nearly all other drivers in the ide
subdirectories. Unfortunately I'm not familiar enough with the sources
and dependencies to provide a complete diff.

regards,
Jean
