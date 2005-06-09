Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVFIBiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVFIBiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVFIBiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:38:16 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:9834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262223AbVFIBiH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:38:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XNUs4qjxryByDGNGGM0+UqKaep1L+tcabcQe0tWCsgPs3tGxTSGnVWRghCkMeBaUigosaRq7AN3+OPOuWaKkicyav1m3mYh5d1VxkxNFd+DukC7eUgJrVtwpoZv/LV+USdUDmxtf1lt0lcTuBVR1snXnRcG47/Gc2e6j4xEV/Sc=
Message-ID: <9e47339105060818383e2311f@mail.gmail.com>
Date: Wed, 8 Jun 2005 21:38:04 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Dell BIOS and HPET timer support
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Bob Picco <Robert.Picco@hp.com>
In-Reply-To: <1118278673.6247.32.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004EBD1B0@scsmsx403.amr.corp.intel.com>
	 <9e47339105060817342bdd2dd@mail.gmail.com>
	 <1118278673.6247.32.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Lee Revell <rlrevell@joe-job.com> wrote:
> Check the source, it's self-explanatory.  See hpet_alloc().

What is going on with do_div()? 
0x0429b17f /100000 = 69.8 in my caculator. It comes back as 0 from do_div().

[jonsmirl@jonsmirl ~]$ dmesg | grep HPET
HPET: cap 0429b17f8086a201 period 0429b17f
HPET: period 0429b17f ns 0429b17f
HPET: period 0429b17f ns 00000000
Using HPET for base-timer
Using HPET for gettimeofday
[jonsmirl@jonsmirl ~]$


	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
	    HPET_COUNTER_CLK_PERIOD_SHIFT;
printk(KERN_ERR "HPET: cap %016llx period %08lx\n", cap, hpetp->hp_period);

	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
printk(KERN_ERR "HPET: period %08lx ns %08lx \n", hpetp->hp_period, ns);
	do_div(ns, 1000000);	/* convert to nanoseconds, 10^-9 */
printk(KERN_ERR "HPET: period %08lx ns %08lx \n", hpetp->hp_period, ns);
	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
		hpetp->hp_which, ns, hpetp->hp_ntimer,
		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
-- 
Jon Smirl
jonsmirl@gmail.com
