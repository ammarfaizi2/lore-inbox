Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUE1JEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUE1JEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUE1JEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:04:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56726 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262389AbUE1JE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:04:27 -0400
Date: Fri, 28 May 2004 11:05:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <peterw@aurema.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Message-ID: <20040528090536.GA12933@elte.hu>
References: <40B6C571.3000103@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B6C571.3000103@aurema.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <peterw@aurema.com> wrote:

> -- at the end of each time slice (or when waking up) each task is
> given a complete new time slice and, if class SCHED_NORMAL, is put in
> a priority slot given by (static_prio + MAX_BONUS - interactive_bonus)

this is the Achilles' heel of approaches that try to get rid of the
active/expired array and/or try to get rid of timeslice tracking. A
CPU-bound task which schedules away for small amounts of time will get a
disproportionatly larger share of the CPU than a CPU-bound task that
doesnt schedule at all.

just try it - run a task that runs 95% of the time and sleeps 5% of the
time, and run a (same prio) task that runs 100% of the time. With the
current scheduler the slightly-sleeping task gets 45% of the CPU, the
looping one gets 55% of the CPU. With your patch the slightly-sleeping
process can easily monopolize 90% of the CPU!

	Ingo
