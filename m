Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTCZIho>; Wed, 26 Mar 2003 03:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbTCZIho>; Wed, 26 Mar 2003 03:37:44 -0500
Received: from p508205DB.dip0.t-ipconnect.de ([80.130.5.219]:16515 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S261504AbTCZIhn>;
	Wed, 26 Mar 2003 03:37:43 -0500
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [patch] Synaptics touchpad with Trackpoint needs ps/2 reset
From: Arne Koewing <ark@gmx.net>
Date: Tue, 25 Mar 2003 08:25:47 +0100
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
Message-ID: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I recently posted this to linux-kernel (with a different subject)
I had included a wrong ptch there, i think this one is ok.

As some people before I had the 'Dell trackpoint does not work' problem
after upgrading to 2.5.XX:
That was:
     
the trackpoint of your dell won't work until:
    - hibernate and wake up the system again
    - plug in an external mouse (you may remove it immediately)

it seems that dells hardware is disabling the trackpoint if you
probed for the touchpad.
A device reset after probing does help, but I've no idea how this
would affect other synaptics touchpad devices although I think
most devices will not complain about one extra reset.


  Arne


diff -bruN   linux-2.5.65-old/drivers/input/mouse/psmouse.c linux-2.5.65/drivers/input/mouse/psmouse.c 
--- linux-2.5.65-old/drivers/input/mouse/psmouse.c      2003-03-05 04:29:03.000000000 +0100
+++ linux-2.5.65/drivers/input/mouse/psmouse.c  2003-03-26 09:11:10.000000000 +0100
@@ -345,6 +345,7 @@
                   thing up. */
                psmouse->vendor = "Synaptics";
                psmouse->name = "TouchPad";
+              psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
                return PSMOUSE_PS2;
        }
