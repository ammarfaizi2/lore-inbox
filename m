Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTIWAQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTIWAPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:15:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1223 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263068AbTIWAOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:14:48 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030922190054.GC27209@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	 <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	 <20030922162602.GB27209@mail.jlokier.co.uk>
	 <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
	 <20030922190054.GC27209@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064275992.9832.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 23 Sep 2003 01:13:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 20:00, Jamie Lokier wrote:
> > CS5520 is one example. Also VIA VP2 seems to care but only very very
> > occasionally. On my 386 board its reliably borked without the delays
> > (not sure what chipset and its ISA so harder to tell)
> 
> Yeah, but what's the problem and can it be detected? :)

You get bogus results

> I'm wondering if there's a way to detect how much udelay is needed on
> a particular board, and reduce or remove it on boards where it isn't
> needed.

8 ISA cycles will be nice and safe - see the specification for the ISA
bus. Its a nice easy known value and the way we moved various drivers to
udelay that used isa delay cycles for timing loops

> udelay() is also unreliable nowadays, due to CPUs changing clock
> speeds according to the whims of the BIOS.  On laptops, even the rdtsc
> rate varies.  If the delay is critical to system reliability for
> unknown reasons, then switching to udelay() removes some of that "we
> always did this and it fixed the unknown problems" legacy driver safety

Delaying too long is ok, delaying too little isnt good but as you say
most modern hw seems not to care.


