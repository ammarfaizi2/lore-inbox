Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbUC3OrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbUC3OrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:47:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23939 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263689AbUC3OrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:47:00 -0500
Date: Tue, 30 Mar 2004 09:48:14 -0500 (EST)
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
In-Reply-To: <20040330142215.GA21931@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0403300943520.6151@chaos>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
 <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local>
 <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
 <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Willy Tarreau wrote:

> On Tue, Mar 30, 2004 at 08:15:46AM -0500, Richard B. Johnson wrote:
> > On Tue, 30 Mar 2004, Alan Cox wrote:
> >
> > > On Llu, 2004-03-29 at 23:07, Len Brown wrote:
> > > > Linux uses this locking mechanism to coordinate shared access
> > > > to hardware registers with embedded controllers,
> > > > which is true also on uniprocessors too.
> > >
> > > If the ACPI layer simply refuses to run on a CPU without cmpxchg
> > > then I can't see there being a problem, there don't appear to be
> > > any 386 processors with ACPI
> > >
> >
> > Yep, but to get to use cmpxchg, you need to compile as a '486 or
> > higher. This breaks i386.
>
> OK, so why not compile the cmpxchg instruction even on i386 targets
> to let generic kernels stay compatible with everything, but disable
> ACPI at boot if the processor does not feature cmpxchg ? This could
> be helpful for boot/install kernels which try to support a wide
> range of platforms, and may need ACPI to correctly enable interrupts
> on others.
>
> Cheers,
> Willy
>

Because it would get used (by the compiler) in other code as well!
As soon as the 386 sees it, you get an "invalid instruction trap"
and you are dead.

It might be a good idea to declare that after version xxx,
'386 compatibility is no longer provided. There is plenty of
usability for '386s in 2.4.nn, for instance.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


