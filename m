Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbRGRT1E>; Wed, 18 Jul 2001 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRT0y>; Wed, 18 Jul 2001 15:26:54 -0400
Received: from [200.197.178.146] ([200.197.178.146]:4086 "EHLO desenv00")
	by vger.kernel.org with ESMTP id <S267918AbRGRT0d>;
	Wed, 18 Jul 2001 15:26:33 -0400
Message-ID: <3B55E2AB.5080608@usa.net>
Date: Wed, 18 Jul 2001 16:25:31 -0300
From: Eduardo <eduardo.sp@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] gamecon.c change for SNES controller
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavlik -

I've had to applie the following change to make the SNES controller work 
at the parallel port. It have been applied to two computers. The old 
code was giving the same values when you pressed right or left or when 
you pressed up or down. The new code have been done to not use expensive 
codification (i.e. multiplication).

It have been applied to kernel 2.4.6, and compiled with gcc 3.0.

See ya,

Eng. Eduardo Bortoluzzi Junior
mailto:eduardo.sp@usa.net


--- start of patch ---

--- drivers/char/joystick/gamecon.c.orig Sat Jul 14 19:03:12 2001
+++ drivers/char/joystick/gamecon.c     Wed Jul 18 16:00:50 2001
@@ -345,8 +345,8 @@
                        s = gc_status_bit[i];
 
                        if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
-                               input_report_abs(dev + i, ABS_X, ! - !(s 
& data[6]) - !(s & data[7]));
-                               input_report_abs(dev + i, ABS_Y, ! - !(s 
& data[4]) - !(s & data[5]));
+                               input_report_abs(dev + i, ABS_X, - !!(s 
& data[6]) + !!(s & data[7]));
+                               input_report_abs(dev + i, ABS_Y, - !!(s 
& data[4]) + !!(s & data[5]));
                        }
 
                        if (s & gc->pads[GC_NES])

--- end of patch ---

