Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTHWMfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTHWMfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:35:20 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:8881 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264203AbTHWMdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:33:39 -0400
Message-ID: <003601c36972$a6835940$78ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andries Brouwer" <aebr@win.tue.nl>
References: <138e01c364ab$15b6c2b0$1aee4ca5@DIAMONDLX60> <1061141113.21878.76.camel@dhcp23.swansea.linux.org.uk> <151801c36577$10e4f5a0$1aee4ca5@DIAMONDLX60> <20030818110026.GA29405@ucw.cz>
Subject: Re: Trying to run 2.6.0-test3
Date: Sat, 23 Aug 2003 21:29:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vojtech Pavlik" <vojtech@suse.cz> replied to me with the program evtest.c.

> > Hirofumi Ogawa posted a patch for the yen-sign pipe key on 2003.07.23
> > for test1 but his patch still didn't get into test3.
>
> It will get into 2.6 sooner or later.
>
> > On a PS/2 keyboard that
> > seems to be the only key with any problem.
> >
> > Yesterday when I finally tried a USB keyboard and found that the
> > backslash underbar has the same problem, maybe I was the first person to
> > even try a Japanese USB keyboard in 2.6, and maybe no one at all tried
> > some number of 2.5 series kernels.
>
> If you can find out what input event the key generates (using the evtest
> program attached), then please tell me, and I'll fix in the same way as
> the yen key was fixed.
>
> > As mentioned, usually I can only spend one day a week
> > testing 2.6.

For this test, I used a laptop with a built-in emulated PS/2 keyboard and
mouse, and plugged in a USB keyboard.  I do not dare yet to try 2.6.0-testN
on a small-size desktop which depends entirely on USB.  The small-size
desktop provides BIOS emulation of a PS/2 keyboard from boot until the OS
detects USB devices.  It does not provide any emulation of an i8042 chip.
(Windows NT4 blue-screens if I forget to disable its i8042 driver.)  It
does not have PS/2 ports.

Back to the laptop used in this test.  Since the built-in emulated PS/2
keyboard had some "?" events, I ran evtest on all devices.  Sorry this
is still 2.6.0-test3.  I wanted to finish this test before experimenting
with 2.6.0-test4.  I already patched the 2.6.0-test3 keyboard map, so the
yen-sign pipe key produces input in both X11 and text consoles.  The USB
problem is with the yen-sign or-bar key, which seems to produce events
properly, and which produces correct input under X11, but produces no
input to a plain text console.  I wonder what needs patching for this.

In a plain text console, in the built-in emulated PS/2 keyboard, both the
yen-sign or-bar and backslash underbar keys are working because of the
patch.  But in the USB keyboard, the yen-sign or-bar key is working while
the backslash underbar key yields no input.

First, here are results of running evtest under X11.

The emulated PS/2 mouse looks fine.

ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event0
Input driver version is 1.0.0
Input device ID: bus 0x11 vendor 0x2 product 0x1 version 0x29
Input device name: "PS/2 Logitech Mouse"
Supported events:
  Event type 0 (Reset)
    Event code 0 (Reset)
    Event code 1 (Key)
    Event code 2 (Relative)
  Event type 1 (Key)
    Event code 272 (LeftBtn)
    Event code 273 (RightBtn)
    Event code 275 (SideBtn)
  Event type 2 (Relative)
    Event code 0 (X)
    Event code 1 (Y)
Testing ... (interrupt to exit)
Event: time 1061637735.598896, type 2 (Relative), code 1 (Y), value 1
Event: time 1061637735.598936, type 0 (Reset), code 0 (Reset), value 0
[...]
Event: time 1061637735.634618, type 2 (Relative), code 0 (X), value 1
Event: time 1061637735.634657, type 0 (Reset), code 0 (Reset), value 0
[...]
Event: time 1061637737.663347, type 1 (Key), code 273 (RightBtn), value 1
Event: time 1061637737.663390, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061637737.806503, type 1 (Key), code 273 (RightBtn), value 0
Event: time 1061637737.806543, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061637739.053020, type 1 (Key), code 272 (LeftBtn), value 1
Event: time 1061637739.053068, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061637739.144967, type 1 (Key), code 272 (LeftBtn), value 0
Event: time 1061637739.145016, type 0 (Reset), code 0 (Reset), value 0

Here is the emulated PS/2 keyboard.  I did not try all keys.  In fact I
cannot try a number of keys which appear in the list but don't exist.
I did try the ones which are frequently mishandled, yen-sign or-bar and
backslash underbar.

ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event1
Input driver version is 1.0.0
Input device ID: bus 0x11 vendor 0x1 product 0x2 version 0xab02
Input device name: "AT Set 2 keyboard"
Supported events:
  Event type 0 (Reset)
    Event code 0 (Reset)
    Event code 1 (Key)
    Event code 17 (LED)
    Event code 20 (Repeat)
  Event type 1 (Key)
    Event code 1 (Esc)
    Event code 2 (1)
    Event code 3 (2)
    Event code 4 (3)
    Event code 5 (4)
    Event code 6 (5)
    Event code 7 (6)
    Event code 8 (7)
    Event code 9 (8)
    Event code 10 (9)
    Event code 11 (0)
    Event code 12 (Minus)
    Event code 13 (Equal)
    Event code 14 (Backspace)
    Event code 15 (Tab)
    Event code 16 (Q)
    Event code 17 (W)
    Event code 18 (E)
    Event code 19 (R)
    Event code 20 (T)
    Event code 21 (Y)
    Event code 22 (U)
    Event code 23 (I)
    Event code 24 (O)
    Event code 25 (P)
    Event code 26 (LeftBrace)
    Event code 27 (RightBrace)
    Event code 28 (Enter)
    Event code 29 (LeftControl)
    Event code 30 (A)
    Event code 31 (S)
    Event code 32 (D)
    Event code 33 (F)
    Event code 34 (G)
    Event code 35 (H)
    Event code 36 (J)
    Event code 37 (K)
    Event code 38 (L)
    Event code 39 (Semicolon)
    Event code 40 (Apostrophe)
    Event code 41 (Grave)
    Event code 42 (LeftShift)
    Event code 43 (BackSlash)
    Event code 44 (Z)
    Event code 45 (X)
    Event code 46 (C)
    Event code 47 (V)
    Event code 48 (B)
    Event code 49 (N)
    Event code 50 (M)
    Event code 51 (Comma)
    Event code 52 (Dot)
    Event code 53 (Slash)
    Event code 54 (RightShift)
    Event code 55 (KPAsterisk)
    Event code 56 (LeftAlt)
    Event code 57 (Space)
    Event code 58 (CapsLock)
    Event code 59 (F1)
    Event code 60 (F2)
    Event code 61 (F3)
    Event code 62 (F4)
    Event code 63 (F5)
    Event code 64 (F6)
    Event code 65 (F7)
    Event code 66 (F8)
    Event code 67 (F9)
    Event code 68 (F10)
    Event code 69 (NumLock)
    Event code 70 (ScrollLock)
    Event code 71 (KP7)
    Event code 72 (KP8)
    Event code 73 (KP9)
    Event code 74 (KPMinus)
    Event code 75 (KP4)
    Event code 76 (KP5)
    Event code 77 (KP6)
    Event code 78 (KPPlus)
    Event code 79 (KP1)
    Event code 80 (KP2)
    Event code 81 (KP3)
    Event code 82 (KP0)
    Event code 83 (KPDot)
    Event code 85 (F13)
    Event code 86 (102nd)
    Event code 87 (F11)
    Event code 88 (F12)
    Event code 89 (F14)
    Event code 90 (F15)
    Event code 91 (F16)
    Event code 92 (F17)
    Event code 93 (F18)
    Event code 94 (F19)
    Event code 95 (F20)
    Event code 96 (KPEnter)
    Event code 97 (RightCtrl)
    Event code 98 (KPSlash)
    Event code 99 (SysRq)
    Event code 100 (RightAlt)
    Event code 102 (Home)
    Event code 103 (Up)
    Event code 104 (PageUp)
    Event code 105 (Left)
    Event code 106 (Right)
    Event code 107 (End)
    Event code 108 (Down)
    Event code 109 (PageDown)
    Event code 110 (Insert)
    Event code 111 (Delete)
    Event code 112 (Macro)
    Event code 113 (Mute)
    Event code 114 (VolumeDown)
    Event code 115 (VolumeUp)
    Event code 116 (Power)
    Event code 118 (KPPlusMinus)
    Event code 119 (Pause)
    Event code 120 (F21)
    Event code 121 (F22)
    Event code 122 (F23)
    Event code 123 (F24)
    Event code 125 (LeftMeta)
    Event code 126 (RightMeta)
    Event code 127 (Compose)
    Event code 128 (Stop)
    Event code 133 (Copy)
    Event code 137 (Cut)
    Event code 138 (Help)
    Event code 140 (Calc)
    Event code 142 (Sleep)
    Event code 143 (WakeUp)
    Event code 144 (File)
    Event code 147 (X-fer)
    Event code 150 (WWW)
    Event code 151 (MSDOS)
    Event code 152 (Coffee)
    Event code 153 (Direction)
    Event code 155 (Mail)
    Event code 156 (Bookmarks)
    Event code 157 (Computer)
    Event code 158 (Back)
    Event code 159 (Forward)
    Event code 160 (CloseCD)
    Event code 163 (NextSong)
    Event code 164 (PlayPause)
    Event code 165 (PreviousSong)
    Event code 166 (StopCD)
    Event code 167 (Record)
    Event code 168 (Rewind)
    Event code 173 (Refresh)
    Event code 174 (Exit)
    Event code 182 (International2)
    Event code 183 (International3)
    Event code 217 (?)
    Event code 226 (?)
  Event type 17 (LED)
    Event code 0 (NumLock)
    Event code 1 (CapsLock)
    Event code 2 (ScrollLock)
  Event type 20 (Repeat)

