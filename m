Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVAUIVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVAUIVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAUIVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:21:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:65208 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262041AbVAUIVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:21:35 -0500
Date: Fri, 21 Jan 2005 09:21:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
Message-ID: <20050121082125.GA28267@elte.hu>
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F0BA56.9000605@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> > how about the patch below? One of the important benefits of the 
> > threaded timer IRQ is the ability to make xtime_lock a mutex.
> 
> The problem is that that removes the
> 	cur_timer->mark_offset();
> 	do_timer(regs);
> in time. [...]

i'm not sure i understand what you mean. My change does:

| @@ -294,6 +313,7 @@ irqreturn_t timer_interrupt(int irq, voi
|         write_seqlock(&xtime_lock);
|
|         cur_timer->mark_offset();
| +       do_timer(regs);
|
|         do_timer_interrupt(irq, NULL, regs);

so ->mark_offset and do_timer() go together, and happen under
xtime_lock. What problem is there if we do this?

	Ingo
