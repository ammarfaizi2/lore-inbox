Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280110AbRKNEtI>; Tue, 13 Nov 2001 23:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280118AbRKNEs5>; Tue, 13 Nov 2001 23:48:57 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:47748 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S280110AbRKNEso>; Tue, 13 Nov 2001 23:48:44 -0500
Date: Tue, 13 Nov 2001 20:17:35 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on USB mouse & laptop.
In-Reply-To: <3BF1E9CD.9050702@candelatech.com>
Message-ID: <Pine.LNX.4.33.0111132007350.7976-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you need to run gpm -M (for gpm console dual mouse support

for xf86 4.x you need to make sure there are two mouse setups...

something like:

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Device" "/dev/mouse"
        Option      "Protocol" "PS/2"
        Option      "Emulate3Buttons" "off"
        Option      "ZAxisMapping" "4 5"
EndSection
To add another mouse just copy the above section and modify it, so that it 
reads:
Section "InputDevice"
        Identifier  "Mouse1"
        Driver      "mouse"
        Option      "Device" "/dev/input/mice"
        Option      "Protocol" "IMPS/2"
        Option      "Emulate3Buttons" "off"
        Option      "ZAxisMapping" "4 5"
EndSection
 
then tweak the server layout section for the second mouse...

Section "ServerLayout"
        Identifier "XFree86 Configured"
        Screen      0  "Screen0" 0 0
        InputDevice    "Mouse0" "CorePointer"
        InputDevice    "Mouse1" "AlwaysCore"
        InputDevice    "Keyboard0" "CoreKeyboard"
EndSection


see if that helps...


On Tue, 13 Nov 2001, Ben Greear wrote:

> I have a Sony VAIO laptop.  When I plug in my USB keyboard, I can use both
> it and the built-in keyboard.  However, it boots up with the USB mouse in,
> I can only use the USB mouse, not the built-in scratch-pad mouse.
> (Other than that, the USB stuff seems to work great!)
> 
> Is this expected behaviour?
> If not, I'll send in a detailed report on my system...
> 
> Thanks,
> Ben
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


