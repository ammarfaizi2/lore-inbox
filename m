Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbUKVWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUKVWPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKVWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:14:22 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:23049 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262408AbUKVWLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:11:11 -0500
Message-ID: <41A263DF.2040907@stud.feec.vutbr.cz>
Date: Mon, 22 Nov 2004 23:10:39 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT x86 assembly question
References: <200411201746.44804@sercond.localdomain>
In-Reply-To: <200411201746.44804@sercond.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita V. Youshchenko wrote:
> In arch/i386/kernel/entry.S
> 
> ...
> ENTRY(resume_kernel)
>  cmpl $0,TI_preempt_count(%ebp) # non-zero preempt_count ?
>  jnz restore_all
> need_resched:
>  movl TI_flags(%ebp), %ecx # need_resched set ?
>  testb $_TIF_NEED_RESCHED, %cl
>  jz restore_all
>  testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
>  jz restore_all
>  movl $PREEMPT_ACTIVE,TI_preempt_count(%ebp)
>  sti
>  call schedule
>  movl $0,TI_preempt_count(%ebp)
>  cli
>  jmp need_resched
> #endif
> ...
> 
> Why, after return from schedule(), first 0 is written to 
> TI_preempt_count(%ebp), and only then interrupts are disabled?
> Wht not the reverse order?
> 

It's already reversed in linux-2.6.10-rc2:
  ...
  call schedule
  cli
  movl $0,TI_preempt_count(%ebp)
  jmp need_resched

Michal
