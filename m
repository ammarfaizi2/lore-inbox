Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbSLKA7Q>; Tue, 10 Dec 2002 19:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSLKA7Q>; Tue, 10 Dec 2002 19:59:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:15846 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266929AbSLKA7O>;
	Tue, 10 Dec 2002 19:59:14 -0500
Date: Tue, 10 Dec 2002 17:05:12 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net
Subject: Status new-modules + 802.11b/IrDA
Message-ID: <20021211010512.GA5853@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	As I have a large quantity of IrDA and wireless patches that
need to get merged in 2.5.X, I thought that I would give a try to the
latest 2.5.51 and its new module support.
	This is a short list of problems that I've found with my
setup. They of course will need to be fixed before I can do useful
work on 2.5.X, but I can wait until things get more polished, because
I understand that Rusty has a todo list pretty full.
	Have fun, and sorry for the spam...

	Jean

--------------------------------------------------------------

Setup :
-----
	o kernel 2.5.51 ; SMP
	o module-init-tools-0.9.3
	o dual PPro 200 MHz, Debian 3.0

Debian Boot :
-----------
	o Din't pick up new modutils in the init scripts. Probably
because I used install option 1b in README (/usr/local/sbin).
	o Re-install with option 1a (/sbin), works fine.
	o Maybe this needs to be in README.

hp100 (my Ethernet card) :
------------------------
	o When loading, module options (various hp100_XXX) are
ignored, however they are necessary to get the card up and
running. So, no network :-(
	o Seems that the section handling "param" support in the
kernel is #if 0, so probably not finished up yet. I see that it's on
your TODO list.
	o No further tests.

Wavelan ISA :
-----------
	o Didn't try old wavelan ISA card because I know that it
requires module parameters as well.

Pcmcia and airo_cs :
------------------
	o Loads with error below, airo_cs driver is functional.
	o i82365 cannot be unloaded, it's unsafe.
	o removal of airo_cs : "Uninitialised timer!/nThis is a
warning. Your computer is OK". Call trace on demand. Also, the module
airo not removed (probably due to problem with airo_cs).
	o re-insertion of the card : nothing happens. No messages.
	o After reboot, /etc/init.d/pcmcia stop -> same thing + script
hang + a few [kmodule1? <defunct>]. This prevent the computer to
reboot or shutdown properly (== fsck at next boot).

	I never had those problem before, this driver has always been
rock solid, and I don't really know where to start... I don't use
auto_wep, so the only timer used in airo is &link->release, which is
Pcmcia stuff. This is where the lack of Pcmcia maintainer in 2.5.X
makes me really nervous.

Pcmcia and orinoco_cs :
---------------------
	o Same deal as airo_cs, fail removal of card. Actually, the
whole computer did lock-up.
	o Definitely looks like a generic Pcmcia problem (BTW, both
cards are 16 bits, as well as the bridge).

IrDA :
----
	o Try irtty and irda-usb drivers, both load fine, as well as
the Linux-IrDA stack, only with message below. Basic IrDA
communication test passed.
	o af_irda, irda-usb & irtty-sir are "unsafe". I tracked that
down to the use of MOD_INC_USE_COUNT. The header file module.h give
hints on how I should convert that to the new world (use
try_module_get), however your FAQ seems to say something else (just
remove them, they are useless). I'm quite confused, because those
MOD_INC_USE_COUNT have a definite purpose... I would appreciate more
guidance.
	o When/if I will understand what's the best course of action,
I can fix those myself.
	o Also, maybe you should put a pointer to your FAQ in the
usual places (like in the README of module-init-tools-0.9.3), because
it's only because I knew it existed that I've found it.
