Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbUHPCWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUHPCWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUHPCWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:22:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64988 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267348AbUHPCV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:21:27 -0400
Date: Mon, 16 Aug 2004 04:22:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: maximilian attems <janitor@sternwelten.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kj <kernel-janitors@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Add msleep_interruptible() function to kernel/timer.c
Message-ID: <20040816022228.GA8224@elte.hu>
References: <20040815121805.GA15111@stro.at> <1092570891.17605.1.camel@localhost.localdomain> <20040815132548.GF1799@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815132548.GF1799@stro.at>
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


* maximilian attems <janitor@sternwelten.at> wrote:

> +/**
> + * msleep_interruptible - sleep waiting for waitqueue interruptions
> + * @msecs: Time in milliseconds to sleep for
> + */
> +unsigned int msleep_interruptible(unsigned int msecs)
> +{
> +       unsigned long timeout = msecs_to_jiffies(msecs);
> +
> +       while (timeout && !signal_pending(current)) {
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               timeout = schedule_timeout(timeout);
> +       }
> +       return jiffies_to_msecs(timeout);
> +}

looks good to me.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo

