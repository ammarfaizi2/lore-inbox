Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVKJUUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVKJUUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVKJUUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:20:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33446 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751225AbVKJUUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:20:45 -0500
Date: Fri, 11 Nov 2005 02:00:00 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051110203000.GB16301@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051110200226.GA18780@in.ibm.com> <20051110200205.GA4696@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110200205.GA4696@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 09:02:05PM +0100, Ingo Molnar wrote:
> 
> * Dinakar Guniguntala <dino@in.ibm.com> wrote:
> 
> > Hi,
> > 
> > I get this on boot with 2.6.14-rt9
> > 
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#3.
> > CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU3: Intel(R) Xeon(TM) MP CPU 2.50GHz stepping 05
> > Total of 4 processors activated (11165.69 BogoMIPS).
> > ENABLING IO-APIC IRQs
> > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> > ...trying to set up timer as Virtual Wire IRQ... failed.
> > ...trying to set up timer as ExtINT IRQ... failed :(.
> > Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the
> 
> does it help if you edit include/asm-i386/timex.h and change this line:
> 
> //#define ARCH_HAS_READ_CURRENT_TIMER  1
> 
> to:
> 
> #define ARCH_HAS_READ_CURRENT_TIMER  1
> 
> ?

It works !!  Thanks Ingo for the immediate response

Just a clarification. The comment in the file include/asm-i386/timex.h
says

	/*
	 * On an Athlon64 the cycles-based estimator is off by a
	 * factor of 2: udelay(100) takes 200 usecs. With the non-TSC
	 * based estimator the timings are precise. So turn it off.
	 */
	#define ARCH_HAS_READ_CURRENT_TIMER     1

Does this mean that this is not Athlon specific and needs to be
changed? I have a IBM x255 with Xeon processors

	-Dinakar