[Here is yen-sign or-bar:]
Event: time 1061638812.315540, type 1 (Key), code 183 (International3), value 1
Event: time 1061638812.315548, type 0 (Reset), code 0 (Reset), value 0
\Event: time 1061638812.467647, type 1 (Key), code 183 (International3), value 0
Event: time 1061638812.467655, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638813.909474, type 1 (Key), code 42 (LeftShift), value 1
Event: time 1061638813.909482, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638814.159276, type 1 (Key), code 42 (LeftShift), value 2
Event: time 1061638814.159286, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638814.189239, type 1 (Key), code 42 (LeftShift), value 2
Event: time 1061638814.189246, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638814.209031, type 1 (Key), code 183 (International3), value 1
Event: time 1061638814.209039, type 0 (Reset), code 0 (Reset), value 0
|Event: time 1061638814.361093, type 1 (Key), code 183 (International3), value 0
Event: time 1061638814.361102, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638814.706204, type 1 (Key), code 42 (LeftShift), value 0
Event: time 1061638814.706211, type 0 (Reset), code 0 (Reset), value 0

[Here is backslash underbar:]
Event: time 1061638897.294886, type 1 (Key), code 89 (F14), value 1
Event: time 1061638897.294894, type 0 (Reset), code 0 (Reset), value 0
\Event: time 1061638897.416553, type 1 (Key), code 89 (F14), value 0
Event: time 1061638897.416560, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638898.462432, type 1 (Key), code 42 (LeftShift), value 1
Event: time 1061638898.462440, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638898.650346, type 1 (Key), code 89 (F14), value 1
Event: time 1061638898.650354, type 0 (Reset), code 0 (Reset), value 0
_Event: time 1061638898.761825, type 1 (Key), code 89 (F14), value 0
Event: time 1061638898.761833, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061638899.046039, type 1 (Key), code 42 (LeftShift), value 0
Event: time 1061638899.046051, type 0 (Reset), code 0 (Reset), value 0

