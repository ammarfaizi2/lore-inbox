Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264215AbTCXOTy>; Mon, 24 Mar 2003 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264217AbTCXOTy>; Mon, 24 Mar 2003 09:19:54 -0500
Received: from p5082005B.dip0.t-ipconnect.de ([80.130.0.91]:16779 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S264215AbTCXOTx>;
	Mon, 24 Mar 2003 09:19:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Inspiron 8100 Trackpoint/Touchpad issue (with solution?)
From: Arne Koewing <ark@gmx.net>
Date: Mon, 24 Mar 2003 15:30:54 +0100
Message-ID: <878yv4x2e9.fsf@gmx.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi!
As some people before I had the 'trackpoint does not work' problem 
after upgrading to 2.5.XX:
That was:
     
the trackpoint of your dell won't work until:
    - hibernate and wake up the system again
    - plug in an external mouse (you may remove it immediately)

it seems that dells hardware is disabling the trackpoint if you
probed for the touchpad. 
A device reset after probing does help, but I've no idea how this
would affect other synaptics touchpad devices although I think
most devices will not complain one extra reset.


Arne


patch included:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=synaptics_reset.patch

--- linux-2.5.65-old/drivers/input/mouse/psmouse.c	2003-03-05 04:29:03.000000000 +0100
+++ linux-2.5.65-dev/drivers/input/mouse/psmouse.c	2003-03-24 08:42:11.000000000 +0100
@@ -345,6 +345,8 @@
                   thing up. */
                psmouse->vendor = "Synaptics";
                psmouse->name = "TouchPad";
+	       psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
+	       psmouse_command(psmouse, param, PSMOUSE_CMD_ENABLE);
                return PSMOUSE_PS2;
        }
 

--=-=-=--
