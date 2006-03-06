Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWCFNZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWCFNZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWCFNZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:25:56 -0500
Received: from proof.pobox.com ([207.106.133.28]:63423 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932272AbWCFNZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:25:55 -0500
Date: Mon, 6 Mar 2006 07:25:50 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Message-ID: <20060306132549.GA3662@localhost.localdomain>
References: <20060219235826.GF3293@localhost.localdomain> <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com> <20060227075033.GK3293@localhost.localdomain> <Pine.LNX.4.64.0602270748240.1579@montezuma.fsmlabs.com> <20060228213412.GB2856@localhost.localdomain> <Pine.LNX.4.64.0602281412450.28074@montezuma.fsmlabs.com> <20060301032819.GC2856@localhost.localdomain> <Pine.LNX.4.64.0602282230160.28074@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602282230160.28074@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 28 Feb 2006, Nathan Lynch wrote:
> 
> > 
> > [17179687.244000] CPU 1 is now offline
> > [17179693.164000] Booting processor 1/1 eip 3000
> > [17179693.216000] CPU 1 irqstacks, hard=7837f000 soft=78377000
> > [17179693.284000] Setting warm reset code and vector.
> > [17179693.340000] 1.
> > [17179693.364000] 2.
> > [17179693.388000] 3.
> > [17179693.408000] Asserting INIT.
> > [17179693.448000] Waiting for send to finish...
> > [17179693.496000] +<7>Deasserting INIT.
> > [17179693.552000] Waiting for send to finish...
> > [17179693.600000] +<7>#startup loops: 2.
> > [17179693.644000] Sending STARTUP #1.
> > [17179693.688000] After apic_write.
> > [17179693.724000] Doing apic_write_around for target chip...
> > [17179693.788000] Doing apic_write_around to kick the second...
> 
> Ok, could you apply only the following patch?

Sorry for the delay in getting back to you.

Applied your latest patch, (plus one-liner to make Dprintk actually
print) -- I don't see any of the new print statements:

[17179687.744000] CPU 1 is now offline
[17179693.032000] Booting processor 1/1 eip 3000
[17179693.084000] CPU 1 irqstacks, hard=783da000 soft=783d2000
[17179693.152000] Setting warm reset code and vector.
[17179693.208000] 1.
[17179693.232000] 2.
[17179693.256000] 3.
[17179693.276000] Asserting INIT.
[17179693.316000] Waiting for send to finish...
[17179693.364000] +<7>Deasserting INIT.
[17179693.420000] Waiting for send to finish...
[17179693.468000] +<7>#startup loops: 2.
[17179693.512000] Sending STARTUP #1.
[17179693.556000] After apic_write.



> 
> Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 smpboot.c
> --- linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	11 Feb 2006 16:55:14 -0000	1.1.1.1
> +++ linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	1 Mar 2006 06:30:06 -0000
> @@ -535,9 +535,14 @@ static void __devinit start_secondary(vo
>  	 * booting is too fragile that we want to limit the
>  	 * things done here to the most necessary things.
>  	 */
> +	Dprintk("S1\n");
>  	cpu_init();
> +	Dprintk("S2\n");
>  	preempt_disable();
> +	Dprintk("S3\n");
>  	smp_callin();
> +	Dprintk("S4\n");
> +
>  	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
>  		rep_nop();
>  	setup_secondary_APIC_clock();
