Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSGQM0l>; Wed, 17 Jul 2002 08:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSGQM0k>; Wed, 17 Jul 2002 08:26:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42408 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313113AbSGQM0j>;
	Wed, 17 Jul 2002 08:26:39 -0400
Date: Wed, 17 Jul 2002 14:29:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717142933.B19385@ucw.cz>
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D355FD0.9F0E4F8@delusion.de>; from reality@delusion.de on Wed, Jul 17, 2002 at 02:15:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:15:12PM +0200, Udo A. Steinberg wrote:
> Vojtech Pavlik wrote:
> > 
> > This is interesting. Can you try the attached test utility? You need to
> > enable CONFIG_INPUT_EVDEV, as well, and use it on /dev/input/evdev0 or
> > 1, depening what's your mouse.
> > 
> > I'm wondering whether the scroll events show up or not.
> 
> Hello,
> 
> They show up in the output. First 4 events are scroll-down, last
> 4 events are scroll-up.

Ok, another patch. :)  

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Wed Jul 17 12:19:13 2002
+++ b/drivers/input/mouse/psmouse.c	Wed Jul 17 12:19:13 2002
@@ -142,7 +142,7 @@
  */
 
 	if (psmouse->type == PSMOUSE_IMEX) {
-		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
+		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 7) - (int) (packet[3] & 8));
 		input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
 		input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
 	}


> 
> Regards,
> -Udo.
> 
> ./evtest /dev/input/event2 
> Input driver version is 1.0.0
> Input device ID: bus 0x11 vendor 0x6 product 0x2 version 0x100
> Input device name: "ImExPS/2 Microsoft IntelliMouse Explorer"
> Supported events:
>   Event type 1 (Key)
>     Event code 272 (LeftBtn)
>     Event code 273 (RightBtn)
>     Event code 274 (MiddleBtn)
>     Event code 275 (SideBtn)
>     Event code 276 (ExtraBtn)
>   Event type 2 (Relative)
>     Event code 0 (X)
>     Event code 1 (Y)
>     Event code 8 (Wheel)
> Testing ... (interrupt to exit)
> Event: time 1026908021.053509, type 2 (Relative), code 8 (Wheel), value -1
> Event: time 1026908021.607555, type 2 (Relative), code 8 (Wheel), value -1
> Event: time 1026908022.017017, type 2 (Relative), code 8 (Wheel), value -1
> Event: time 1026908022.412833, type 2 (Relative), code 8 (Wheel), value -1
> Event: time 1026908023.241679, type 2 (Relative), code 8 (Wheel), value -7
> Event: time 1026908023.711842, type 2 (Relative), code 8 (Wheel), value -7
> Event: time 1026908024.149266, type 2 (Relative), code 8 (Wheel), value -7
> Event: time 1026908024.529600, type 2 (Relative), code 8 (Wheel), value -7

-- 
Vojtech Pavlik
SuSE Labs
