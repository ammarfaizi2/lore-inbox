Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbRFLIlK>; Tue, 12 Jun 2001 04:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264273AbRFLIlA>; Tue, 12 Jun 2001 04:41:00 -0400
Received: from [194.213.32.142] ([194.213.32.142]:8196 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264260AbRFLIkq>;
	Tue, 12 Jun 2001 04:40:46 -0400
Message-ID: <20010611235846.B130@bug.ucw.cz>
Date: Mon, 11 Jun 2001 23:58:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: softirq bugs in pre2
In-Reply-To: <20010611193703.S5468@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010611193703.S5468@athlon.random>; from Andrea Arcangeli on Mon, Jun 11, 2001 at 07:37:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -urN 2.4.4/include/linux/condsched.h lowlat/include/linux/condsched.h
> --- 2.4.4/include/linux/condsched.h	Thu Jan  1 01:00:00 1970
> +++ lowlat/include/linux/condsched.h	Sun Apr 29 18:33:13 2001
> @@ -0,0 +1,14 @@
> +#ifndef _LINUX_CONDSCHED_H
> +#define _LINUX_CONDSCHED_H
> +
> +#ifndef __ASSEMBLY__
> +#define conditional_schedule() \
> +do { \
> +	if (current->need_resched) { \
> +		current->state = TASK_RUNNING; \
> +		schedule(); \
> +	} \
> +} while(0)
> +#endif
> +
> +#endif

I do not think that conditional schedule is worth its own header
file. I see you want to potentiatlly replace it with assembly, but
can't that be done in, say, system.h too? [Ok, you'd have to create
linux/system.h, but that can be called cleanup.]
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
