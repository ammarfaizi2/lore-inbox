Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWEZKtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWEZKtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWEZKtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:49:41 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:28042 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751388AbWEZKtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:49:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
Date: Fri, 26 May 2006 20:48:52 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262048.53131.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 14:20, Peter Williams wrote:
> This patch implements (soft) CPU rate caps per task as a proportion of a
> single CPU's capacity expressed in parts per thousand.  The CPU usage
> of capped tasks is determined by using Kalman filters to calculate the
> (recent) average lengths of the task's scheduling cycle and the time
> spent on the CPU each cycle and taking the ratio of the latter to the
> former.  To minimize overhead associated with uncapped tasks these
> statistics are not kept for them.
>
> Notes:
>
> 1. To minimize the overhead incurred when testing to skip caps processing
> for uncapped tasks a new flag PF_HAS_CAP has been added to flags.

[ot]I'm sorry to see an Australian adopt American spelling [/ot]

> 3. Enforcement of caps is not as strict as it could be in order to
> reduce the possibility of a task being starved of CPU while holding
> an important system resource with resultant overall performance
> degradation.  In effect, all runnable capped tasks will get some amount
> of CPU access every active/expired swap cycle.  This will be most
> apparent for small or zero soft caps.

The array swap happens very frequently if there are nothing but heavily cpu 
bound tasks, which is not an infrequent workload. I doubt the zero caps are 
very effective in that environment.

-- 
-ck
