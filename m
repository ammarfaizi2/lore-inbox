Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUHaHFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUHaHFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 03:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHaHFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 03:05:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61624 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266885AbUHaHFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 03:05:24 -0400
Date: Tue, 31 Aug 2004 09:06:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831070658.GA31117@elte.hu>
References: <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093934448.5403.4.camel@krustophenia.net>
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

> Otherwise, this looks pretty good.  Here is a new one, I got this
> starting X:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk4-Q5#/var/www/2.6.9-rc1-bk4-Q5/trace2.txt

ok, MTRR setting overhead. It is not quite clear to me which precise
code took so much time, could you stick a couple of 'mcount();' lines
into arch/i386/kernel/cpu/mtrr/generic.c's prepare_set() and
generic_set_mtrr() functions? In particular the wbinvd() [cache
invalidation] instructions within prepare_set() look like a possible
source of latency.

(explicit calls to mcount() can be used to break up latency paths
manually - they wont affect the latency itself, they make the resulting
trace more finegrained.)

	Ingo
