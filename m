Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUH3O1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUH3O1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUH3O00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:26:26 -0400
Received: from pD9E0ECA5.dip.t-dialin.net ([217.224.236.165]:27268 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S268060AbUH3O0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:26:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu>
Content-Type: text/plain
Message-Id: <1093875939.5534.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 Aug 2004 16:25:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> i've uploaded -Q5 to:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5
> 

Here are the problematic spots for me with Q5:

rtl8139_poll (this one was also present with previous versions of the
patch) :
http://www.undata.org/~thomas/q5_rtl8139.trace

use_module (modprobe) :
preemption latency trace v1.0.2
-------------------------------
 latency: 154 us, entries: 4 (4)
    -----------------
    | task: modprobe/8172, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: resolve_symbol+0x21/0xa0
 => ended at:   resolve_symbol+0x57/0xa0
=======>
00000001 0.000ms (+0.000ms): resolve_symbol (simplify_symbols)
00000001 0.000ms (+0.000ms): __find_symbol (resolve_symbol)
00000001 0.154ms (+0.154ms): use_module (resolve_symbol)
00000001 0.154ms (+0.000ms): sub_preempt_count (resolve_symbol)

and a weird one with do_timer (called from do_IRQ) taking more than 1ms
to complete :
http://www.undata.org/~thomas/do_irq.trace

Thomas


