Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUCPOis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCPOir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:38:47 -0500
Received: from styx.suse.cz ([82.208.2.94]:65153 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261932AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467773954@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 25/44] Only reprobe on PS/2 HW when the HW sends 0xaa
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <1079446777817@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.56.3, 2004-03-03 11:50:22+01:00, vojtech@suse.cz
  input: Only do hotplug on PS/2 HW when the HW sends 0xaa. This
         avoids problems with broken USB->PS/2 legacy emulation
         in certain BIOSes.


 serio.c |    3 +++
 1 files changed, 3 insertions(+)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Mar 16 13:18:33 2004
+++ b/drivers/input/serio/serio.c	Tue Mar 16 13:18:33 2004
@@ -195,6 +195,9 @@
                 ret = serio->dev->interrupt(serio, data, flags, regs);
 	} else {
 		if (!flags) {
+			if ((serio->type == SERIO_8042 ||
+				serio->type == SERIO_8042_XL) && (data != 0xaa))
+					return ret;
 			serio_rescan(serio);
 			ret = IRQ_HANDLED;
 		}

