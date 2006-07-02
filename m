Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWGBNl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWGBNl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGBNl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:41:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:25728 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751420AbWGBNl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:41:57 -0400
Date: Sun, 2 Jul 2006 15:37:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] i386: clean up user_mode() use
Message-ID: <20060702133718.GA27549@elte.hu>
References: <44A7BE17.23657.2D6F894E@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A7BE17.23657.2D6F894E@pageexec.freemail.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> on i386 there're two macros used for testing the userland execution 
> mode: user_mode() and user_mode_vm(), which is not intuitive as on 
> many (all?) other architectures there's only user_mode() and 
> architecture independent code is written with user_mode() only, and 
> even on i386 someone can make the wrong assumption that user_mode() 
> works as it does on other archs.
> 
> two cases in point: 
> drivers/oprofile/cpu_buffer.c:oprofile_add_sample() uses user_mode() 
> which can lead to incorrect results if the interrupted task was in v86 
> mode with a code segment fooling the user_mode() selector RPL check. 
> also, arch/i386/kernel/kprobes.c:kprobe_exceptions_notify() used to 
> use user_mode() whereas it really meant user_mode_vm(), this is in 
> fact incorrect until 2.6.17.
> 
> to avoid such mistakes in the future, the suggested solution is to 
> make user_mode() on i386 consistent with the generic expectation and 
> make it detect any user mode execution context, that is, it should 
> take the role of user_mode_vm() and a new user_mode_novm() is 
> introduced for the i386 specific cases where v86 mode can be excluded. 
> in short, the patch simply does a
> 
>   user_mode_vm -> user_mode
>   user_mode    -> user_mode_novm
> 
> substitution as appropriate.
> 
> Signed-off-by: PaX Team <pageexec@freemail.hu>

agreed!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
