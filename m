Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279296AbRJWGyu>; Tue, 23 Oct 2001 02:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279295AbRJWGyl>; Tue, 23 Oct 2001 02:54:41 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:13828 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279292AbRJWGy3>;
	Tue, 23 Oct 2001 02:54:29 -0400
Message-Id: <5.1.0.14.0.20011023161901.00a65870@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 23 Oct 2001 16:54:59 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: SiS630S FrameBuffer & LCD
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like my previous SiS post, I'm once again using the Clevo lp200t (SiS630S 
chipset), and trying to enable the SiS FrameBuffer device. Once again, this 
happens on 2.4.9, 2.4.10, and 2.4.12.

On issuing of 'modprobe sisfb' the LCD display gives one of the following 
symptoms:

  1. The display goes totally blank.
  2. The display "glows" an indeterminate color and eventually fades out 
(may take a minute to fade out).

In either case, the machine continues to run happily, and I can either ssh 
in and/or run programs stuff in the shell (with no visual output). Seems 
fbset makes no difference (went through all the resolution/scan/bit-depths 
with no luck - from an su'd session via ssh and specifying the FrameBuffer 
device directly). The machine has an external VGA port, that by default is 
a "mirror" of the LCD display. Plugging a display in makes no difference, 
and the display is also blank (tried at boot, before and after the module 
has been loaded).

This problem also appears with the XFree86 SiS chipset drivers on the same 
machine, and appears to be related to the code that sets the resolutions. 
Disabling resolution changes (hacking up the XFree86 SiS driver) and using 
Vesa FrameBuffer to set 1024x768 at boot only provides a clumsy workaround 
(you can still change bit-depths and scan rates fine, but you can't change 
the resolution - changing that causes the problem).

A few messages off the XFree86 Xpert list seem to have shed a little light 
on the problem, in that it seems some registers return values that the code 
may not understand how to deal with.

It seems plausible that the documentation that SiS has provided is now 
out--of-date, and/or the drivers are assuming the wrong things in cases of 
the unknown. The problem is easily reproducible, and the SiS630S chipset 
(which seems to be the one affected, but may not necessarily be the only 
one) is becoming more widespread in laptop/all-in-one PC's.

If you need more information and/or debug output to help resolve this, just 
ask.

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