Here is the external USB keyboard.  I did not try all keys.  In fact I
cannot try a number of keys which appear in the list but don't exist.
(Though the keyboard which I sent to Mike Fabian might really have some
of these, among its ton of funny extra buttons.)  I did try the ones
which are frequently mishandled, yen-sign or-bar and backslash underbar.  

ndiamond@diamondpana:~/linux-pavlik-evtest> evtest /dev/input/event2
Input driver version is 1.0.0
Input device ID: bus 0x3 vendor 0x409 product 0x14 version 0x100
Input device name: "NEC 109 JPN USB KBD/M"
Supported events:
  Event type 0 (Reset)
    Event code 0 (Reset)
    Event code 1 (Key)
    Event code 17 (LED)
    Event code 20 (Repeat)
  Event type 1 (Key)
    Event code 1 (Esc)
    Event code 2 (1)
    Event code 3 (2)
    Event code 4 (3)
    Event code 5 (4)
    Event code 6 (5)
    Event code 7 (6)
    Event code 8 (7)
    Event code 9 (8)
    Event code 10 (9)
    Event code 11 (0)
    Event code 12 (Minus)
    Event code 13 (Equal)
    Event code 14 (Backspace)
    Event code 15 (Tab)
    Event code 16 (Q)
    Event code 17 (W)
    Event code 18 (E)
    Event code 19 (R)
    Event code 20 (T)
    Event code 21 (Y)
    Event code 22 (U)
    Event code 23 (I)
    Event code 24 (O)
    Event code 25 (P)
    Event code 26 (LeftBrace)
    Event code 27 (RightBrace)
    Event code 28 (Enter)
    Event code 29 (LeftControl)
    Event code 30 (A)
    Event code 31 (S)
    Event code 32 (D)
    Event code 33 (F)
    Event code 34 (G)
    Event code 35 (H)
    Event code 36 (J)
    Event code 37 (K)
    Event code 38 (L)
    Event code 39 (Semicolon)
    Event code 40 (Apostrophe)
    Event code 41 (Grave)
    Event code 42 (LeftShift)
    Event code 43 (BackSlash)
    Event code 44 (Z)
    Event code 45 (X)
    Event code 46 (C)
    Event code 47 (V)
    Event code 48 (B)
    Event code 49 (N)
    Event code 50 (M)
    Event code 51 (Comma)
    Event code 52 (Dot)
    Event code 53 (Slash)
    Event code 54 (RightShift)
    Event code 55 (KPAsterisk)
    Event code 56 (LeftAlt)
    Event code 57 (Space)
    Event code 58 (CapsLock)
    Event code 59 (F1)
    Event code 60 (F2)
    Event code 61 (F3)
    Event code 62 (F4)
    Event code 63 (F5)
    Event code 64 (F6)
    Event code 65 (F7)
    Event code 66 (F8)
    Event code 67 (F9)
    Event code 68 (F10)
    Event code 69 (NumLock)
    Event code 70 (ScrollLock)
    Event code 71 (KP7)
    Event code 72 (KP8)
    Event code 73 (KP9)
    Event code 74 (KPMinus)
    Event code 75 (KP4)
    Event code 76 (KP5)
    Event code 77 (KP6)
    Event code 78 (KPPlus)
    Event code 79 (KP1)
    Event code 80 (KP2)
    Event code 81 (KP3)
    Event code 82 (KP0)
    Event code 83 (KPDot)
    Event code 84 (103rd)
    Event code 85 (F13)
    Event code 86 (102nd)
    Event code 87 (F11)
    Event code 88 (F12)
    Event code 89 (F14)
    Event code 90 (F15)
    Event code 91 (F16)
    Event code 92 (F17)
    Event code 93 (F18)
    Event code 94 (F19)
    Event code 95 (F20)
    Event code 96 (KPEnter)
    Event code 97 (RightCtrl)
    Event code 98 (KPSlash)
    Event code 99 (SysRq)
    Event code 100 (RightAlt)
    Event code 102 (Home)
    Event code 103 (Up)
    Event code 104 (PageUp)
    Event code 105 (Left)
    Event code 106 (Right)
    Event code 107 (End)
    Event code 108 (Down)
    Event code 109 (PageDown)
    Event code 110 (Insert)
    Event code 111 (Delete)
    Event code 113 (Mute)
    Event code 114 (VolumeDown)
    Event code 115 (VolumeUp)
    Event code 116 (Power)
    Event code 117 (KPEqual)
    Event code 119 (Pause)
    Event code 120 (F21)
    Event code 121 (F22)
    Event code 122 (F23)
    Event code 123 (F24)
    Event code 124 (KPComma)
    Event code 125 (LeftMeta)
    Event code 126 (RightMeta)
    Event code 127 (Compose)
    Event code 128 (Stop)
    Event code 129 (Again)
    Event code 130 (Props)
    Event code 131 (Undo)
    Event code 132 (Front)
    Event code 133 (Copy)
    Event code 134 (Open)
    Event code 135 (Paste)
    Event code 136 (Find)
    Event code 137 (Cut)
    Event code 138 (Help)
    Event code 140 (Calc)
    Event code 142 (Sleep)
    Event code 150 (WWW)
    Event code 152 (Coffee)
    Event code 158 (Back)
    Event code 159 (Forward)
    Event code 161 (EjectCD)
    Event code 163 (NextSong)
    Event code 164 (PlayPause)
    Event code 165 (PreviousSong)
    Event code 166 (StopCD)
    Event code 173 (Refresh)
    Event code 176 (Edit)
    Event code 177 (ScrollUp)
    Event code 178 (ScrollDown)
    Event code 181 (International1)
    Event code 182 (International2)
    Event code 183 (International3)
    Event code 184 (International4)
    Event code 185 (International5)
    Event code 186 (International6)
    Event code 187 (International7)
    Event code 188 (International8)
    Event code 189 (International9)
    Event code 190 (Language1)
    Event code 191 (Language2)
    Event code 192 (Language3)
    Event code 193 (Language4)
    Event code 194 (Language5)
    Event code 195 (Language6)
    Event code 196 (Language7)
    Event code 197 (Language8)
    Event code 198 (Language9)
    Event code 240 (?)
  Event type 17 (LED)
    Event code 0 (NumLock)
    Event code 1 (CapsLock)
    Event code 2 (ScrollLock)
  Event type 20 (Repeat)
