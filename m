Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUHUKqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUHUKqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 06:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267506AbUHUKqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 06:46:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54693 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267511AbUHUKqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 06:46:10 -0400
Date: Sat, 21 Aug 2004 12:46:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
Message-ID: <20040821104626.GA29078@elte.hu>
References: <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <1093058602.854.5.camel@krustophenia.net> <20040821091338.GA25931@elte.hu> <1093079726.854.80.camel@krustophenia.net> <20040821091804.GA26622@elte.hu> <1093080202.854.94.camel@krustophenia.net> <20040821093152.GB27273@elte.hu> <1093081049.854.101.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093081049.854.101.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> 
> This one is interesting.  What is going on here?
> 
> preemption latency trace v1.0.1
> -------------------------------
>  latency: 146 us, entries: 45 (45)
>     -----------------
>     | task: pdflush/33, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: find_get_pages_tag+0x19/0x90
>  => ended at:   find_get_pages_tag+0x61/0x90
> =======>
> 00000001 0.000ms (+0.000ms): find_get_pages_tag (pagevec_lookup_tag)
> 00000001 0.000ms (+0.000ms): radix_tree_gang_lookup_tag (find_get_pages_tag)
> 00000001 0.001ms (+0.000ms): __lookup_tag (radix_tree_gang_lookup_tag)
> 00000001 0.007ms (+0.005ms): __lookup_tag (radix_tree_gang_lookup_tag)
> 
> [ 20-30 more of these ]

this is the pagevec code, triggering the radix tree multi-entry-lookup
code. Could you try to reduce PAGEVEC_SIZE from 16 to 8 (or 4) in
include/linux/pagevec.h - does this reduce these particular latencies?

	Ingo
