Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUISUqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUISUqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUISUqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:46:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61843 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263818AbUISUqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:46:51 -0400
Date: Sun, 19 Sep 2004 22:48:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040919204841.GA7004@elte.hu>
References: <200409192232.20139.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409192232.20139.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Just 1 small correction:
> >>>>
> --- kernel/time.c~      2004-09-19 15:09:38.000000000 +0200
> +++ kernel/time.c       2004-09-19 17:02:35.000000000 +0200
> @@ -96,8 +96,10 @@
>  asmlinkage long sys_gettimeofday(struct timeval __user *tv, struct timezone 
> __user *tz)
>  {
>  #ifdef CONFIG_LATENCY_TRACE
> -       if (!tv && ((long)tz == 1))
> +       if (!tv && ((long)tz == 1)) {
>                 user_trace_start();
> +               tz = NULL;
> +       }
>         if (!tv && !tz)
>                 user_trace_stop();

The point is to let gettimeofday(0,1) start tracing and
gettimeofday(0,0) stop tracing - a system-call-controlled tracing
facility (if trace_enabled=2). This was used to trace weird latencies
before, but it's not the normal mode of operation.

	Ingo
