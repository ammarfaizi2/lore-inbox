Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTLEI6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 03:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLEI6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 03:58:37 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:6097 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263298AbTLEI6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 03:58:36 -0500
Date: Fri, 5 Dec 2003 00:58:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205085829.GL29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16336.13962.285442.228795@alkaid.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 08:40:58AM +0100, Mikael Pettersson wrote:
> Jesse Allen writes:
>  > Hi,
>  > 
>  > I have a NForce2 board and can easily reproduce a lockup with grep on an IDE 
>  > hard disk at UDMA 100.  The lockup occurs when both Local APIC + IO-APIC are 
>  > enabled.  It was suggested to me to use NMI watchdog to catch it.  However, the 
>  > NMI watchdog doesn't seem to work.
>  > 
>  > When I set the kernel parameter "nmi_watchdog=1" I get this message in 
>  > /var/log/syslog:
>  > Dec  4 20:10:30 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
>  > IO-APIC
>  > Dec  4 20:10:30 tesore kernel: timer doesn't work through the IO-APIC - 
>  > disabling NMI Watchdog!
>  > 
>  > "nmi_watchdog=2" seems to work at first, In /var/log/messages:
>  > Dec  4 20:13:11 tesore kernel: testing NMI watchdog ... OK.
>  > but it still locks up.
> 
> The NMI watchdog can only handle software lockups, since it relies on
> the CPU, and for nmi_watchdog=1 the I/O-APIC + bus, still running.
> Hardware lockups result in, well, hardware lockups :-(

But nmi_watchdog=1 is supposed to work with APIC, or IO-APIC, and it isn't
for his motherboard.  It doesn't increment NMI in /proc/interrupts.  And it
gives the above error message.  Isn't that a bug?
