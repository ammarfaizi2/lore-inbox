Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTGQT73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTGQT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:59:28 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:26588 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269736AbTGQT6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:58:41 -0400
Date: Thu, 17 Jul 2003 23:14:42 +0300
From: Faik Uygur <faikuygur@dsl.ttnet.net.tr>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bad autorepeat problems in 2.5.75
Message-ID: <20030717201442.GA18472@spider>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030714222249.GA11150@elf.ucw.cz> <20030715064755.GD27368@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
In-Reply-To: <20030715064755.GD27368@ucw.cz>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: D2 3C E7 1A 96 96 35 99 AD 33 AB B0 F9 E9 7E B1
X-PGP-Key-ID: 0x857B9912
X-PGP-Key-Size: 1024 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jul 15, 2003 at 12:22:51AM +0200, Pavel Machek wrote:
> 
> > Hi!
> > 
> > I have bad problems with autorepeat. When switching consoles with
> > alt-left / alt-right it sometimes skips wrong number of consoles, and
> > sometimes it just keeps repeating even through I already released a
> > key.
> > 
> > Syslog complains:
> > 
> > Jul 15 00:15:52 amd kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1cb, on isa0060/serio0) pressed.
> > Jul 15 00:16:21 amd kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1cb, on isa0060/serio0) pressed.
> > Jul 15 00:19:02 amd kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1cd, on isa0060/serio0) pressed.
> > Jul 15 00:20:04 amd kernel: atkbd.c: Unknown key (set 2, scancode
> > 0x1cd, on isa0060/serio0) pressed.
> > 
> > Its vesafb -> switching consoles is not exactly fast, maybe that has
> > some role?
> 
> Probably keyboard interrupts get lost. Bad. Can you track with DEBUG
> enabled in i8042.c?

Hi,

Related or same problem here. This is Toshiba 1410-902.

Here is some debug output:

drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, kbd, 1) [1154471]
drivers/input/serio/i8042.c: 24 <- i8042 (interrupt, kbd, 1) [1154532]
drivers/input/serio/i8042.c: a5 <- i8042 (interrupt, kbd, 1) [1154538]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1154664]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1154672]
atkbd.c: Unknown key (set 2, scancode 0xa4, on isa0060/serio0) pressed.
drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, kbd, 1) [1154683]
drivers/input/serio/i8042.c: 24 <- i8042 (interrupt, kbd, 1) [1154743]
drivers/input/serio/i8042.c: a5 <- i8042 (interrupt, kbd, 1) [1154769]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1154873]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1154881]
atkbd.c: Unknown key (set 2, scancode 0xa4, on isa0060/serio0) pressed.
drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, kbd, 1) [1154892]
drivers/input/serio/i8042.c: 24 <- i8042 (interrupt, kbd, 1) [1154971]
drivers/input/serio/i8042.c: a5 <- i8042 (interrupt, kbd, 1) [1154995]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1155099]
drivers/input/serio/i8042.c: a4 <- i8042 (interrupt, kbd, 1) [1155109]
atkbd.c: Unknown key (set 2, scancode 0xa4, on isa0060/serio0) pressed.
drivers/input/serio/i8042.c: 25 <- i8042 (interrupt, kbd, 1) [1155118]

	Faik
