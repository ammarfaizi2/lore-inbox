Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130635AbQL1KiV>; Thu, 28 Dec 2000 05:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQL1KiL>; Thu, 28 Dec 2000 05:38:11 -0500
Received: from ns1.equation.fr ([213.56.79.161]:7688 "EHLO sol.equation.fr")
	by vger.kernel.org with ESMTP id <S129775AbQL1Kh4> convert rfc822-to-8bit;
	Thu, 28 Dec 2000 05:37:56 -0500
Mime-Version: 1.0
Message-Id: <a05010400b670b2e65882@[192.168.240.10]>
Date: Thu, 28 Dec 2000 11:07:27 +0100
To: linuxppc-user@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Keyboard mapping, the problem
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one of the new feature of the new 2.2.18 kernel (at least ppc kernel, 
I don't know about the standard kernel.org kernel) is the new 
keyboard mapping.

The idea is that if you set 
/proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes to 1, the raw 
kaycodes sent by the keyboard are mapped to the "standard" linux 
keycodes, i.e. intel PC raw keycodes.

This seams to be a good idea because once this is done, you may use 
the standard keyboard mapping tables from the intel linux and don't 
have to setup mapping for each plateforms.

The problem is that it is in fact not such a good idea. For example 
on the french market here are the description of two mostly 
encountered keyboards :

French PC keyboard :

ESC   F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   F12
^2    &/1   é/2/~ "/3/# '/4/{ (/5/[ -/6/| è/7/` _/8/\ ç/9/^ à/0/@ 
)/°/] =/+/} BS
TAB   a/A   z/Z   e/E/¤ r/R   t/T   y/Y   u/U   i/I   o/O   p/P   ^/¨ 
$/£   CR
CAPS  q/Q   s/S   d/D   f/F   g/G   h/H   j/J   k/K   l/L   m/M   ù/%   */µ
SHIFT </>   w/W   x/X   c/C   v/V   b/B   n/N   ,/?   ;/.   ://   !/§   SHIFT
CTRL  WIN   ALT   SPACE ALTG  CTRL

French Mac Keyboard :

ESC   F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   F12
@/#   &/1   é/2   "/3   '/4   (/5   §/6   è/7   !/8   ç/9   à/0   )/° 
-/_   BS
TAB   a/A   z/Z   e/E   r/R   t/T   y/Y   u/U   i/I   o/O   p/P   ^/¨ 
$/*/¤ CR
CAPS  q/Q   s/S   d/D   f/F   g/G   h/H   j/J   k/K   l/L   m/M   ù/%   `/£
SHIFT </>   w/W   x/X   c/C   v/V   b/B   n/N   ,/?   ;/.   ://   =/+   SHIFT
CTRL  OPT   CMD   SPACE CMD   OPT   CTRL


You may see there are a lot of similarities and differences :

- french keyboards are AZERTY and not QWERTY and both implements the 
letters at the same place.

- there is no standard on the french market for the special 
characters {} [] _ @ # | ` \ = + ! § < > that are very common on a 
computer. So PC plateforms implements them very differently than on 
the mac plateform, but also than on other plateforms or typewritters. 
The problem here is that the french mapping is printed on the 
keyboard, so using a french intel linux mapping on a french mac 
keyboard is useless (if you type = you get !, and so on).

- on the two plateforms, there are different way of getting the other 
characters than lowercase and uppercase. On the PC side, some keys 
return a third character by using the ALTGR key (at the right of the 
space bar). On the mac side you have to use the OPTION key on either 
the left or right of the space bar. This OPTION key is also printed 
with as ALT but its function is the same as the ALTGR and not ALT PC 
key.

- PC keyboards have several keys without equivalent on the mac side 
(WIN keys for example). Mac keyboards also have special keys (for 
example the new eject key on recent USB keyboards).

- both plateforms has different ways of mapping special characters. 
On the PC side, the ALTGR key is used only on keys with a third 
character mapped on it, or with the keypad to generate any ISO-1 
code, and there is no special logic on this mapping. On the mac side, 
the option key try to have some logic on the mapping and almost all 
keys may generate 4 mappings (a, shift a=A, Opt a=æ (ae),  Shift Opt 
a=Æ (AE)). In fact on a french mac keyboard, the only key that have 
more than 2 characters printed on it is the $/*/¤ key because of the 
recent Euro character addition. Mac users do not need the ALTGR key 
99% of the time !


So the new way of mapping mac french keyboard (and probably french 
keyboard from the other plateforms but intel) is very bad and 
useless. So in all cases, the intel french keyboard mapping is 
useless as is on a french mac keyboard and we need to make a special 
one.

So the problem is what is the interest if the new mapping ? Why is it 
now the new default settings ? In my experience, 80% of the support 
problem I have encountered with Linux users on the mac side is with 
the setting of a decent keyboard mapping on the console AND on the X 
side.

The new raw keycodes mapping is the worst thing we have got for the 
linuxppc support; we now have :

- 2 raw keycodes mapping (old ADB one and new keyboard_sends_linux_keycodes)
- 2 logical keycode mapping : one for the console and an other for X.
- at least 4 different X servers to support (XFree 3.3, Xpmac, XFree 
4.0, XFree 4.0.[12]). All of theses X server have a different 
approach to the mapping problem !
- french logical keyboard mapping are not standard in the 
distribution, so the user have to get files elsewhere.

as you may see, this is a lot of different combinations and the user 
is very clever when he manage to get its keyboard working !

I think the main problem is that linux do not consider the keyboard 
as a real device with a real driver associated with it, so it tries 
to implement only one keyboard driver or one keyboard driver per bus 
(ADB/USB/PS2), but I think this is not the good solution. For example 
there are USB keyboard targetted to the Mac market that have a Mac 
mapping printed on it and there are USB keyboards targetted mainly 
for the PC market that have a PC mapping printed on it. All are 
useable as it under linux intel or linux ppc and this is not the USB 
bus that must implies the mapping (this is why I think the remapping 
of ADB keycodes to intel linux raw keycodes is not a such good idea).

So we need a clever keyboard abstraction in the linux kernel.

And don't forget that if this problem is not present on the english 
market, the rest of the world use diatrical marks or several bytes 
per characters (95% of the market ?).
-- 
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
