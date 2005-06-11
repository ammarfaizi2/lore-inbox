Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFKHl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFKHl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFKHl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:41:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11479 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261155AbVFKHlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:41:21 -0400
Date: Sat, 11 Jun 2005 09:32:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050611073208.GA8279@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42A8B390.2060400@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8B390.2060400@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Hi Ingo,
> 
> Since the introduction of the delayed preemption feature in V0.7.47-20 
> my KDE desktop has been jerky. The sound from artsd often skips. The 
> mouse pointer jumps when I compile anything the background and try to 
> browse the web with Firefox.

yeah.

> I think that try_to_wake_up is broken for the !sync case. We have:
> 
> 		__activate_task(p, rq);
>                 if (TASK_PREEMPTS_CURR(p, rq)) {
>                         if (sync)
>                                 set_tsk_need_resched_delayed(rq->curr);
>                         else
>                                 resched_task(rq->curr);
>                 }
> 
> Shouldn't we call the full activate_task(...) instead of 
> __activate_task(...) in the !sync case?

indeed.

> The attached patch fixes seems to fix it for me. It is against 
> V0.7.48-05.

thanks, applied - but this does not end all of the reschedule problems 
that the latest patches have. More on that later.

	Ingo
