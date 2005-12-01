Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVLAVUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVLAVUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLAVUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:20:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56006 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932484AbVLAVUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:20:44 -0500
Date: Thu, 1 Dec 2005 22:21:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
Subject: Re: Perf degradation from -rt14 onwards
Message-ID: <20051201212105.GA25686@elte.hu>
References: <20051201204227.GA16035@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201204227.GA16035@in.ibm.com>
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


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> I was wondering why the following change was made from -rt14
> onwards.
> 
> 
> @@ -1634,7 +1531,7 @@ asmlinkage long sys_futex(u32 __user *ua
>                           int val3)
>  {
>         struct timespec t;
> -       unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
> +       unsigned long timeout = 0;
> 
> This was introduced in patch-2.6.14-rt13-rf3 by David.
> 
> This seems to return spurious -ETIMEDOUT errors even in the non-robust 
> code and results in userspace (glibc) retrying several mutex 
> operations before it succeeds. I was chasing down a degradation of 
> performance of some testcases and was able to fix those by reverting 
> this change back.

nice catch! I've undone this change in my tree.

	Ingo
