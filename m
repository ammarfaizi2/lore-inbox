Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWCAG1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCAG1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWCAG1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:27:19 -0500
Received: from fsmlabs.com ([168.103.115.128]:2012 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932427AbWCAG1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:27:19 -0500
X-ASG-Debug-ID: 1141194424-2996-64-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 28 Feb 2006 22:31:30 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
In-Reply-To: <20060301032819.GC2856@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602282230160.28074@montezuma.fsmlabs.com>
References: <20060219235826.GF3293@localhost.localdomain>
 <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com>
 <20060227075033.GK3293@localhost.localdomain> <Pine.LNX.4.64.0602270748240.1579@montezuma.fsmlabs.com>
 <20060228213412.GB2856@localhost.localdomain>
 <Pine.LNX.4.64.0602281412450.28074@montezuma.fsmlabs.com>
 <20060301032819.GC2856@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9306
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Nathan Lynch wrote:

> 
> [17179687.244000] CPU 1 is now offline
> [17179693.164000] Booting processor 1/1 eip 3000
> [17179693.216000] CPU 1 irqstacks, hard=7837f000 soft=78377000
> [17179693.284000] Setting warm reset code and vector.
> [17179693.340000] 1.
> [17179693.364000] 2.
> [17179693.388000] 3.
> [17179693.408000] Asserting INIT.
> [17179693.448000] Waiting for send to finish...
> [17179693.496000] +<7>Deasserting INIT.
> [17179693.552000] Waiting for send to finish...
> [17179693.600000] +<7>#startup loops: 2.
> [17179693.644000] Sending STARTUP #1.
> [17179693.688000] After apic_write.
> [17179693.724000] Doing apic_write_around for target chip...
> [17179693.788000] Doing apic_write_around to kick the second...

Ok, could you apply only the following patch?

Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	11 Feb 2006 16:55:14 -0000	1.1.1.1
+++ linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	1 Mar 2006 06:30:06 -0000
@@ -535,9 +535,14 @@ static void __devinit start_secondary(vo
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
+	Dprintk("S1\n");
 	cpu_init();
+	Dprintk("S2\n");
 	preempt_disable();
+	Dprintk("S3\n");
 	smp_callin();
+	Dprintk("S4\n");
+
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
