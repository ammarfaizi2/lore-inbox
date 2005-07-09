Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVGIP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVGIP5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVGIP5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 11:57:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29336 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261543AbVGIP5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 11:57:32 -0400
Date: Sat, 9 Jul 2005 17:57:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709155704.GA14535@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709115817.GA4665@elte.hu> <200507091507.13215.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507091507.13215.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Okay, I'll send you the vmlinux from -18 with a new digital photo, and 
> config, with CONFIG_4KSTACKS enabled.

this crash too seems to indicate trigger_softirqs()/wakeup_softirqd().  
Somewhere we somehow corrupt the stack and e.g. in oops7.jpg we return 
to 00c011ed. Note that it's a right-shifted address that could be one of 
these:

 c011ed50 t wakeup_softirqd
 c011ed80 t trigger_softirqs

but it looks pretty weird. DEBUG_STACK_POISON (and the full-debug 
.config i sent) could perhaps uncover other types of stack corruptions.

	Ingo
