Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbUKTLxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbUKTLxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKTLxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:53:55 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18323 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262735AbUKTLw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:52:27 -0500
Date: Sat, 20 Nov 2004 13:53:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, domen@coderock.org
Subject: Re: [patch 3/8]  kernel/sched.c: fix subtle TASK_RUNNING compare
Message-ID: <20041120125355.GB8091@elte.hu>
References: <E1CVL0H-0000SH-EN@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVL0H-0000SH-EN@sputnik>
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


* janitor@sternwelten.at <janitor@sternwelten.at> wrote:

>  	switch_count = &prev->nivcsw;
> -	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
> +	if (prev->state != TASK_RUNNING &&
> +			!(preempt_count() & PREEMPT_ACTIVE)) {
>  		switch_count = &prev->nvcsw;

nack. We inherently rely on the process state mask being a bitmask and
TASK_RUNNING thus being zero.

	Ingo
