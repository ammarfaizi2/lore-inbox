Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUICLeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUICLeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269626AbUICLeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:34:10 -0400
Received: from pD9E0E92F.dip.t-dialin.net ([217.224.233.47]:34696 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S269622AbUICLeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:34:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <20040903092547.GA18594@elte.hu>
References: <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
	 <1094194157.19760.71.camel@krustophenia.net>
	 <20040903070500.GB13100@elte.hu>
	 <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org>
	 <1094198755.19760.133.camel@krustophenia.net>
	 <20040903092547.GA18594@elte.hu>
Content-Type: text/plain
Message-Id: <1094211218.5453.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 13:33:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> Florian Schmidt reported a minor bug that prevents a successful build if
> !CONFIG_LATENCY_TRACE - i've uploaded -R1 that fixes this:
>   
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R1
> 

I still get > 170 us latency from rtl8139 :
http://www.undata.org/~thomas/R1_rtl8139.trace

And again this one :
preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 597 us, entries: 12 (12)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: smp_apic_timer_interrupt+0x32/0xd0
 => ended at:   smp_apic_timer_interrupt+0x86/0xd0
=======>
00010000 0.000ms (+0.000ms): smp_apic_timer_interrupt
(apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_hook (profile_tick)
00010001 0.000ms (+0.595ms): notifier_call_chain (profile_hook)
00010000 0.595ms (+0.000ms): do_nmi (mcount)
00020000 0.596ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00020000 0.596ms (+0.000ms): profile_hook (profile_tick)
00020001 0.597ms (+0.000ms): notifier_call_chain (profile_hook)
00020000 0.597ms (+689953.444ms): profile_hit (nmi_watchdog_tick)
00010001 689954.042ms (+1.141ms): update_process_times (do_timer)
00000001 0.597ms (+0.000ms): sub_preempt_count
(smp_apic_timer_interrupt)
00000001 0.598ms (+0.000ms): update_max_trace (check_preempt_timing)

Thomas


