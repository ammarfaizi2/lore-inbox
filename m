Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSGQKRH>; Wed, 17 Jul 2002 06:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSGQKRG>; Wed, 17 Jul 2002 06:17:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63141 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318265AbSGQKRF>;
	Wed, 17 Jul 2002 06:17:05 -0400
Date: Wed, 17 Jul 2002 12:20:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717122000.A12529@ucw.cz>
References: <3D35435F.E5CFA5E2@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D35435F.E5CFA5E2@delusion.de>; from reality@delusion.de on Wed, Jul 17, 2002 at 12:13:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 12:13:51PM +0200, Udo A. Steinberg wrote:
> 
> Hi Vojtech,
> 
> I'm running 2.5.26 with an ordinary PS/2 keyboard and a 5 button PS/2 mouse.
> When using the old psaux driver the mouse works fine.
> With input core support, however, the scroll wheel doesn't work properly.
> In my XF86Config I'm using IMPS/2 protocol and ZAxisMapping 4 5.
> Scrolling up causes the window to scroll down. Scrolling down doesn't do
> anything. When changing the protocol to ExplorerPS2 things are not much
> better. You can't drag windows over the screen.
> 
> The following is the relevant kernel information.
> Do you have any tips?

It's a bug. This patch should fix it:

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Wed Jul 17 12:19:13 2002
+++ b/drivers/input/mouse/psmouse.c	Wed Jul 17 12:19:13 2002
@@ -142,7 +142,7 @@
  */
 
 	if (psmouse->type == PSMOUSE_IMEX) {
-		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 7) - (int) (packet[2] & 8));
+		input_report_rel(dev, REL_WHEEL, (int) (packet[2] & 8) - (int) (packet[3] & 7));
 		input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
 		input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
 	}


> mice: PS/2 mouse device common for all mice
> input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUC
> input.c: hotplug returned -2
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1  
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUC
> input.c: hotplug returned -2
> input: ImExPS/2 Microsoft IntelliMouse Explorer on isa0060/serio1
> 
> Regards,
> Udo.

-- 
Vojtech Pavlik
SuSE Labs
