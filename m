Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280917AbRKLSsD>; Mon, 12 Nov 2001 13:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280921AbRKLSrx>; Mon, 12 Nov 2001 13:47:53 -0500
Received: from cc797718-a.jrsycty1.nj.home.com ([24.253.208.156]:55051 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S280917AbRKLSrr>;
	Mon, 12 Nov 2001 13:47:47 -0500
Date: Mon, 12 Nov 2001 13:44:53 -0500
Message-Id: <200111121844.fACIirV23633@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <20011101193437.B924@torres.ka0.zugschlus.de>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.14 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Sorry for the late reply, I've been on vacation for the last week..

On Thu, 1 Nov 2001 19:34:37 +0100, Marc Haber <mh+linux-kernel@zugschlus.de> wrote:
> On Thu, Nov 01, 2001 at 10:47:03AM -0500, Ion Badulescu wrote:
>> What does mii-tool report?
> 
> This is what mii-tool reports while the link is still up:
> |Basic registers of MII PHY #0:  1000 782d 0040 6331 00a1 45e1 0005 2001.
> | The autonegotiated capability is 00a0.
> |The autonegotiated media type is 100baseTx.
> | Basic mode control register 0x1000: Auto-negotiation enabled.
> | You have link beat, and everything is working OK.
> | Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
> |   End of basic transceiver informaion.

All right, so far so good.

> Invoking mii-diag after provoking the network freeze freezes the
> entire machine. Not even magic sqsrq works in that situation.

This, however, is not good. Not good at all. If sysrq is not working, that 
means the interrupts are disabled or the bus is completely wedged. The 
driver never disables interrupts, and the ioctl() function is not called 
with the interrupts disabled, so that's not a possible cause. Furthermore, 
the ioctl() function does something very mundane (reading a few 
registers), which definitely shouldn't cause lock ups.

I'm sorry, I don't have any good news for you... I really don't think the 
problem is in the driver.

Just for the kicks, can you strace mii-diag when it locks up, to see on 
which ioctl() call it locks up? I don't think that will help much, but...

> Sometimes, I get a "spurious 8259A interrupt: IRQ7" or " spurious
> 8259A interrupt: IRQ15" message on console and syslog, though.

I get the IRQ7 one as well, it's not something to be overly concerned 
with.

> I cannot rule out that my notebook is broken, Chicony has a history of
> making abysmally bad hardware, and the machine is about two years old.

Could very well be broken, unfortunately.

> I don't have a reference notebook that has Linux installed and can do
> Cardbus to cross-check, sorry.

Do you have any other cardbus cards to test if they work with this laptop?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