Testing ... (interrupt to exit)

[Here is yen-sign or-bar:]
Event: time 1061639164.238590, type 1 (Key), code 183 (International3), value 1
Event: time 1061639164.238602, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639164.318573, type 1 (Key), code 183 (International3), value 0
Event: time 1061639164.318584, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639168.837822, type 1 (Key), code 54 (RightShift), value 1
Event: time 1061639168.837838, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639169.087280, type 1 (Key), code 54 (RightShift), value 2
Event: time 1061639169.087291, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639169.117272, type 1 (Key), code 54 (RightShift), value 2
Event: time 1061639169.117279, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639169.125757, type 1 (Key), code 183 (International3), value 1
Event: time 1061639169.125768, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639169.237759, type 1 (Key), code 183 (International3), value 0
Event: time 1061639169.237772, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639169.477720, type 1 (Key), code 54 (RightShift), value 0
Event: time 1061639169.477736, type 0 (Reset), code 0 (Reset), value 0

[Here is backslash underbar:]
Event: time 1061639230.403570, type 1 (Key), code 181 (International1), value 1
Event: time 1061639230.403585, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639230.499543, type 1 (Key), code 181 (International1), value 0
Event: time 1061639230.499556, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639231.275459, type 1 (Key), code 54 (RightShift), value 1
Event: time 1061639231.275483, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639231.419385, type 1 (Key), code 181 (International1), value 1
Event: time 1061639231.419396, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639231.491366, type 1 (Key), code 181 (International1), value 0
Event: time 1061639231.491379, type 0 (Reset), code 0 (Reset), value 0
Event: time 1061639231.691448, type 1 (Key), code 54 (RightShift), value 0
Event: time 1061639231.691467, type 0 (Reset), code 0 (Reset), value 0

Next I switched to a text-mode console and tested the same two keyboards.
The key codes seem to be the same.

