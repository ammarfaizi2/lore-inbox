Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUAWMEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 07:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUAWMEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 07:04:54 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:28802 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263088AbUAWMEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 07:04:53 -0500
Date: Fri, 23 Jan 2004 13:04:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tomas Kouba <tomas@jikos.cz>, linux-kernel@vger.kernel.org
Subject: Re: Siemens MC45 PCMCIA gprs modem
Message-ID: <20040123120459.GA3323@ucw.cz>
References: <Pine.LNX.4.58.0401230922110.20053@twin.jikos.cz> <20040123112329.A12867@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123112329.A12867@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:23:29AM +0000, Russell King wrote:

> On Fri, Jan 23, 2004 at 09:32:41AM +0100, Tomas Kouba wrote:
> > /var/log/messages when I insert the card:
> > Jan 23 09:20:25 dhcp23 kernel: PCMCIA: socket c62dc82c: unable to apply 
> > power.
> 
> This is first thing to wonder about - this indicates that the PCMCIA
> bridge did not report that it had turned on the power to the socket
> after the time allowed.
> 
> Could you give some info on the PCMCIA hardware in this machine please?
> 
> > Jan 23 09:20:26 dhcp23 cardmgr[782]: + insmod /lib/modules/2.6.1/kernel/drivers/serial/serial_cs.ko
> > Jan 23 09:20:26 dhcp23 kernel: ttyS0 at I/O 0x3f8 (irq = 3) is a 8250
> > Jan 23 09:20:26 dhcp23 kernel: ttyS4 at I/O 0x400 (irq = 3) is a 16C950/954
> > Jan 23 09:20:26 dhcp23 cardmgr[782]: executing: './serial start ttyS0'
> > Jan 23 09:20:26 dhcp23 kernel: serial8250: too much work for irq3
> > Jan 23 09:20:27 dhcp23 last message repeated 5 times
> > Jan 23 09:20:27 dhcp23 cardmgr[782]: executing: './serial start ttyS4'
> 
> Hmm, it seems that we found two ports on this card, one at 0x3f8 and one
> at 0x400.  It also seems that there's something odd going on with IRQ3
> here, which could be the cause of your problem.

The same is happening for me with an Option GlobeTrotter GPRS card. For
some reason the PCMCIA utils read the CIS from the card and get
confused, registering two ports instead of one. dump_cis, editing the
CIS to remove the entry that confuses cardmgr, and then compiling the
CIS again helps.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
