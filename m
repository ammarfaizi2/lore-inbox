Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265652AbSJSSjm>; Sat, 19 Oct 2002 14:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbSJSSjm>; Sat, 19 Oct 2002 14:39:42 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:751 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id <S265652AbSJSSjk>; Sat, 19 Oct 2002 14:39:40 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Date: Sat, 19 Oct 2002 11:45:28 -0700
Organization: Murgatroid.Com
Message-ID: <000901c2779f$b1b88300$8100000a@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20021019095117.A1354@ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, that works.

[ch@jukebox ch]$ cat /proc/bus/input/devices 
I: Bus=0011 Vendor=0002 Product=0002 Version=0035
N: Name="PS2++ Logitech Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event0 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1 
B: EV=120003 
B: KEY=4 2000000 8061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe 
B: LED=7 

Thanks.

-ch


-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Saturday, October 19, 2002 12:51 AM
To: Christopher Hoover
Cc: 'Vojtech Pavlik'; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse


On Fri, Oct 18, 2002 at 10:41:25AM -0700, Christopher Hoover wrote:

> > No, it unfortunately is not a proper fix. I'll have to analyze the
> > problem some more.
> 
> Would you say more?  I looked at XFree86 sources and it seemed that
the
> ImPS/2 protocol best matched what my mouse was sending.
> 
> What about a module param/setup arg to force the mouse protocol?
> 
> 
> > Can you send me the output of /proc/bus/input/devices on your system
> > (without your fix, preferably)?
> 
> With*out* the patch:
> 
> I: Bus=0011 Vendor=0002 Product=0002 Version=0035
> N: Name="PS2++ Logitech Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event0 
> B: EV=7 
> B: KEY=70000 0 0 0 0 0 0 0 0 
> B: REL=3 

Thanks! Can you try this patch?

 psmouse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c
b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Sat Oct 19 09:50:17 2002
+++ b/drivers/input/mouse/psmouse.c	Sat Oct 19 09:50:17 2002
@@ -348,7 +348,7 @@
 
 		int i;
 		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52,
73, 80, -1 };
-		static int logitech_wheel[] = { 52, 75, 76, 80, 81, 83,
88, -1 };
+		static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81,
83, 88, -1 };
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43,
50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83,
88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";

===================================================================

-- 
Vojtech Pavlik
SuSE Labs

