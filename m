Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265691AbSKFPXN>; Wed, 6 Nov 2002 10:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265692AbSKFPXN>; Wed, 6 Nov 2002 10:23:13 -0500
Received: from signup.localnet.com ([207.251.201.46]:40117 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S265691AbSKFPXK>;
	Wed, 6 Nov 2002 10:23:10 -0500
To: linux-kernel@vger.kernel.org
Cc: linuxconsole-dev@lists.sourceforge.net
Subject: 2.5 bk, input driver and dell i8100 nib+pad
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 06 Nov 2002 10:29:37 -0500
Message-ID: <m3n0omk97i.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying out 2.5, I've got only a partially working mouse.  The usb
mouse is fully functional, as are both sets of buttons on the
notebook.  The mouse pad works, but the nib is ignored.

Of course, I only ever use the nib and only noticed that the pad was
working by accident.

I seem to recall a similar post some time back, but cannot find it in
my archives.  

Any ideas?

I do need to reboot into 2.4 and clone my bk clone from the sbp2 disk
to the internal disk (ohci1394 is b0rked ATM) to see the .config I
ended up with....

The relevant X config is:

Section "ServerFlags"
  Option       "AllowMouseOpenFail"
EndSection

Section "InputDevice"
  Driver       "mouse"
  Identifier   "Mouse[1]"
  Option       "Device" "/dev/psaux"
  Option       "InputFashion" "Mouse"
  Option       "Name" "AutoDetected"
  Option       "Protocol" "ps/2"
  Option       "Vendor" "AutoDetected"
  Option       "Emulate3Buttons" "on"
EndSection

Section "InputDevice"
  Driver       "mouse"
  Identifier   "USBmouse"
  Option       "Device" "/dev/input/mice"
  Option       "Name" "AutoDetected"
  Option       "Protocol" "IMPS/2"
  Option       "Vendor" "AutoDetected"
  Option       "ZAxisMapping" "4 5"
EndSection

Section "ServerLayout"
  Identifier   "Layout[all]"
  InputDevice  "Keyboard[0]" "CoreKeyboard"
  InputDevice  "Mouse[1]" "CorePointer"
  InputDevice  "USBmouse" "SendCoreEvents"
  Option       "Clone" "off"
  Option       "Xinerama" "off"
  Screen       "Screen[0]"
EndSection

-JimC

