Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWE1AOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWE1AOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 20:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWE1AOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 20:14:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31680 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964980AbWE1AOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 20:14:08 -0400
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1148692456.5381.7.camel@localhost.localdomain>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
	 <1148692456.5381.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 27 May 2006 17:13:52 -0700
Message-Id: <1148775233.30211.1.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 21:14 -0400, Steven Rostedt wrote:
> On Fri, 2006-05-26 at 15:53 -0700, john stultz wrote:
> > Hey Ingo, All,
> > 	We had the following bug reported on bootup on one of our boxes (it
> > was a 4way I believe) running -rt22. So far it seems to be a one-off
> > but I figured I'd post it to see if anyone had a clue.
> 
> I'm assuming this is a i386.  Also I'm assuming that frame pointers was
> not compiled in since the stack is a little suspicious.
> 
> Anyway, could you show the /proc/interrupts of this machine.  I'm
> curious if the i8042 isn't sharing an interrupt with something with
> NODELAY in it.

Here ya go:
            CPU0       CPU1       CPU2       CPU3
   0:       8796    3868607        275     531673  IO-APIC-edge   [........N/  0]  pit
   2:          0          0          0          0  XT-PIC         [........N/  0]  cascade
   3:          5        620          2        229  IO-APIC-edge   [........./ 63]  serial
   8:          0          1          0          0  IO-APIC-edge   [........./  0]  rtc
  11:          0          0          0          0  IO-APIC-edge   [........./  0]  acpi
  19:        120          0          0          1  IO-APIC-level  [........./  0]  ohci_hcd:usb1, ohci_hcd:usb2
  24:         57          9          5      46795  IO-APIC-level  [........./  0]  eth0
  26:       1396      14537          0        702  IO-APIC-level  [........./  0]  ioc0
 NMI:          0          0          0          0
 LOC:    6907796    4419008    4415669    4413513
 ERR:          0
 MIS:          0

thanks
-john


