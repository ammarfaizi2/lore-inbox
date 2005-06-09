Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVFII7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVFII7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVFII7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:59:52 -0400
Received: from odin2.bull.net ([192.90.70.84]:54438 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262252AbVFII7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:59:47 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <42A72A53.5050809@cybsft.com>
References: <20050608112801.GA31084@elte.hu> <42A7135C.5010704@cybsft.com>
	 <42A72A53.5050809@cybsft.com>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1118306872.10717.38.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Thu, 09 Jun 2005 10:47:52 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 08/06/2005 à 19:26, K.R. Foley a écrit :
> K.R. Foley wrote:
> > Ingo Molnar wrote:
> > 
> >> i have released the -V0.7.48-00 Real-Time Preemption patch, which can 
> >> be downloaded from the usual place:
...
> >>     Ingo
> > 
> > 
> > Ingo,
> > 
> > I can't get any version of RT-preempt applied to 2.6.12-rc6 up to and 
> > including 48-01 to boot on any of my SMP systems. I get no log because 
> > it dies right after the "Uncompressing kernel" message. 2.6.12-rc6 boots 
> > fine.  I am attaching my config. Am I missing something obvious? I am 
> > building 48-01 with voluntary-preempt now to try that.
> > 
> > 
> 
> Well crap. Perhaps I should have tried this first. If I disable the 
> runtime selectable locking
> 
> # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> 
> it seems to work fine. With the above enabled it hangs on both of my SMP 
> systems as described above. :-/

Same problem here. OK unsetting the CONFIG_DEBUG_RT_LOCKING_MODE.

I have another problem :
I can't boot. 
With 47-15 I had the following with dmesg :
...
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Total of 2 processors activated (7110.65 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
WARNING: 1 siblings found for CPU1, should be 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
checking TSC synchronization across 2 CPUs: passed.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
desched cpu_callback 3/00000001
desched cpu_callback 2/00000001
ksoftirqd started up.
...

Now I have this with 48-01 :

Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) CPU 1.80GHz stepping 04
Total of 2 processors activated (7110.65 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
                                                  <======= missing CPU1
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ...  <======= freeze

Is it a problem or a CONFIG parameter ?


