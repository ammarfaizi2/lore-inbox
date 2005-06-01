Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFAJpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFAJpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFAJmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:42:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61070 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261368AbVFAJkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:40:12 -0400
Date: Wed, 1 Jun 2005 11:39:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050601093913.GA17070@elte.hu>
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <20050601091908.GA13041@elte.hu> <429D80AD.1000601@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429D80AD.1000601@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Yes, I'm going to contact upstream about this. However, after closer 
> look on cpufreq code I came to a conclusion that the lock there 
> doesn't really play the role of a completion. There's always: down(), 
> then do something with the data structure, then up() in the same 
> function. I'm going to fix it differently after consulting with 
> upstream author (I now think that it should not be necessary to take 
> the lock in cpufreq_add_dev at all).

yeah. It would lead to incorrect code to use a completion if the purpose 
is a real lock. The main non-PREEMPT_RT-compatible use of semaphores is 
the unlocking of a semaphore the task did not lock itself. It is correct 
Linux code, so that alone is not a good reason to change upstream (and 
upstream doesnt and shouldnt bother about PREEMPT_RT at this point) - 
but if the underlying code is not entirely clean and the cross-owner-use 
of locks is not justified it might be possible to solve this via a 
cleanup.

	Ingo
