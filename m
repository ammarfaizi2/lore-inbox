Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBYNNl>; Sun, 25 Feb 2001 08:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBYNNb>; Sun, 25 Feb 2001 08:13:31 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:31304 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129066AbRBYNN0>; Sun, 25 Feb 2001 08:13:26 -0500
Message-ID: <3A98F047.733D7131@cleggies.freeserve.co.uk>
Date: Sun, 25 Feb 2001 11:45:11 +0000
From: Mark Clegg <mark@cleggies.freeserve.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: rubini@vision.unipv.it, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.x kernel keyboard fix for Digital HiNote Ultra 2000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using the 2.2.x kernels on the Digital HiNote Ultra 2000
(Mobile Pentium MMX 266) (I think this system was later rebadged as a
Compaq Armada 6500) without problem, however, on upgrading to the 2.4
series (2.4.0, 2.4.1 and 2.4.2) I have experienced the system hanging
quite reliably. - The problem goes away when an external keyboard/mouse
is attached.

Further investigation showed that the system itself isn't hanging, just
the keyboard/mouse becomes inoperable (I can still telnet into the
system). Booting without X and GPM is fine but cat /dev/psaux will zap
the keyboard.

I have traced this to drivers/char/pc_keyb.c and it is related to
operation of the builtin mouse (synaptics touchpad).

It would appear that the keyboard hardware is rather sensitive to
something. (RedHat 6.2 Kudzu locks it out as well - this one is
documented in the HiNote HOWTO)).

I have resolved the problem by commenting out a line in
drivers/char/pc_keyb.c related to fixing problems on a Toshiba 4030cdt.
It would appear that the fix for the Tosh, breaks the HiNote. (I don't
have a Tosh to experiment with).

Patch below.....

Regards
Mark


--- drivers/char/pc_keyb.c.orig Sat Feb 24 20:01:46 2001
+++ drivers/char/pc_keyb.c      Sat Feb 24 20:02:03 2001
@@ -909,7 +909,7 @@
        aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
        kbd_write_cmd(AUX_INTS_ON); /* Enable controller ints */

-       send_data(KBD_CMD_ENABLE);      /* try to workaround
toshiba4030cdt problem */
+//     send_data(KBD_CMD_ENABLE);      /* try to workaround
toshiba4030cdt problem */

        return 0;
 }


