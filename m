Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbWCFJPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbWCFJPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbWCFJPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:15:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:16853 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752325AbWCFJPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:15:41 -0500
Date: Mon, 6 Mar 2006 10:14:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060306091429.GA9330@elte.hu>
References: <20060304121723.19fe9b4b.akpm@osdl.org> <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org> <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org> <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org> <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> @@ -4028,6 +4028,8 @@ static inline void __cond_resched(void)
>  	 */
>  	if (unlikely(preempt_count()))
>  		return;
> +	if (unlikely(system_state != SYSTEM_RUNNING))
> +		return;

we used to have this, but it was frowned upon during the initial lkml 
review of -VP so i fixed all the known 'early bootup scheduling 
assumptions' and removed this condition .. but that was a losing battle 
i suspect. In any case, i fully agree with your fix. We also need this 
fix for v2.6.16.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
