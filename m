Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUHSKhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUHSKhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHSKhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:37:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3972 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264991AbUHSKhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:37:05 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <1092911341.1739.1.camel@krustophenia.net>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092902417.8432.108.camel@krustophenia.net>
	 <20040819084001.GA4098@elte.hu>
	 <1092905104.8432.116.camel@krustophenia.net>
	 <20040819085643.GA4751@elte.hu>  <1092911341.1739.1.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1092911899.810.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 06:38:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 06:29, Lee Revell wrote:

> Yes, this takes care of it.  Now the dominant latency is the 142us
> latency from the via-rhine driver, which is fixed by using the driver
> from -mm (specifically it's fixed in bk-netdev.patch).
> 

OK, this is a new one:

preemption latency trace v1.0.1
-------------------------------
 latency: 104 us, entries: 26 (26) 
    -----------------
    | task: pdflush/33, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: find_get_pages_tag+0x19/0x90
 => ended at:   find_get_pages_tag+0x61/0x90
=======>
 0.000ms (+0.000ms): find_get_pages_tag (pagevec_lookup_tag)
 0.000ms (+0.000ms): radix_tree_gang_lookup_tag (find_get_pages_tag)
 0.000ms (+0.000ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.004ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.008ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.015ms (+0.006ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.019ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.022ms (+0.002ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.026ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.030ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.034ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.038ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.044ms (+0.005ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.048ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.055ms (+0.007ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.057ms (+0.002ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.060ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.066ms (+0.005ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.070ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.074ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.082ms (+0.008ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.083ms (+0.000ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.088ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.092ms (+0.004ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.095ms (+0.003ms): __lookup_tag (radix_tree_gang_lookup_tag)
 0.102ms (+0.007ms): sub_preempt_count (find_get_pages_tag)

Lee

