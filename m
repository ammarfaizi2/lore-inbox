Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUAKX7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUAKX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:59:41 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9107 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S266030AbUAKX7i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:59:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.1 and irq balancing
Date: Sun, 11 Jan 2004 15:59:20 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.1 and irq balancing
Thread-Index: AcPYAvai+KnVx409Q2OiNqoWY2JcDAAmhENQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ethan Weinstein" <lists@stinkfoot.org>, "Ed Tomlinson" <edt@aei.ca>
Cc: <linux-kernel@vger.kernel.org>, <piggin@cyberone.com.au>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
X-OriginalArrivalTime: 11 Jan 2004 23:59:21.0712 (UTC) FILETIME=[EEAAF700:01C3D89E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Admittedly, the machine's load was not high when I took this sample.
> However, creating a great deal of load does not change these
statistics
> at all.  Being that there are patches available for 2.4.x kernels to
fix
> this, I don't think this at all by design, but what do I know? =)

2.6 kernels don't need a patch to it as far as I understand. Are you
saying that with significant amount of load, you did not see any
distribution of interrupts? Today's threshold in the kernel is high
because we found moving around interrupts frequently rather hurt the
cache and thus lower the performance compared to "do nothing". Can you
try to create significant load with your network (eth0 and eh1) and see
what happens? 

Jun 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Ethan Weinstein
> Sent: Saturday, January 10, 2004 9:19 PM
> To: Ed Tomlinson
> Cc: linux-kernel@vger.kernel.org; piggin@cyberone.com.au
> Subject: Re: 2.6.1 and irq balancing
> 
> Ed Tomlinson wrote:
> > Hi,
> >
> > What is the load on the box when this is happening?  If its low
think
> > this is optimal (for cache reasons).
> >
> 
> Admittedly, the machine's load was not high when I took this sample.
> However, creating a great deal of load does not change these
statistics
> at all.  Being that there are patches available for 2.4.x kernels to
fix
> this, I don't think this at all by design, but what do I know? =)
> 
> 2.6.0 running on a non-HT SMP machine I have (old Compaq proliant
> 2xPentium2) does interrupt on all CPU's with "noirqbalance" bootparam.
> 
> Regarding the keyboard, I noticed something interesting
> 
> 2.6.1-rc1 shows the i8042 in /proc/interrupts:
> 
>    1:       1871          0          0          0    IO-APIC-edge
i8042
> 
> (keyboard still does not work, though..)
> 
> 2.6.1 final does not show this at all, and [kseriod] eats a constant
5%
>   CPU.  Something's awry =)
> 
> 
> -Ethan
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
