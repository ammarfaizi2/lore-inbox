Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbTG0B0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270645AbTG0B0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 21:26:14 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27841 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270643AbTG0B0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 21:26:13 -0400
Date: Sat, 26 Jul 2003 21:41:32 -0400
From: Chris Heath <chris@heathens.co.nz>
To: aebr@win.tue.nl
Subject: Re: i8042 problem
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030726093619.GA973@win.tue.nl>
Message-Id: <20030726212513.A0BD.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [40] 
> > drivers/input/serio/i8042.c: 60 -> i8042 (command) [50] 
> > drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [50] 
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [51] 
> > serio: i8042 KBD port at 0x60,0x64 irq 1 
> > <------------- This is it, keyboard is dead. 
> 
> 
> Writing 44 to the command byte disables IRQ1. 

It looks like a timeout problem.  The ack (fa) arrived 11 ticks after
the byte (00) was sent, but it looks like the timeout is only 10 ticks.

Try playing with the timeout in atkbd_sendbyte (line 217 of
drivers/input/keyboard/atkbd.c).


> > drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109900] 
> > drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [109921] 
> > atkbd.c: Unknown key (set 0, scancode 0x2, on isa0060/serio0) pressed. 
> > input: AT Set 2 keyboard on isa0060/serio0 
> > <----- Now we are talking! 
> 
> 
> Funny. Looks like the "read scancode set" command got the scancode set 
> twice, and the second time was seen as unknown key. 

Both keyboards responded to the command, perhaps???

I'd suggest that we don't even ask the keyboard what scancode set it is
using if we are attempting to use set 2.

Chris

