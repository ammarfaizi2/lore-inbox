Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317455AbSFRPpX>; Tue, 18 Jun 2002 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317456AbSFRPpW>; Tue, 18 Jun 2002 11:45:22 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:54480 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317455AbSFRPpW>; Tue, 18 Jun 2002 11:45:22 -0400
Date: Tue, 18 Jun 2002 17:17:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
Cc: "'Raphael Manfredi'" <Raphael_Manfredi@pobox.com>,
       "'Helge Hafting'" <helgehaf@aitel.hist.no>,
       <linux-kernel@vger.kernel.org>
Subject: RE: The buggy APIC of the Abit BP6
In-Reply-To: <004001c216dd$1d24f520$020da8c0@nitemare>
Message-ID: <Pine.LNX.4.44.0206181713380.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Robbert Kouprie wrote:

> Raphael Manfredi wrote:
> 
> I just triggered the bug using a couple of simultaneous "ping -f -s 10
> host" commands, and the patched kernel indeed recovers from the bug with
> a "kernel: Kicking IO-APIC IRQ 17:" message :)
> Now if only we could call the recovery mechanism from the point where
> the "unexpected IRQ trap at vector" message gets printed (in
> arch/i386/kernel/irq.c:ack_none), then we would have a lot more generic
> code for all kinds of devices. If we then surround it by an #ifdef
> CONFIG_BROKEN_APIC like Helge suggested, there's more chance this patch
> gets accepted.
> 
> Problem now is, in the ack_none function we only know about the
> (illegal) vector we are getting, and not about the interrupt we need to
> reset. Could there be some kind of link between these, so that
> kick_IO_APIC_irq can be called from there?

Interesting, i haven't come across this problem before but it sounds like 
the vector isn't getting delivered when the interrupt gets asserted and 
only gets triggered later followed by an EOI... or something. Then again 
its probably been beaten around a couple of times by now so i probably am 
not adding anything new.

arch/i386/kernel/io_apic.c:irq_vector seems to be what you're looking for.

Good luck,
	Zwane Mwaikambo

 -- 
http://function.linuxpower.ca
		

