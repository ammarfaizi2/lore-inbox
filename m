Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWAQH7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWAQH7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 02:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWAQH7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 02:59:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55701 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751290AbWAQH7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 02:59:04 -0500
Date: Tue, 17 Jan 2006 08:59:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, Tony.Reix@bull.net,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] fix sched_setscheduler semantics
Message-ID: <20060117075924.GC13580@elte.hu>
References: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason Baron <jbaron@redhat.com> wrote:

> Therefore, i'd suggest the following patch. Verified to fix the 
> attached test case. Thanks to Tony Reix for pointing this out.

indeed - good catch.

>  asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
>  				       struct sched_param __user *param)
>  {
> +	/* negative values for policy are not valid */
> +	if (policy < 0)
> +		return -EINVAL;
> +
>  	return do_sched_setscheduler(pid, policy, param);

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
