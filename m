Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUEKU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUEKU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUEKUZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:25:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32157 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263607AbUEKUZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:25:42 -0400
Date: Tue, 11 May 2004 22:26:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-ID: <20040511202657.GA5900@elte.hu>
References: <409FFF3B.3090506@linux.intel.com> <20040511004551.7c7af44d.akpm@osdl.org> <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com> <20040511121126.73f5fdeb.akpm@osdl.org> <20040511195856.GA4958@elte.hu> <20040511131137.2390ffa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511131137.2390ffa8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ah, OK, the timer handler may re-add itself.  Really, that's a bug in
> the caller: once they've decided to shoot down the timer the caller
> should have made state changes which prevent the handler from
> re-adding the timer.
> 
> Still, too late to change that.

yeah.

> Neither AIO nor schedule_timeout() actually re-add the timer so they
> don't need the full treatment, yes?

correct.

> +int del_single_shot_timer(struct timer_struct *timer)
> +{
> +	if (del_timer(timer))
> +		del_timer_sync(timer);
> +}

cool, this looks good to me. It's obviously correct and has a limited
scope. (I'd suggest another name though: del_timer_singleshot(). This i
think fits into the existing naming better: del_timer() and
del_timer_sync(). But no strong feelings either way.)

	Ingo
