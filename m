Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLEOTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTLEOTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:19:42 -0500
Received: from legolas.restena.lu ([158.64.1.34]:22976 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264147AbTLEOTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:19:37 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Josh McKinney <forming@charter.net>, linux-kernel@vger.kernel.org
In-Reply-To: <16336.30392.344028.347132@alkaid.it.uu.se>
References: <20031205045404.GA307@tesore.local>
	 <16336.13962.285442.228795@alkaid.it.uu.se>
	 <20031205083349.GA15152@forming>
	 <16336.30392.344028.347132@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1070633973.4100.23.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Dec 2003 15:19:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting those in dmesg too...

..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.


Do you really think this could be the problem?

If so, any ideas why I am relatively lucky to not have the crashes
people are having? 5.5 days, then 5 hours, and now Im up to 17 hours...
with a decent amount of use combined with idle time.

Craig


On Fri, 2003-12-05 at 13:14, Mikael Pettersson wrote:
> Josh McKinney writes:
>  > On approximately Fri, Dec 05, 2003 at 08:40:58AM +0100, Mikael Pettersson wrote:
>  > > Jesse Allen writes:
>  > >  > Hi,
>  > >  > 
>  > >  > I have a NForce2 board and can easily reproduce a lockup with grep on an IDE 
>  > >  > hard disk at UDMA 100.  The lockup occurs when both Local APIC + IO-APIC are 
>  > >  > enabled.  It was suggested to me to use NMI watchdog to catch it.  However, the 
>  > >  > NMI watchdog doesn't seem to work.
>  > >  > 
>  > >  > When I set the kernel parameter "nmi_watchdog=1" I get this message in 
>  > >  > /var/log/syslog:
>  > >  > Dec  4 20:10:30 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
>  > >  > IO-APIC
>  > >  > Dec  4 20:10:30 tesore kernel: timer doesn't work through the IO-APIC - 
>  > >  > disabling NMI Watchdog!
>  > >  > 
>  > >  > "nmi_watchdog=2" seems to work at first, In /var/log/messages:
>  > >  > Dec  4 20:13:11 tesore kernel: testing NMI watchdog ... OK.
>  > >  > but it still locks up.
>  > > 
>  > > The NMI watchdog can only handle software lockups, since it relies on
>  > > the CPU, and for nmi_watchdog=1 the I/O-APIC + bus, still running.
>  > > Hardware lockups result in, well, hardware lockups :-(
>  > 
>  > So does this confirm that the lockups with nforce2 chipsets and apic
>  > is actually a hardware problem after all? 
> 
> Confirm with very high probability. There may be quirks in nVidia's
> chipset that we (unlike their Windoze drivers) don't know about.
> 
> Ask nVidia for detailed chipset documentation. Then maybe we can fix this.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

