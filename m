Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUHOXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUHOXXx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUHOXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:23:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29583 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267238AbUHOXXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:23:38 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040815115649.GA26259@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu>  <20040815115649.GA26259@elte.hu>
Content-Type: text/plain
Message-Id: <1092612264.867.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 19:24:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 07:56, Ingo Molnar wrote:
> i've uploaded the -P0 patch:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0
> 
> those who had APIC (and USB, under SMP) problems under previous
> versions, are the problems still present in -P0?
>  
> Changes:
> 

The ide and /dev/random related latencies are indeed gone.  Here is an
ugly one that I got:

preemption latency trace v1.0
-----------------------------
 latency: 142 us, entries: 4 (4)
 process: ksoftirqd/0/2, uid: 0
 nice: -10, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): rhine_check_duplex (rhine_timer)
 0.000ms (+0.000ms): mdio_read (rhine_check_duplex)
 0.067ms (+0.067ms): mdio_read (rhine_timer)
 0.139ms (+0.071ms): check_preempt_timing (sub_preempt_count)

This looks like the exact same problem Florian had, in his case it was 
the sis900 driver.  Your recommendation was:

        #define mdio_delay() do { } while (0)

Should I try this?

Also, isn't there a better solution than for network drivers to actively 
poll for changes in link status?  Can't they just register a callback that 
will get run on a link state change event?

Lee

