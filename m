Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293155AbSBWQjf>; Sat, 23 Feb 2002 11:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293156AbSBWQj0>; Sat, 23 Feb 2002 11:39:26 -0500
Received: from ns.ithnet.com ([217.64.64.10]:4102 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293155AbSBWQjV>;
	Sat, 23 Feb 2002 11:39:21 -0500
Date: Sat, 23 Feb 2002 17:38:57 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: fernando@quatro.com.br, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-Id: <20020223173857.3db89749.skraw@ithnet.com>
In-Reply-To: <20020222182024.GG13774@os.inf.tu-dresden.de>
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de>
	<051a01c1bb01$70634580$c50016ac@spps.com.br>
	<20020221211142.0cf0efa4.skraw@ithnet.com>
	<20020222130246.GD13774@os.inf.tu-dresden.de>
	<20020222141101.0cc342e1.skraw@ithnet.com>
	<20020222182024.GG13774@os.inf.tu-dresden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 19:20:24 +0100
Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:

> On Fri Feb 22, 2002 at 18:04:29 +0100, Stephan von Krawczynski wrote:
> > Your config is not identical to the one I sent. If you want to find
> > out what the problem is, you must first try to produce a setup that is
> > known good. So simply use my config, even if it contains stuff you
> > don't need, and especially if it does not contain stuff you want.
> > Your primary goal is: let the box boot.
> 
> Yours (+serial console) doesn't work either, so I stripped out most
> unneeded things. I'm going to rip out all cards except net and graphics
> to see if that helps but that has to wait till Monday...
> 
> BTW: I just got this:
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> .... CPU clock speed is 937.5536 MHz.
> ..... host bus clock speed is 133.9358 MHz.
> cpu: 0, clocks: 1339358, slice: 446452
> CPU0<T0:1339344,T1:892880,D:12,S:446452,C:1339358>
> cpu: 1, clocks: 1339358, slice: 446452
> CPU1<T0:1339344,T1:446432,D:8,S:446452,C:1339358>
> checking TSC synchronization across CPUs: 
> BIOS BUG: CPU#0 improperly initialized, has -6 usecs TSC skew! FIXED.
> BIOS BUG: CPU#1 improperly initialized, has 6 usecs TSC skew! FIXED.
> Waiting on wait_init_idle (map = 0x
> 
> 
> Maybe this means something...

Aha, here is my output on 2 x 1 GHz:

<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1004.5421 MHz.
<4>..... host bus clock speed is 133.9388 MHz.
<4>cpu: 0, clocks: 1339388, slice: 446462
<4>CPU0<T0:1339376,T1:892912,D:2,S:446462,C:1339388>
<4>cpu: 1, clocks: 1339388, slice: 446462
<4>CPU1<T0:1339376,T1:446448,D:4,S:446462,C:1339388>
<4>checking TSC synchronization across CPUs: passed.
<4>Waiting on wait_init_idle (map = 0x2)
<4>All processors have done init_idle

And the same part for 2 x 933 MHz:

<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 937.5672 MHz.
<4>..... host bus clock speed is 133.9380 MHz.
<4>cpu: 0, clocks: 1339380, slice: 446460
<4>CPU0<T0:1339376,T1:892912,D:4,S:446460,C:1339380>
<4>cpu: 1, clocks: 1339380, slice: 446460
<4>CPU1<T0:1339376,T1:446448,D:8,S:446460,C:1339380>
<4>checking TSC synchronization across CPUs: passed.
<4>Waiting on wait_init_idle (map = 0x2)
<4>All processors have done init_idle

I would say this means the TSC skew fix is broken and shooting down your box. What do you think, Alan?

Regards,
Stephan



