Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWF1Thm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWF1Thm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWF1Thm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:37:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61888 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751099AbWF1Thl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:37:41 -0400
Date: Wed, 28 Jun 2006 21:32:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060628193256.GA4392@elte.hu>
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628182137.GA23979@in.ibm.com>
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


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Turns out that kprobe_flush_task() is called from finish_task_switch() 
> with preemption disabled and it uses a converted spin lock. The 
> following patch fixed the problem for me and I was able to boot my 
> x86_64 box.

ah, subtle problem and nice fix! We are using an RCU trick to delay task 
freeing in finish_task_switch(), but kprobe_flush_task() isnt done in 
put_task_struct(). [neither would it be right to flush kprobes there.] 
I've released -rt4 with this included.

	Ingo
