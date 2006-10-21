Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992771AbWJUBZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992771AbWJUBZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWJUBZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:25:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030379AbWJUBZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:25:52 -0400
Date: Fri, 20 Oct 2006 18:25:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061020182527.a07666a4.akpm@osdl.org>
In-Reply-To: <20061020205651.GA26801@elte.hu>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
	<20061020110746.0db17489.akpm@osdl.org>
	<1161368034.5274.278.camel@localhost.localdomain>
	<20061020112627.04a4035a.akpm@osdl.org>
	<1161370015.5274.282.camel@localhost.localdomain>
	<20061020121537.dea13469.akpm@osdl.org>
	<20061020203731.GA22407@elte.hu>
	<20061020135450.6794a2bb.akpm@osdl.org>
	<20061020205651.GA26801@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 22:56:51 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Oh.  I thought the problem was that the timer stops when the CPU is 
> > idle. Maybe I misremembered.  I'll try `idle=poll'.
> 
> hm, wouldnt in that case the box not boot at all? But yeah, idle=poll 
> would be nice.

idle=poll fixes it.  The fan gets a bit noisy though ;)

Perhaps a suitable test would be to set up a PIT interrupt, do a hlt, see
if the APIC timer counter has increased appropriately.




I got this:

[   43.709238] TSC appears to be running slowly. Marking it as unstable

How come?  It also happens with HIGH_RES_TIMERS=n and NO_HZ=n.  It only
seems to happen when idle=poll is given.



> could you also boot with apic=verbose and send us the full bootlog?
> 

http://userweb.kernel.org/~akpm/apic.txt

I gave up on waiting for it to complete initscripts.


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 2.00GHz
stepping        : 8
cpu MHz         : 800.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
bogomips        : 3994.15
