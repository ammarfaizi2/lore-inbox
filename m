Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVATIGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVATIGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVATIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:06:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24487 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262070AbVATIGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:06:18 -0500
Date: Thu, 20 Jan 2005 09:05:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050120080545.GA12665@elte.hu>
References: <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu> <87pt02pt0r.fsf@sulphur.joq.us> <20050119082433.GE29037@elte.hu> <20050119143927.GA11950@elte.hu> <87651tmhwv.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87651tmhwv.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> JACK actually uses three different priorities, the defaults are 9, 10
> and 20.  How about if I change this test?
> 
> 	if (prio <= 20 && policy != SCHED_NORMAL) {

yeah, this is OK. 20 is used for the watchdog thread, right? (so it has
minimal latency impact). What's the difference between prio 9 and 10
threads? You might want to map prio 9 ones to nice--15 and prio 10 ones
to nice--20, if there's a real difference between them. But for the
first test i'd suggest to use nice--20 for both. (to make sure
SCHED_OTHER tasks interfere as rarely as possible.)

> Or, should that be?
> 
> 	if (prio > 0 && prio <= 20 && policy != SCHED_NORMAL) {

'prio' cannot get negative here, so the first test is just as fine.

	Ingo
