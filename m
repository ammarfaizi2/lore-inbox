Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDNBqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDNBqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:46:20 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:23516 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263366AbUDNBqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:46:15 -0400
To: dl8bcu@dl8bcu.de
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net,
       spyro@f2s.com, rmk@arm.linux.org.uk, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
	<20040412075704.B5198@Marvin.DL8BCU.ampr.org>
	<16506.50767.128817.828166@napali.hpl.hp.com>
	<20040412200835.A5625@Marvin.DL8BCU.ampr.org>
	<16506.64729.917048.491827@napali.hpl.hp.com>
	<20040412211754.A5770@Marvin.DL8BCU.ampr.org>
	<buofzb8o75c.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20040413170027.A6693@Marvin.DL8BCU.ampr.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 14 Apr 2004 10:45:25 +0900
In-Reply-To: <20040413170027.A6693@Marvin.DL8BCU.ampr.org>
Message-ID: <buozn9fxrgq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Kranzkowski <dl8bcu@dl8bcu.de> writes:
> 	config INPUT_PCSPKR
> 		tristate "PC Speaker support"
> 		depends on INPUT && INPUT_MISC
> 
> I'm by no means a Kconfig expert, but I read this as there's nothing 
> that prevents you to select INPUT_PCSPKR on every architecture.

Indeed, but the code (pcspkr.c) looks completely non-portable, e.g.:

   outb_p(inb_p(0x61) | 3, 0x61);

[no comment]

So I'd guess that the Kconfig file should have more dependencies added;
what they are I have no idea.  [I guess it has something to do with old
ISA-bus-compatibility stuff.]

> > anywhere, and don't even know what an 8253 is... [so it would be damn
> > silly to have <asm/8253pit.h> as a required header!]
> 
> Ok, I won't create one, then. (just to be shure: asm-v850, right?) 

Yeah, v850.  I'd think you shouldn't do it for any arch except those
you know actually support this stuff.

-Miles
-- 
"Unless there are slaves to do the ugly, horrible, uninteresting work, culture
and contemplation become almost impossible. Human slavery is wrong, insecure,
and demoralizing.  On mechanical slavery, on the slavery of the machine, the
future of the world depends." -Oscar Wilde, "The Soul of Man Under Socialism"
