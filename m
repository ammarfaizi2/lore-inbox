Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVAQKHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVAQKHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAQKHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:07:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24963 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262378AbVAQKHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:07:06 -0500
Date: Mon, 17 Jan 2005 11:06:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050117100633.GA3311@elte.hu>
References: <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vf9xdj18.fsf@sulphur.joq.us>
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

> Is it possible to call sched_setscheduler() with a thread ID instead
> of a pid?  That's what I really need.  JACK sets and resets the thread
> priorities from a different thread.

yes. The PID arguments in these APIs are all treated as 'TIDs'. One day
the APIs themselves might switch over to what POSIX specifies, and there
will be new, thread-specific APIs - but at the moment they are all
thread-granular.

(If then this switchover will happen in a controlled manner via glibc,
not via the kernel. I.e. kernel will introduce new syscalls to do the
per-process priority changing, then newest glibc will utilize it - i.e.
already existing apps will stay compatible.)

	Ingo
