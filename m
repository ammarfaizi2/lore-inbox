Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUIBFfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUIBFfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUIBFfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:35:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49074 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267460AbUIBFfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:35:42 -0400
Date: Thu, 2 Sep 2004 07:37:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040902053719.GA12684@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu> <20040901135122.GA18708@elte.hu> <41367E5D.3040605@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41367E5D.3040605@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> This is an interesting one. ~3.9ms generated here by amlat in do_IRQ:

the overhead is not in do_IRQ():

> 00000001 0.000ms (+0.000ms): n_tty_receive_buf (pty_write)
> 00010001 3.992ms (+3.992ms): do_IRQ (n_tty_receive_buf)

the overhead is always relative to the previous entry - so the overhead
was in n_tty_receive_buf() [that is the function that was interrupted by
do_IRQ()]. But it's a bit weird - you should have gotten timer IRQs
every 1 msec. Does n_tty_receive_buf() run with irqs disabled perhaps?

	Ingo
