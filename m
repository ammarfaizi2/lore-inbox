Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVARIEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVARIEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVARIEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:04:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41104 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261172AbVARICj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:02:39 -0500
Date: Tue, 18 Jan 2005 09:02:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050118080218.GB615@elte.hu>
References: <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llaruy6m.fsf@sulphur.joq.us>
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

> In the absence of any documentation, I'm guessing about storing the
> nice value in the priority field of the sched_param struct.  But, I
> have not been able to figure out how to make that work.

the call you need is:

       setpriority(PRIO_PROCESS, tid, -20);

where 'tid' is the TID (pid) of the thread in question. There's no way i
know of to utilize the pthread_t ID to do this, so you'll have to figure
the TID out via gettid() - which needs to happen in the child context -
how hard would it be to attach the TID field to some per-thread Jack
structure? [while the purpose is still a quick hack.]

	Ingo
