Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWE1HiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWE1HiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWE1HiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:38:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:34510 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932076AbWE1HiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:38:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kuNcvYNXnp9ZNhuXOgQyIuY2QIJoF/d3mGkhL3en/ZN9eqza8LIw8h4ylchxeXumBSlIk/SL2xCeeoESyt+3Qspkr+XF1yXugQbVBoQMirmxd3IzZDOd+dj0i0FThphQqLLLYdoB2a1nSwctbBDMMJYZcm3wuAIBaY92HWSUmWM=
Message-ID: <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>
Date: Sun, 28 May 2006 13:08:16 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Peter Williams" <pwil3058@bigpond.net.au>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
Cc: "Mike Galbraith" <efault@gmx.de>, "Con Kolivas" <kernel@kolivas.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Kingsley Cheung" <kingsley@aurema.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Rene Herman" <rene.herman@keyaccess.nl>
In-Reply-To: <4478EA9D.4030201@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>
	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>
	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>
X-Google-Sender-Auth: 1d82aa2159ec47c6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
> Peter Williams wrote:
> > Balbir Singh wrote:
> >> On 5/26/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
> >> <snip>
> >>>
> >>> Notes:
> >>>
> >>> 1. To minimize the overhead incurred when testing to skip caps
> >>> processing for
> >>> uncapped tasks a new flag PF_HAS_CAP has been added to flags.
> >>>
> >>> 2. The implementation involves the addition of two priority slots to the
> >>> run queue priority arrays and this means that MAX_PRIO no longer
> >>> represents the scheduling priority of the idle process and can't be
> >>> used to
> >>> test whether priority values are in the valid range.  To alleviate this
> >>> problem a new function sched_idle_prio() has been provided.
> >>
> >> I am a little confused by this. Why link the bandwidth expired tasks a
> >> cpu (its caps) to a priority slot? Is this a hack to conitnue using
> >> the prio_array? why not move such tasks to the expired array?
> >
> > Because it won't work as after the array switch they may get to run
> > before tasks who aren't exceeding their cap (or don't have a cap).
>

That behaviour would be fair. Let the priority govern who gets to run
first (irrespective of their cap) and then use the cap to limit their
timeslice (execution time).

> Another important reason for using these slots is that it allows waking
> tasks to preempt tasks that have exceeded their cap.
>

But among all tasks that exceed their cap (there is no priority based
scheduling). As far as preemption is concerned, if they are moved to
the expired array, capped tasks will only run if an array switch takes
place. If it does, then they get their fare share of the cap again
until they exceed their cap.

Balbir
