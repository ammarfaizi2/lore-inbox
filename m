Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWBUQPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWBUQPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWBUQPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:15:41 -0500
Received: from fsmlabs.com ([168.103.115.128]:32937 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932307AbWBUQPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:15:40 -0500
X-ASG-Debug-ID: 1140538537-6553-38-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 21 Feb 2006 08:20:10 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
In-Reply-To: <20060219235826.GF3293@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com>
References: <20060219235826.GF3293@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9000
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Nathan Lynch wrote:

> On a dual P3 Xeon machine, offlining and then onlining a cpu makes the
> box instantly reboot.  I've been seeing this throughout the 2.6.16-rc
> series, but wasn't able to collect more information until now.  Not
> sure when this last worked, unfortunately.
> 
> With the debugging patch below, I get this on serial console:

Does 2.6.14 work? Also i wonder if it gets out of the trampoline...

Index: linux-2.6.16-rc2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.16-rc2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.16-rc2/arch/i386/kernel/smpboot.c	11 Feb 2006 18:55:06 -0000	1.1.1.1
+++ linux-2.6.16-rc2/arch/i386/kernel/smpboot.c	21 Feb 2006 16:19:22 -0000
@@ -514,6 +514,7 @@ static void __devinit start_secondary(vo
 	cpu_init();
 	preempt_disable();
 	smp_callin();
+	Dprintk("startup_secondary\n");
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
