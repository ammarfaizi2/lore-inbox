Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFNOs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFNOs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFNOsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:48:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31948 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261258AbVFNOry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:47:54 -0400
Date: Tue, 14 Jun 2005 16:47:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] possible error in EXIT_DEAD transformation
Message-ID: <20050614144710.GA20228@elte.hu>
References: <20050614143213.GA2059@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614143213.GA2059@tsunami.ccur.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joe Korty <joe.korty@ccur.com> wrote:

> This assignment may have been missed, when TASK_DEAD was
> converted over to EXIT_DEAD.

> @@ -2664,7 +2664,7 @@ need_resched_nonpreemptible:
>  	spin_lock_irq(&rq->lock);
>  
>  	if (unlikely(prev->flags & PF_DEAD))
> -		prev->state = EXIT_DEAD;
> +		prev->exit_state = EXIT_DEAD;

no, here we set the dead task's state to EXIT_DEAD, so that it does not 
come back on the runqueue. Its ->exit_state is already EXIT_DEAD (or 
EXIT_ZOMBIE).

	Ingo
