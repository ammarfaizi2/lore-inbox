Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVFKNga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVFKNga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 09:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVFKNga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 09:36:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10628 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261700AbVFKNg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 09:36:26 -0400
Date: Sat, 11 Jun 2005 15:32:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption, using msecs_to_jiffies() instead of HZ
Message-ID: <20050611133246.GA29414@elte.hu>
References: <42A9C2E0.30002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A9C2E0.30002@gmail.com>
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


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> I was looking at kernel/softlookup.c when I noticed you used HZ in order to get
> a 10-second delay:
> 
> void softlockup_tick(struct pt_regs *regs)
> {
> 	...
> 	if (time_after(jiffies, timestamp + 10*HZ)) {
> 	...
> }

oops, indeed. (i've also forwarded your patch to akpm, as the softlockup 
patch is included in -mm too)

> I created this small patch (built against version 
> 2.6.12-rc6-V0.7.48-05) which does use of msecs_to_jiffies() to get a 
> correct behaviour with every platform. Similarly I modified function 
> watchdog and kernel/irq/autoprobe.c file (probe_irq_on function).
> 
> Here is the patch:

> ++	msleep(msecs_to_jiffies(20));
> ++	msleep(msecs_to_jiffies(100));
> ++		msleep_interruptible(msecs_to_jiffies(1000));

actually, this should be msleep(20/100/1000). I've fixed these in my 
tree.

	Ingo
