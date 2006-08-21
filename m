Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWHUSYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWHUSYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHUSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:24:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:53973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751187AbWHUSYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:24:45 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 0/7] CPU controller - V1
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060821164553.GA21130@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <1156156960.7772.38.camel@Homer.simpson.net>
	 <20060821124830.GB14291@in.ibm.com>
	 <1156180241.6582.69.camel@Homer.simpson.net>
	 <20060821164553.GA21130@in.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 20:33:08 +0000
Message-Id: <1156192388.6665.29.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 22:15 +0530, Srivatsa Vaddagiri wrote:

> Hence task_rq(awakening)->curr == current, which should be sufficient to 

Ah, ok.  Thanks.  I should have read more of the code instead of
pondering the text.

> resched(current), although I think there is a bug in current code 
> (irrespective of these patches):
> 
> try_to_wake_up() :
> 	
> 	...
> 
>         if (!sync || cpu != this_cpu) {
>                 if (TASK_PREEMPTS_CURR(p, rq))
>                         resched_task(rq->curr);
>         }
>         success = 1;
> 
> 	...
> 
> TASK_PREEMPTS_CURR() is examined and resched_task() is called only if 
> (cpu != this_cpu). What about the case (cpu == this_cpu) - who will
> call resched_task() on current? I had expected the back-end of interrupt
> handling to do that, but didnt find any code to do so.

Looks ok to me.  Everything except sync && cpu == this_cpu checks.

	-Mike

