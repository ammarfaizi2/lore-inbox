Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRGAAIO>; Sat, 30 Jun 2001 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbRGAAIE>; Sat, 30 Jun 2001 20:08:04 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:48132 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264860AbRGAAH4>;
	Sat, 30 Jun 2001 20:07:56 -0400
Message-ID: <20010701020758.B26841@win.tue.nl>
Date: Sun, 1 Jul 2001 02:07:58 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Joseph Carter <knghtbrd@d2dc.net>, Tim Jansen <tim@tjansen.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mac USB keyboards (Was: USB Keyboard errors with 2.4.5-ac)
In-Reply-To: <01063000110000.01057@cookie> <20010629214840.B14167@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010629214840.B14167@debian.org>; from Joseph Carter on Fri, Jun 29, 2001 at 09:48:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 09:48:40PM -0700, Joseph Carter wrote:

> If you're using it on a wintel arch machine, have you managed to get the
> numeric keypad's = key or the power key to work?  Doesn't here and I've
> tried more than one model of keyboard on more than one machine, no luck
> even with showkey.  MacOS likes the keys just fine, naturally.

I just borrowed a Mac keyboard and looked.
The Numpad = key gave scancode 5c, the power key gave e05e.
The command getkeycodes showed that the former was assigned to
keycode 127, while the latter was not assigned.
The command "setkeycodes e05e 25", where 25 is the keycode
for the letter p, made the power key produce the letter p.

You see that you can do with a USB keyboard what you can do
with an ordinary keyboard: use setkeycodes to assign a keycode
to scancode combinations that didnt have one yet, use loadkeys
to assign a function to a keycode.

To understand the details of the code, trace the steps:
(i)  The USB code can be found e.g. on
	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html
We find that Power is 102 and that Keypad-= is 103.
(ii) In usbkbd.c:usb_kbd_keycode[] these keycodes are converted
to 116 and 117, and then input_event is called.
(iii) In keybdev.c:x86_keycodes[] these codes are converted
to 350 and 92. The former is 256+94 and becomes e05e, the latter 5c.
This is fed further to the usual keyboard processing.

Andries
