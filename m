Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbTHDHUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271411AbTHDHUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:20:51 -0400
Received: from [195.206.1.27] ([195.206.1.27]:28428 "EHLO spidernet.it")
	by vger.kernel.org with ESMTP id S271410AbTHDHUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:20:41 -0400
Date: Sun, 3 Aug 2003 00:37:40 +0200
From: adri <adriano.archetti@tiscali.it>
To: linux-kernel@vger.kernel.org
Cc: adri <adriano.archetti@tiscali.it>, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030802223740.GA655@inwind.it>
Mail-Followup-To: adri <adriano.archetti@tiscali.it>,
	linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>
References: <20030728214523.GA485@inwind.it> <20030729142025.GA2180@win.tue.nl> <20030730072708.GA893@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730072708.GA893@inwind.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

il giorno Wed, Jul 30, 2003 at 09:27:08AM +0200, adri ha scritto
> il giorno Tue, Jul 29, 2003 at 04:20:25PM +0200, Andries Brouwer ha scritto
> > Could you compile i8042.c with #define DEBUG instead of #undef DEBUG
> > and report what that yields in the syslog?
well, i investigate into my problem, building kernel with debug, and i
noticed some strange...
when the system boot up it load mouse without problem:

drivers/input/serio/i8042.c: d4 -> i8042 (command) [562]
drivers/input/serio/i8042.c: 14 -> i8042 (parameter) [562]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [564]
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1

then it start to search for the aux port, with success:

drivers/input/serio/i8042.c: d4 -> i8042 (command) [584]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [584]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [586]
serio: i8042 AUX port at 0x60,0x64 irq 12

and for the last it find the keyboard:

drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [629]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [631]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [640]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

but here the problem is the same: when i press a key it seems that i
press this keys for almost 4 time (eg. i press "a", and it give me
"aaaa")
when i try to stop my system, i pressed alt+sysrq, +s, for sync, +u for
mounting read only, and i mistake and pressed alt+sysrq+i, so i killed
every task.
well, i noticed here, with debug still on, that when i pressed a key, it
received only one pressure:
drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, kbd, 1) [168545]
but it write to standard output for characters.
i think the problem is just here, then, someone wants to help me to fix
this?

thanks
adri

ah, just for knowledge, my keyboard is the standard keyboard with laptop
hp pavilion ze4200...
-- 
icq# 63011800 - jabber: adri@jabber.org
gnupg key id: 4472FB13
"Non esiste vento favorevole per il marinaio che non sa dove andare."
Seneca
