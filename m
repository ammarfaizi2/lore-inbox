Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSGQMim>; Wed, 17 Jul 2002 08:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGQMil>; Wed, 17 Jul 2002 08:38:41 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:37351 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S313125AbSGQMik>; Wed, 17 Jul 2002 08:38:40 -0400
Message-ID: <3D356609.11B46A5C@delusion.de>
Date: Wed, 17 Jul 2002 14:41:45 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de> <20020717142933.B19385@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> Ok, another patch. :)

Very close :)
Directions of scrolling are reversed. The following works ok:

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
+++ b/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
@@ -142,7 +142,7 @@
  */

        if (psmouse->type == PSMOUSE_IMEX) {
-               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
+               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
                input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
                input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
        }


Regards,
-Udo.
