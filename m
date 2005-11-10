Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVKJU3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVKJU3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKJU3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:29:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:4575 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751227AbVKJU3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:29:38 -0500
Subject: Re: IO-APIC problem with 2.6.14-rt9
From: john stultz <johnstul@us.ibm.com>
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051110203000.GB16301@in.ibm.com>
References: <20051110200226.GA18780@in.ibm.com>
	 <20051110200205.GA4696@elte.hu>  <20051110203000.GB16301@in.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 12:29:34 -0800
Message-Id: <1131654575.27168.685.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 02:00 +0530, Dinakar Guniguntala wrote:
> On Thu, Nov 10, 2005 at 09:02:05PM +0100, Ingo Molnar wrote:
> > 
> > * Dinakar Guniguntala <dino@in.ibm.com> wrote:
> > 
> > > Hi,
> > > 
> > > I get this on boot with 2.6.14-rt9
> > > 
> > > Intel machine check architecture supported.
> > > Intel machine check reporting enabled on CPU#3.
> > > CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> > > CPU3: Intel(R) Xeon(TM) MP CPU 2.50GHz stepping 05
> > > Total of 4 processors activated (11165.69 BogoMIPS).
> > > ENABLING IO-APIC IRQs
> > > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > > ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> > > ...trying to set up timer as Virtual Wire IRQ... failed.
> > > ...trying to set up timer as ExtINT IRQ... failed :(.
> > > Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the
> > 
> > does it help if you edit include/asm-i386/timex.h and change this line:
> > 
> > //#define ARCH_HAS_READ_CURRENT_TIMER  1
> > 
> > to:
> > 
> > #define ARCH_HAS_READ_CURRENT_TIMER  1
> > 
> > ?
> 
> It works !!  Thanks Ingo for the immediate response

Hrm. Could you post the value for BogoMIPS that you're getting now?

My patches touch the __delay() code, since using the TSC based delay has
just as many, if not more, problems as the loop based delay. So I want
to be careful that my changes are not further causing problems.

Ingo, did you commented out ARCH_HAS_READ_CURRENT_TIMER because of
problems with the new calibration code?

thanks
-john

