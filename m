Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272420AbTGZJVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272433AbTGZJVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 05:21:12 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46604 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272420AbTGZJVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 05:21:09 -0400
Date: Sat, 26 Jul 2003 11:36:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030726093619.GA973@win.tue.nl>
References: <20030726021136.A19309@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726021136.A19309@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 02:11:36AM -0400, Pete Zaitcev wrote:

> On my old laptop, i8042 refuses to work with 2.6.0-test1-bk2.
> After a reboot, keyboard is dead. Hooking external keyboard
> revives the internal keyboard. Here's the dmesg with DEBUG:
> 
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [50]
> drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [50]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [51]
> serio: i8042 KBD port at 0x60,0x64 irq 1
>  <------------- This is it, keyboard is dead.

Writing 44 to the command byte disables IRQ1.
(Otherwise the only remarkable part was that no reaction came to
f2 - identify keyboard.)

>  V---- Trying to hook external keyboard now
> drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [109846]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109852]
> drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [109873]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [109879]
> drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109900]
> drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109921]
> atkbd.c: Unknown key (set 0, scancode 0x2, on isa0060/serio0) pressed.
> input: AT Set 2 keyboard on isa0060/serio0
>  <----- Now we are talking!

Funny. Looks like the "read scancode set" command got the scancode set
twice, and the second time was seen as unknown key.

