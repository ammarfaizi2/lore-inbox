Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWF0KOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWF0KOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWF0KOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:14:02 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29841 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932841AbWF0KOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:14:00 -0400
Date: Tue, 27 Jun 2006 12:08:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove extra local_bh_disable/enable from arch do_softirq
Message-ID: <20060627100856.GA17160@elte.hu>
References: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> At the moment, powerpc and s390 have their own versions of do_softirq 
> which include local_bh_disable() and __local_bh_enable() calls.  They 
> end up calling __do_softirq (in kernel/softirq.c) which also does 
> local_bh_disable/enable.
> 
> Apparently the two levels of disable/enable trigger a warning from 
> some validation code that Ingo is working on, and he would like to see 
> the outer level removed.  But to do that, we have to move the 
> account_system_vtime calls that are currently in the arch do_softirq() 
> implementations for powerpc and s390 into the generic __do_softirq() 
> (this is a no-op for other archs because account_system_vtime is 
> defined to be an empty inline function on all other archs).  This 
> patch does that.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

thanks - this solves the problem nicely.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
