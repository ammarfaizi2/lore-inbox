Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268771AbTBZPpW>; Wed, 26 Feb 2003 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268782AbTBZPpW>; Wed, 26 Feb 2003 10:45:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39593 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268771AbTBZPpV>; Wed, 26 Feb 2003 10:45:21 -0500
Date: Wed, 26 Feb 2003 07:55:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.62-mjb3 (scalability / NUMA patchset)
Message-ID: <3090000.1046274931@[10.10.2.4]>
In-Reply-To: <1046273777.1913.6.camel@markh1.pdx.osdl.net>
References: <6490000.1045713212@[10.10.2.4]>
 <16170000.1046110132@[10.10.2.4]>
 <1046273777.1913.6.camel@markh1.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The patchset contains mainly scalability and NUMA stuff, and anything 
>> else that stops things from irritating me. It's meant to be pretty
>> stable,  not so much a testing ground for new stuff.
>> 
>> I'd be very interested in feedback from anyone willing to test on any 
>> platform, however large or small.
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.62/patch-2.5.62-
>> mjb 3.bz2
>> 
> 
> Martin,
> 
> I have been seeing system hangs on my 16 processor numaq while running
> contest.  The system will hang within a few seconds to half an hour. 
> Unfortunately there is no stack trace or any other indication on the
> system console.  I have been running your 2.5.62-mjb2 without problems
> previously.  Any ideas what I can do to narrow this down?

Humpf. Can you try backing out this patch (it caused me similar problems on
59, but seemed fine in 62). I suspect it's just changing timing enough that
we hit some other bug ... if you could, would be nice to try the ALT+SYSRQ
stuff, or turn on NMI watchdogs and get a backtrace ... I've  not been able
to reproduce this on recent kernels.

Thanks,

M.

diff -urpN -X /home/fletch/.diff.exclude
330-no_kirq/include/asm-i386/mach-numaq/mach_mpparse.h
340-auto_disable_tsc/include/asm-i386/mach-numaq/mach_mpparse.h
--- 330-no_kirq/include/asm-i386/mach-numaq/mach_mpparse.h	Fri Jan 17
09:18:31 2003
+++ 340-auto_disable_tsc/include/asm-i386/mach-numaq/mach_mpparse.h	Mon Feb
24 08:14:42 2003
@@ -32,6 +32,7 @@ static inline void mps_oem_check(struct 
 	if (mpc->mpc_oemptr)
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, 
 				mpc->mpc_oemsize);
+	tsc_disable=1;
 }
 
 /* Hook from generic ACPI tables.c */

