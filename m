Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUEHADB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUEHADB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUEHADB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:03:01 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:47185 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263895AbUEHAC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:02:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 oops in psmouse/serio after resuming from APM suspend-to-ram
Date: Fri, 7 May 2004 17:16:11 -0500
User-Agent: KMail/1.6.2
Cc: Ari Pollak <ajp@aripollak.com>
References: <409BEF21.6040206@aripollak.com>
In-Reply-To: <409BEF21.6040206@aripollak.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405071716.15523.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 07 May 2004 03:18 pm, Ari Pollak wrote:
> On a Thinkpad T41 after going into suspend via APM and then resuming, 
> the psmouse driver seems to crash after resetting itself, at which point 
> the PS/2 mouse device (obviously) stops responding and I can't unload 
> the psmouse module. I don't know if this is a new bug or not, as this is 
> the first time I'm trying APM suspend on this laptop. The oops and the 
> kernel messages before it:
> 

I think this should take care of your oops:

===== drivers/input/mouse/psmouse-base.c 1.57 vs edited =====
--- 1.57/drivers/input/mouse/psmouse-base.c	Mon May  3 18:34:11 2004
+++ edited/drivers/input/mouse/psmouse-base.c	Fri May  7 17:12:22 2004
@@ -424,17 +424,17 @@
 		if (set_properties) {
 			psmouse->vendor = "Synaptics";
 			psmouse->name = "TouchPad";
-		}
 
-		if (max_proto > PSMOUSE_IMEX) {
-			if (synaptics_init(psmouse) == 0)
-				return PSMOUSE_SYNAPTICS;
+			if (max_proto > PSMOUSE_IMEX) {
+				if (synaptics_init(psmouse) == 0)
+					return PSMOUSE_SYNAPTICS;
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
  * we'll have to skip them.
  */
-			max_proto = PSMOUSE_IMEX;
+				max_proto = PSMOUSE_IMEX;
+			}
 		}
 /*
  * Make sure that touchpad is in relative mode, gestures (taps) are enabled
