Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVHAV0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVHAV0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVHAVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:23:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57513 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261252AbVHAVXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:23:10 -0400
Date: Mon, 1 Aug 2005 23:23:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050801212353.GA22805@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122920564.6759.15.camel@localhost.localdomain> <20050801205208.GA20731@elte.hu> <1122930932.6759.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122930932.6759.42.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > here's the patch below. Could you try to revert it?
> 
> Thanks Ingo.
> 
> If Daniel was trying to detect soft lock ups of lower priority tasks 
> (tasks that block all tasks lower than itself), I've added a counter 
> to Daniels patch to keep from showing this for the one time case.  
> This doesn't spit anything out for me anymore.  But I guess this could 
> detect a higher priority task blocking lower ones, as long as higher 
> tasks don't run often (thus reseting the count).

thanks. In -52-09 i've unapplied the original patch, and i've now 
uploaded -52-10 with Daniel's original patch plus your patch applied.

I think 10 seconds is pretty reasonable - if an RT task runs 
uninterrupted for that long time i think we want to know about it. It's 
not illegal for an RT task to monopolize the CPU for that long, but it's 
certainly unusual enough to warn about. (and the warning can be turned 
off)

	Ingo
