Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTDTSnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTDTSnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:43:05 -0400
Received: from zork.zork.net ([66.92.188.166]:60139 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263673AbTDTSnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:43:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: irq balancing; kernel vs. userspace
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: PRURIENT SUBTEXT, ADULT
 LANGUAGE/SITUATIONS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 20 Apr 2003 19:55:03 +0100
In-Reply-To: <1050863476.1412.11.camel@laptop.fenrus.com> (Arjan van de
 Ven's message of "20 Apr 2003 20:31:16 +0200")
Message-ID: <6ur87xkni0.fsf@zork.zork.net>
User-Agent: Gnus/5.090019 (Oort Gnus v0.19) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
	<6uwuhpl2u5.fsf@zork.zork.net>
	<1050863476.1412.11.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Sun, 2003-04-20 at 15:23, Sean Neakums wrote:
>> I thought I'd play with the userspace IRQ-balancer, but booting with
>> noirqbalance seems not to not balance.  Possibly I misunderstand how
>> this all fits together.
>
> this looks like you haven't started the userspace daemon (yet)

I just cranked it up, and now I see:

$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    9627420   12189635    IO-APIC-edge  timer
  1:       4165       4347    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:     282749     315988    IO-APIC-edge  serial
  8:          2          1    IO-APIC-edge  rtc
  9:          3          2   IO-APIC-level  eth1
 10:      19270      20109   IO-APIC-level  via82cxxx, eth0
 11:      34913      19457   IO-APIC-level  aic7xxx
 12:       8777       8835    IO-APIC-edge  i8042
NMI:          0          0 
LOC:   21817495   21817494 
ERR:          0
MIS:          0


I was confused at first because I was thinking of IRQ balancing as
balancing IRQs *across* CPUs.  This kind of balancing seems to be
about spreading IRQ *sources* across CPUs.  I guess it's good for
caches and whatnot for IRQs to be consistently serviced by the same
CPU.

Anyway, it seems to be working.  Thanks!

-- 
Sean Neakums - <sneakums@zork.net>
