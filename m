Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313887AbSDQUC2>; Wed, 17 Apr 2002 16:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314108AbSDQUC1>; Wed, 17 Apr 2002 16:02:27 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:22801 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S313887AbSDQUCZ>; Wed, 17 Apr 2002 16:02:25 -0400
Date: Wed, 17 Apr 2002 14:02:05 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204171907180.5540-100000@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Ingo Molnar wrote:

> 
> On Wed, 17 Apr 2002, James Bourne wrote:
> 
> > Where would I find this separate patch?  Is there something I could do
> > some testing on?
> 
> the timer irq inbalance problem should be solved by the attached patch.

Thanks Ingo,
That has balanced the timer irqs.  I've also enabled hyper threading
(append="acpismp=force").

Here's the output from /proc/interrupts:
brynhild:bash$ cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:       3033       2911       2871       2880    IO-APIC-edge  timer
  1:          1          0          2          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0    IO-APIC-edge  rtc
 18:          5          3          3          4   IO-APIC-level  aic7xxx
 19:        480        421        412        529   IO-APIC-level  eth0
 20:          5          3          4          4   IO-APIC-level  aic7xxx
 21:          5          3          4          4   IO-APIC-level  aic7xxx
 27:        588       1010        654        943   IO-APIC-level  megaraid
NMI:          0          0          0          0 
LOC:      11530      11528      11528      11466 
ERR:          0
MIS:          0

And, you've gotta like this line:
Total of 4 processors activated (14299.95 BogoMIPS).

I'm going to do some testing on it to check it's stability.
I'll let you know the results.

Thanks again and regards,
James

> 
> 	Ingo
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

