Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUIFMW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUIFMW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUIFMW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:22:58 -0400
Received: from web8508.mail.in.yahoo.com ([202.43.219.170]:24964 "HELO
	web8508.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S267852AbUIFMWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:22:37 -0400
Message-ID: <20040906122232.19944.qmail@web8508.mail.in.yahoo.com>
Date: Mon, 6 Sep 2004 13:22:32 +0100 (BST)
From: =?iso-8859-1?q?Dinesh=20Ahuja?= <mdlinux7@yahoo.co.in>
Subject: Re: Mouse Support in Kernel 2.6.8
To: Yapo Sebastien <sebastien.yapo@e-neyret.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040906095201.18288.qmail@web8502.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have observed something which I would like to share
with you. Do we need to change XF86Config file when we
are migrating from Kernel 2.4 to 2.6.8 ?

Whenever I boot my system [ either in Kernel 2.4 or
2.6.8], I am prompt by kudzu to configure/
unconfigure the following hardware devices:

1. LGI|8051
2. Generic PS/2 Wheel Mouse

If I configure LGI|8051 only [not Generic Mouse
because If I configure Generic Mouse, then I donot get
Mouse Support in Kernel 2.4] in my Kernel 2.4, then
everything works fine and I get mouse support. But If
try to do the same thing in Kernel 2.6.8 [ i.e
configure LGI|8051 and don't configure Generic PS/2],
then my Kernel gives error in launching X Server and
error is as follows:
xf86OpenSerial can't open device /dev/ttyS1

My XF86Config contents are as follows:
# XFree86 4 configuration created by
redhat-config-xfree86

Section "ServerLayout"
	Identifier     "Default Layout"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
	InputDevice    "DevInputMice" "AlwaysCore"
EndSection

Section "Files"

# RgbPath is the location of the RGB database.  Note,
this is the name of the 
# file minus the extension (like ".txt" or ".db"). 
There is normally
# no need to change the default.
# Multiple FontPath entries are allowed (they are
concatenated together)
# By default, Red Hat 6.0 and later now use a font
server independent of
# the X server to render fonts.
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "unix/:7100"
EndSection

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
EndSection

Section "InputDevice"

# Specify which keyboard LEDs can be user-controlled
(eg, with xset(1))
#	Option	"Xleds"		"1 2 3"
# To disable the XKEYBOARD extension, uncomment
XkbDisable.
#	Option	"XkbDisable"
# To customise the XKB settings to suit your keyboard,
modify the
# lines below (which are the defaults).  For example,
for a non-U.S.
# keyboard, you will probably want to use:
#	Option	"XkbModel"	"pc102"
# If you have a US Microsoft Natural keyboard, you can
use:
#	Option	"XkbModel"	"microsoft"
#
# Then to change the language, change the Layout
setting.
# For example, a german layout can be obtained with:
#	Option	"XkbLayout"	"de"
# or:
#	Option	"XkbLayout"	"de"
#	Option	"XkbVariant"	"nodeadkeys"
#
# If you'd like to switch the positions of your
capslock and
# control keys, use:
#	Option	"XkbOptions"	"ctrl:swapcaps"
# Or if you just want both to be control, use:
#	Option	"XkbOptions"	"ctrl:nocaps"
#
	Identifier  "Keyboard0"
	Driver      "keyboard"
	Option	    "XkbRules" "xfree86"
	Option	    "XkbModel" "pc105"
	Option	    "XkbLayout" "us"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "Microsoft"
	Option	    "Device" "/dev/ttyS1"
	Option	    "ZAxisMapping" "4 5"
	Option	    "Emulate3Buttons" "yes"
EndSection

Section "InputDevice"

# If the normal CorePointer mouse is not a USB mouse
then
# this input device can be used in AlwaysCore mode to
let you
# also use USB mice at the same time.
	Identifier  "DevInputMice"
	Driver      "mouse"
	Option	    "Protocol" "IMPS/2"
	Option	    "Device" "/dev/input/mice"
	Option	    "ZAxisMapping" "4 5"
	Option	    "Emulate3Buttons" "no"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "StudioWorks"
	DisplaySize  270	200
	HorizSync    30.0 - 54.0
	VertRefresh  50.0 - 120.0
	Option	    "dpms"
EndSection

Section "Device"
	Identifier  "Videocard0"
	Driver      "ati"
	VendorName  "Videocard vendor"
	BoardName   "ATI Mach64 3D Rage IIC"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Videocard0"
	Monitor    "Monitor0"
	DefaultDepth     16
	SubSection "Display"
		Depth     16
		Modes    "800x600" "640x480"
	EndSubSection
EndSection

Section "DRI"
	Group        0
	Mode         0666
EndSection




________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
