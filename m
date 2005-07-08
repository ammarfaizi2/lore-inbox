Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVGHROC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVGHROC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGHROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:14:02 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:35734 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262703AbVGHROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:14:00 -0400
Date: Fri, 8 Jul 2005 19:14:24 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050708171424.GC4191@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dtor@mail.ru>
References: <20050708125537.GA4191@inferi.kami.home> <20050708162908.715.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708162908.715.qmail@web81301.mail.yahoo.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 09:29:08AM -0700, Dmitry Torokhov wrote:
> Mattia Dongili <malattia@gmail.com> wrote:
[...]
> I see several possible issues:
> 
> > PNP: No PS/2 controller found. Probing ports directly.
> 
> Does it show this line when touchpad is being detected? 

yes

> Do you have PNPACPI turned on?

# CONFIG_PNPACPI is not set

> > i8042.c: Detected active multiplexing controller, rev 5.3.
> 
> Revision 5.3 is suspicious. The last posted one is 1.1
> Again, when touchpad is detected, does it show this or 1.{0|1}?

nothing at all, no multiplexing controller and most important only 2
ports

PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice

> > serio: i8042 AUX0 port at 0x60,0x64 irq 12
> > serio: i8042 AUX1 port at 0x60,0x64 irq 12
> > serio: i8042 AUX2 port at 0x60,0x64 irq 12
> > serio: i8042 AUX3 port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > mice: PS/2 mouse device common for all mice
> 
> And now the real problem:
> 
> > drivers/input/serio/i8042.c: 91 -> i8042 (command) [220803]
> > drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220803]
> > drivers/input/serio/i8042.c: fa <- i8042 (interrupt, KBD, 1) [220806]
> 
> We are trying to talk to AUX port but KBC replies as if data
> is coming from the keyboard port.
> 
> Does it help if you boot with "usb-handoff" kernel option? Another
> one would be "i8042.nomux". Btw, does your laptop have external
> PS/2 ports?

Well it's pretty hard to say currently I've only been able to trigger
this problem only twice in at least 6 cold boots.
Will try later anyway :)

As said, I remember having this problem in the past, here's the thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108211185919825&w=2
it seems we already talked about it!

-- 
mattia
:wq!
