Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVBKReX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVBKReX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVBKRbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:31:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46055 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262300AbVBKRad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:30:33 -0500
Date: Fri, 11 Feb 2005 18:30:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt starvation points
Message-ID: <20050211173025.GA17387@elte.hu>
References: <1108141521.21940.44.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108141521.21940.44.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

>         I found some points during schedule when interrupts are off
> for long periods . These two patches seem to help. One enables
> interrupts inside schedule() , so that interrupts are enabled after
> each need-resched loop, then disabled again before __schedule() is
> called. 
> 
>         The other patch enabled interrupt before calling up on
> kernel_sem ..This one could use some thinking over. I did this cause
> up() is very expensive on ARM , and combined with the looping above
> interrupts can stay off for a long time .. 

i'm wondering what the best approach would be. Right now if
DIRECT_PREEMPT is enabled [it's disabled currently] and a higher-prio
task has been woken up we switch to it without ever enabling interrupts
again. Re-enabling interrupts during schedule() will reduce irq
latencies but will lengthen critical sections.

	Ingo
