Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUCPBmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbUCPBl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:41:57 -0500
Received: from ophelia.g5n.co.uk ([81.2.120.180]:60544 "EHLO ophelia.g5n.co.uk")
	by vger.kernel.org with ESMTP id S263392AbUCPBcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:32:23 -0500
Date: Tue, 16 Mar 2004 01:32:23 +0000
From: Toby A Inkster <tobyink@goddamn.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Mouse wheel problems again...
Message-ID: <20040316013223.GA4170@ophelia.goddamn.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.6.3-2gmdk (i686)
X-Uptime: 01:06:16 up 38 min,  3 users,  load average: 0.49, 0.77, 0.85
X-Editor: GNU nano 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear all,

Am having problems using my mouse wheel on 2.6.3, when it worked fine in
2.4.24.

Technically it's not a mouse, but a trackball. And technically not a wheel,
but a couple of buttons. But this shouldn't make any difference, should it?

When I click the scroll buttons they are both treated as middle-click (butt=
on
2) when they should be treated as scrolling (buttons 4 and 5) -- this is
according to xev.

The mouse is plugged into the PS/2 port, but I also have the USB mouse stuff
compiled as a module just in case I change my mind.

I think I've tried most of the suggestions I could find in the archive and
on Google.

Using hexdump on /dev/input/mice, the signals sent for up and down scroll
buttons seem identical to each other.

Here is some (possibly relevent) information:

[tai@ophelia (pts/1) ~]$ cat /boot/config | grep -i mouse ; echo ''
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_USB_MOUSE=3Dm

[tai@ophelia (pts/1) ~]$ dmesg | grep -i mouse ; echo ''
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1

[tai@ophelia (pts/1) input]$ cat /proc/bus/input/devices|tac|tail -n 8|tac
I: Bus=3D0011 Vendor=3D0002 Product=3D0001 Version=3D006d
N: Name=3D"PS/2 Logitech Mouse"
P: Phys=3Disa0060/serio1/input0
H: Handlers=3Dmouse0=20
B: EV=3D7=20
B: KEY=3D70000 0 0 0 0 0 0 0 0=20
B: REL=3D3=20


And here's some stuff from XF86Config-4:

Section "InputDevice"
    Identifier  "Mouse1"
    Driver      "mouse"
    Option      "SendCoreEvents"        "true"
    Option      "Device"                "/dev/input/mice"
    Option      "Protocol"              "ExplorerPS/2"
    Option      "Buttons"               "5"
    Option      "Emulate3Buttons"
    Option      "Emulate3Timeout"       "50"
    Option      "ZAxisMapping"          "4 5"
EndSection
# [...]
Section "ServerLayout"
    Identifier "layout1"
    InputDevice "Keyboard1" "CoreKeyboard"
    InputDevice "Mouse1" "CorePointer"
    Screen "screen1"
    InputDevice "Mouse1" "SendCoreEvents"
EndSection
                                    =20
                                    =20
Any suggesitons?

Thanks in advance for any light than can be shed.

--=20
Toby A Inkster BSc (Hons) ARCS
Contact Me - http://www.goddamn.co.uk/tobyink/?page=3D132

Q: WHY DO ELEPHANTS HAVE BIG EARS?
A: BECAUSE NODDY WOULDN'T PAY THE RANDOM.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVlknzr+BKGoqfTkRAnDRAJ4zN2czf3thxFPZ+wmTxw9HD9GNVACeJhuq
LxA1v9+C/ALOETVjQumYwAw=
=XKTU
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
