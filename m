Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUIJNJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUIJNJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIJNJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 09:09:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43723 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267388AbUIJNJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 09:09:17 -0400
Date: Fri, 10 Sep 2004 15:10:40 +0200
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
Message-ID: <20040910131040.GA7561@elte.hu>
References: <OFFF07CECA.A4F18108-ON86256F0B.00472BB6-86256F0B.00472BCC@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFF07CECA.A4F18108-ON86256F0B.00472BB6-86256F0B.00472BCC@raytheon.com>
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

> 00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
> 00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
> 00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
> 00000002 0.000ms (+0.113ms): spin_lock (<00000000>)
> 00010002 0.113ms (+0.000ms): do_nmi (get_swap_page)

> Are you SURE the spin lock counter works properly on SMP systems?
> I did a quick check of yesterday's results:
>   # grep -ir '<.*>' latencytest0.42-png/lt040909  | wc -l
>   6978
>   # grep -ir '<.*>' latencytest0.42-png/lt040909  | grep -v '<00000000>' |
> less -im
>   ...

> No entries that are non zero and lock related.

it works fine here. To double-check i've created a contention testcase:

 00000001 0.000ms (+0.000ms): spin_lock (sys_gettimeofday)
 00000001 0.000ms (+0.000ms): spin_lock (<000012ce>)

this spin_lock() spun 4814 times before it got the lock.

Linux locking is pretty uncontended on 2-way boxes.

	Ingo
