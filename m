Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVIASI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVIASI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVIASI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:08:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030274AbVIASI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:08:57 -0400
Date: Thu, 1 Sep 2005 11:09:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Message-ID: <20050901110913.5d9fba44@dxpl.pdx.osdl.net>
In-Reply-To: <431448F7.2020506@gentoo.org>
References: <20050830105210.11849.qmail@web53602.mail.yahoo.com>
	<431448F7.2020506@gentoo.org>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005 12:54:31 +0100
Daniel Drake <dsd@gentoo.org> wrote:

> Hi Stephen,
> 
> This looks like an issue I reported previously. After you use a recent skge, 
> you can't use any older drivers or the windows driver, but skge still works 
> fine every time.
> 
> 	http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2
> 
> The Gentoo bug report is here:
> 
> 	http://bugs.gentoo.org/show_bug.cgi?id=100258
> 
> I closed the Gentoo bug as I hoped this patch would solve it:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=0eedf4ac5b536c7922263adf1b1d991d2e2397b9;hp=acdd80d514a08800380c9f92b1bf4d4c9e818125
> 
> But according to Steve Kieu, the problem is still there in 2.6.13. It's 
> slightly odd as Steve was previously a sk98lin user and initially reported 
> this problem for sk98lin in 2.6.13 whereas it did not happen with sk98lin in 
> 2.6.12.
> 
> Any ideas?
> 
> Thanks.
> 
> Steve Kieu wrote:
> > Tested , not broken, working now but the same problem,
> > that is if I reboot to winXP or 2.6.12, 2.6.11, the
> > NIC is unusaeble. In XP it always says link is down,
> > or media disconnected (from ipconfig command output in
> > XP)
> > is it because the firmware of NIC has changed or any
> > reason?
> > 
> > 
> > I noticed  warning messages only with 2.6.13 
> > 
> > PCI: Failed to allocate mem resource #10:2000000@0 for
> > 0000:02:01.0
> > 
> > and modem device in 2.6.13 IRQ is disabled.

This is a different problem related to ACPI and other bus
changes in 2.6.13.


> > ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 20
> > ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LKMO] ->
> > GSI 20 (level, low) -> IRQ
> >  17
> > ACPI: PCI interrupt for device 0000:00:06.1 disabled
> > 
> > not sure if it gives more information.
> > 
> > skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9
> > skge eth0: addr 00:11:d8:f2:1f:18
> > ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] ->
> > GSI 18 (level, low) -> IRQ
> >  16
> > Yenta: CardBus bridge found at 0000:02:01.0
> > [1043:1987]
> > skge eth0: enabling interface
> > 
> > skge eth0: Link is up at 10 Mbps, half duplex, flow
> > control none
> > 
> > Not sure how can I restore this thing back to normal
> > (sigh)


Is this the correct summary of the problem scenarios.
Assume each one starts from cold boot (power off).

* 2.6.13(skge) boot                    => Good
* 2.6.13(sk98lin) boot                 => Good
* 2.6.13 + SK version of sk98lin       => Good
* XP boot                              => Good

Okay, now the cases where one OS is run first and
a reboot is done to a second, or in the case of
just Linux, this should be the same as rmmoding on
driver and modprobing

	Second
First   | skge | sk98lin | XP
skge  	| OK   |  BAD    | BAD
sk98lin | ok   |  OK     | ok 
XP      | ok   |  ok     | OK


