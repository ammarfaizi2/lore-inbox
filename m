Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbUC3PfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbUC3PfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:35:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34435 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263721AbUC3PcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:32:17 -0500
Date: Tue, 30 Mar 2004 10:33:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <len.brown@intel.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <20040330150949.GA22073@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0403301019570.6451@chaos>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
 <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local>
 <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
 <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local>
 <Pine.LNX.4.53.0403300943520.6151@chaos> <20040330150949.GA22073@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Willy Tarreau wrote:

>
> > > OK, so why not compile the cmpxchg instruction even on i386 targets
> > > to let generic kernels stay compatible with everything, but disable
> > > ACPI at boot if the processor does not feature cmpxchg ? This could
> > > be helpful for boot/install kernels which try to support a wide
> > > range of platforms, and may need ACPI to correctly enable interrupts
> > > on others.
> > >
> > > Cheers,
> > > Willy
> > >
> >
> > Because it would get used (by the compiler) in other code as well!
> > As soon as the 386 sees it, you get an "invalid instruction trap"
> > and you are dead.
>
> That's not what I meant. I only meant to declare the cmpxchg() function.

It's not a function. It is actual op-codes. If you compile with
'486 or higher, the C compiler is free to spew out these op-codes
any time it thinks it's a viable instruction sequence. Since
it basically replaces two other op-codes, gcc might certainly use
if for optimization.

This is independent of the macro that is defined in a header to
use this sequence .


[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


