Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVFQLTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVFQLTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 07:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVFQLTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 07:19:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26078 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261949AbVFQLTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 07:19:06 -0400
Date: Fri, 17 Jun 2005 13:18:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050617111822.GA28236@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <42B1BDF7.1000700@cybsft.com> <20050616204358.GA4656@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616204358.GA4656@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > There doesn't seem to be any actual lockups, just messages. I will try 
> > disabling the above when I get home this evening. Can't get to the 
> > system right now.
> 
> i tweaked the softlockup detector in the last patch a bit (to fix 
> false positives under very high loads), might have broken it on SMP.

yeah - found a bug that could explain the symptoms on your system.  
Called softlockup_tick() from the global timer interrupt, instead of the 
per-CPU timer interrupt. So on SMP the other CPUs would not see any 
softlockup ticks at all, and would incorrectly report soft lockups.  
This bug is fixed in the -48-36 patch i just uploaded.

	Ingo
