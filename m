Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264964AbUFAJos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbUFAJos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFAJos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:44:48 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57756 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264964AbUFAJoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:44:46 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <xb7n03n7i9k.fsf@savona.informatik.uni-freiburg.de> <xb73c5f8z9f.fsf@savona.informatik.uni-freiburg.de> <20040528195709.GB5175@pclin040.win.tue.nl> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Subject: BUG FIX: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
References: <200406010904.i5194pSo010367@fire-2.osdl.org>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 01 Jun 2004 11:44:44 +0200
In-Reply-To: <200406010904.i5194pSo010367@fire-2.osdl.org>
Message-ID: <xb7iseb7gtv.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "bugme-daemon" == bugme-daemon  <bugme-daemon@osdl.org> writes:

    bugme-daemon> http://bugme.osdl.org/show_bug.cgi?id=2808
    bugme-daemon> vojtech@suse.cz changed:

    bugme-daemon>    What    |Removed             |Added
    bugme-daemon> ----------------------------------------------------
    bugme-daemon>      Status|NEW                 |REJECTED
    bugme-daemon>  Resolution|                    |INVALID

    Vojtech> I'm sorry you can't use the fn+printscreen function on
    Vojtech> your LifeBook, but such is life. 

Disappointed.


    Vojtech> Is using Alt+printscreen such a big difference?

That means I need to press FOUR keys to use sysrq, because PrintScreen
is  only  available via  [Fn].   That becomes  [Fn]+Alt+PrintScreen+X,
where "X" is the sysrq function.  :(


    Vojtech> On USB keyboards (and many others, too), there is no
    Vojtech> specific SysRq keycode, and thus the kernel magic-sysrq
    Vojtech> handler uses the alt-printscreen combination, to make it
    Vojtech> work on ALL keyboards. This is intentional.

Isn't  the keyboard  driver  supposed to  iron  out such  differences?
Isn't  it your  philosophy that  the drivers  should know  the devices
well, and present  a consistent interface to the  upper layers?  Then,
the correct way to do it is:

        USB keyboard driver: generate a "sysrq" event in reaction to
                             Alt-PrintScreen 
        AT/PS2 keyboard driver: generate a "sysrq" when receiving a
                                0x54 keycode

The  kernel  keyboard  handler  shouldn't  see  or  bother  about  the
difference.   It is  insane that  the handler  has to  care  about the
status of the Alt keys.


    Vojtech> Further, keycode 99 is KEY_SYSRQ, as defined in input.h,

Then, why use it for PrintScreen?   With the 'evbug' facility, I see a
keyboard  event with code  KEY_SYSRQ when  I press  PrintScreen.  Just
PrintScreen, not  Alt-PrintScreen.  So,  this is a  feature and  not a
bug?


    Vojtech> and is used for the PrtScr/SysRq key. 

So, why not have seperate keycodes for the two?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

