Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUIIPMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUIIPMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUIIPML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:12:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265492AbUIIPL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:11:59 -0400
Date: Thu, 9 Sep 2004 17:12:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040909151228.GA16804@elte.hu>
References: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> 00000004 0.005ms (+0.321ms): send_IPI_mask_bitmask (flush_tlb_others)
> 00010004 0.327ms (+0.000ms): do_nmi (flush_tlb_others)
> 00010004 0.327ms (+0.003ms): do_nmi (kallsyms_lookup)

these traces happen if you forget to do 'dmesg -n 1' to turn off console
output. One CPU does a latency-printout with interrupts disabled, and
this CPU keeps waiting in flush_tlb_others(). The second do_nmi() entry
(which is a special one, showing the other CPU's activity) indeed shows
that the CPU is executing in kallsyms_lookup() - possibly it's in the
middle of a latency printout.

i havent seen such type of traces with 'dmesg -n 1'.

	Ingo
