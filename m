Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265550AbSJSHpg>; Sat, 19 Oct 2002 03:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265551AbSJSHpg>; Sat, 19 Oct 2002 03:45:36 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:55221 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265550AbSJSHpf>;
	Sat, 19 Oct 2002 03:45:35 -0400
Date: Sat, 19 Oct 2002 09:51:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christopher Hoover <ch@murgatroid.com>
Cc: "'Vojtech Pavlik'" <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Message-ID: <20021019095117.A1354@ucw.cz>
References: <20021018110625.A26788@ucw.cz> <004401c276cd$95d3bc90$8100000a@bergamot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004401c276cd$95d3bc90$8100000a@bergamot>; from ch@murgatroid.com on Fri, Oct 18, 2002 at 10:41:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:41:25AM -0700, Christopher Hoover wrote:

> > No, it unfortunately is not a proper fix. I'll have to analyze the
> > problem some more.
> 
> Would you say more?  I looked at XFree86 sources and it seemed that the
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

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Sat Oct 19 09:50:17 2002
+++ b/drivers/input/mouse/psmouse.c	Sat Oct 19 09:50:17 2002
@@ -348,7 +348,7 @@
 
 		int i;
 		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
-		static int logitech_wheel[] = { 52, 75, 76, 80, 81, 83, 88, -1 };
+		static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, -1 };
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83, 88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";

===================================================================

-- 
Vojtech Pavlik
SuSE Labs
