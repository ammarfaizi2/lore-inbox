Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUCAMnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUCAMnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:43:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40159 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261245AbUCAMnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:43:33 -0500
Date: Thu, 26 Feb 2004 14:16:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ACPI power-off on P4 HT
Message-ID: <20040226131645.GA6029@openzaurus.ucw.cz>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local> <20040208090854.GE29363@alpha.home.local> <20040214081726.GH29363@alpha.home.local> <1076824106.25344.78.camel@dhcppc4> <20040225070019.GA30971@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225070019.GA30971@alpha.home.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> as I previously said, the patch I sent which fixes the poweroff on my VAIO is
> not enough to shut down the supermicro P4 HT. So I borrowed some code from
> machine_restart() to try to :
>   - disable APIC  => was not enough, but I must retry on the VAIO
>   - stop the second CPU => was not enough either
>   - bounce on boot_cpu and stop the others => it did work.
> 
> So I think that ACPI is not SMP-proof nor HT-proof on some hardware. My new
> problem is that I feel like the code I have included in acpi_power_off() to
> do this is a bit too much x86 specific, so I'd like to move this to
> arch/i386/kernel/process.c with all the rest, but I don't know how to cut
> this. I think that a general function such as machine_prepare_shutdown() or
> something like this would be useful and could be shared by both ACPI and
> machine_restart(). It would basically to everything that is needed in such
> a case :
>   - on SMP, bounce on boot_cpu, then halt the current CPU if != boot_cpu
>   - on SMP, stop all other CPUs
>   - on UP, disable IOAPIC
>   - disable local APIC
> 
> I suspect that this function would be useful for some suspend cases, but I'm

Well, to be usefull for suspend, also "opposite" code would be
neccessary (enable apic, restart other cpus).
And yes, that would be very welcome.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

