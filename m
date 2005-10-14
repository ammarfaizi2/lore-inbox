Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVJNIwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVJNIwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 04:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJNIwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 04:52:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:8854 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751211AbVJNIwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 04:52:54 -0400
Date: Fri, 14 Oct 2005 10:53:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014085321.GA23124@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu> <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu> <1129242595.4623.14.camel@cmn3.stanford.edu> <1129256936.11036.4.camel@cmn3.stanford.edu> <20051014045615.GC13595@elte.hu> <20051014061546.GA30319@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014061546.GA30319@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > could you try:
> > 
> > 	strace -o log sleep 10
> > 
> > and wait for a failure, and send us the log? Is it perhaps nanosleep 
> > unexpectedly returning with -EAGAIN or -512? There's a transient 
> > nanosleep failure that happens on really fast boxes, which we havent 
> > gotten to the bottom yet. That problem is very sporadic, but maybe 
> > your box is just too fast and triggers it more likely :-)
> 
> is nanosleep returning -ERESTART_RESTARTBLOCK (-516) perhaps?

ok, i fixed the -ERESTART_RESTARTBLOCK bug that fast systems were 
exhibiting. But this bug is limited to HIGH_RES_TIMERS kernels, so it 
cannot explain your problems i think.

in any case, could you try the -rc4-rt3 patch i just uploaded - it also 
includes more ktimer debugging code, perhaps one of them triggers on 
your box.

	Ingo
