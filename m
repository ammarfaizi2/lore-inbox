Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbTG0FvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270678AbTG0FvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:51:11 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4288 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270677AbTG0FvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:51:10 -0400
Date: Sun, 27 Jul 2003 02:06:21 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Chris Heath <chris@heathens.co.nz>
Cc: aebr@win.tue.nl, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030727020621.A11637@devserv.devel.redhat.com>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030726212513.A0BD.CHRIS@heathens.co.nz>; from chris@heathens.co.nz on Sat, Jul 26, 2003 at 09:41:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sat, 26 Jul 2003 21:41:32 -0400
> From: Chris Heath <chris@heathens.co.nz>

> > > drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [40] 
> > > drivers/input/serio/i8042.c: 60 -> i8042 (command) [50] 
> > > drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [50] 
> > > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [51] 
> > > serio: i8042 KBD port at 0x60,0x64 irq 1 
> > > <------------- This is it, keyboard is dead. 
> > 
> > Writing 44 to the command byte disables IRQ1. 
> 
> It looks like a timeout problem.  The ack (fa) arrived 11 ticks after
> the byte (00) was sent, but it looks like the timeout is only 10 ticks.
> 
> Try playing with the timeout in atkbd_sendbyte (line 217 of
> drivers/input/keyboard/atkbd.c).

Playing with timeout does not help, but on second thought
I suspect that atkbd fails to open the port for some reason,
that's why interrupts stay disabled.

-- Pete
