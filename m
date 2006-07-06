Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWGFPUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWGFPUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWGFPUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:20:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:10774 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030324AbWGFPUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:20:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=syv5EukLjNNw+xWVzG+8oAjM61GyOVSL+TGKajrFXO+bTkB9VpuC05Y3OjXVWe0iSLj4mMtwOGgziUuDcvP1x+Bg18wpM84uNuNYlzrC2etmxuYG++ewsnUaMzrKKoXskYPdspmIRszh9faQoazitUyLU7NskXRY8jbtUsmCF58=
Date: Thu, 6 Jul 2006 17:20:58 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: New PriorityInheritanceTest - bug in 2.6.17-rt7 confirmed
In-Reply-To: <20060706133238.GA13800@elte.hu>
Message-ID: <Pine.LNX.4.64.0607061720410.30970@localhost.localdomain>
References: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain>
 <1152189293.24611.146.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607061443050.30970@localhost.localdomain> <20060706133238.GA13800@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>
>> It can run within try_to_wake_up(). But then it the whole lock chain
>> is traversed in an atomic section. That unpredictable overall system
>> latencies since the locks can be in userspace. So it has to run in
>> some task. That task has to be high priority enough to preempt the
>> boosted tasks, but it can't be so high priority that it bothers any
>> higher priority threads than those involved in this. So it can't be,
>> forinstance a general priority 99 task we just use for this. We thus
>> need something running at a slightly higher priority than the priority
>> to which the tasks are boosted, but not a full +1 priority. I.e. we
>> need to run it at priority "+0.5".
>
> we could just queue the task in front of the other task in the runqueue,
> and mark that task for reschedule if it's running currently. (Doing this
> is not without precedent: we do something similar in wake_up_new_task()
> to implement child-runs-first logic.)
>
I think that is more or less what my patch does...

Esben

> 	Ingo
>
