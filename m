Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVFICGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVFICGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFICGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:06:30 -0400
Received: from fmr16.intel.com ([192.55.52.70]:709 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261414AbVFICG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:06:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Dell BIOS and HPET timer support
Date: Wed, 8 Jun 2005 19:06:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004EF3629@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dell BIOS and HPET timer support
Thread-Index: AcVsk+I3bCW5S+LkRWuwJ6uOfyBUoQAA9mYg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, "Lee Revell" <rlrevell@joe-job.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>, "Bob Picco" <Robert.Picco@hp.com>
X-OriginalArrivalTime: 09 Jun 2005 02:06:22.0974 (UTC) FILETIME=[D59EC1E0:01C56C97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think do_div expects a 64 bit 1st argument. Can you change ns to
unsigneld long long and try...

Thanks,
Venki 

>-----Original Message-----
>From: Jon Smirl [mailto:jonsmirl@gmail.com] 
>Sent: Wednesday, June 08, 2005 6:38 PM
>To: Lee Revell
>Cc: Pallipadi, Venkatesh; lkml; Bob Picco
>Subject: Re: Dell BIOS and HPET timer support
>
>On 6/8/05, Lee Revell <rlrevell@joe-job.com> wrote:
>> Check the source, it's self-explanatory.  See hpet_alloc().
>
>What is going on with do_div()? 
>0x0429b17f /100000 = 69.8 in my caculator. It comes back as 0 
>from do_div().
>
>[jonsmirl@jonsmirl ~]$ dmesg | grep HPET
>HPET: cap 0429b17f8086a201 period 0429b17f
>HPET: period 0429b17f ns 0429b17f
>HPET: period 0429b17f ns 00000000
>Using HPET for base-timer
>Using HPET for gettimeofday
>[jonsmirl@jonsmirl ~]$
>
>
>	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
>	    HPET_COUNTER_CLK_PERIOD_SHIFT;
>printk(KERN_ERR "HPET: cap %016llx period %08lx\n", cap, 
>hpetp->hp_period);
>
>	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
>printk(KERN_ERR "HPET: period %08lx ns %08lx \n", 
>hpetp->hp_period, ns);
>	do_div(ns, 1000000);	/* convert to nanoseconds, 10^-9 */
>printk(KERN_ERR "HPET: period %08lx ns %08lx \n", 
>hpetp->hp_period, ns);
>	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
>		hpetp->hp_which, ns, hpetp->hp_ntimer,
>		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
>-- 
>Jon Smirl
>jonsmirl@gmail.com
>
