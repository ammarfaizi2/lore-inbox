Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbUC3PMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbUC3PMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:12:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5903 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263707AbUC3PMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:12:45 -0500
Date: Tue, 30 Mar 2004 17:09:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <len.brown@intel.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040330150949.GA22073@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local> <Pine.LNX.4.53.0403300943520.6151@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403300943520.6151@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > OK, so why not compile the cmpxchg instruction even on i386 targets
> > to let generic kernels stay compatible with everything, but disable
> > ACPI at boot if the processor does not feature cmpxchg ? This could
> > be helpful for boot/install kernels which try to support a wide
> > range of platforms, and may need ACPI to correctly enable interrupts
> > on others.
> >
> > Cheers,
> > Willy
> >
> 
> Because it would get used (by the compiler) in other code as well!
> As soon as the 386 sees it, you get an "invalid instruction trap"
> and you are dead.

That's not what I meant. I only meant to declare the cmpxchg() function.
Nobody uses it in 386 code right now, otherwise this code would not compile
on 386 (like ACPI now). So the function would not be used by anything else
but ACPI (at the moment). Then, drivers (such as ACPI) who know they will
need cmpxchg() would be responsible for testing the flag upon initialisation
and refuse to complete initialization if the instruction is not available.

> It might be a good idea to declare that after version xxx,
> '386 compatibility is no longer provided. There is plenty of
> usability for '386s in 2.4.nn, for instance.

I don't like the idea of dropping 386 compatibility in the stable
series. For instance, my home firewall still was a miniature 386sx
a few months ago, so there may be other people in similar situation.
Making CONFIG_ACPI depend on CONFIG_CMPXCHG would be less of a hassle
in this case, because it would imply that people either compile for
486+ with ACPI or for 386+ without ACPI.

Cheers,
Willy

