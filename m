Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVASIea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVASIea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVASIeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:34:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43456 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261673AbVASIYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:24:51 -0500
Date: Wed, 19 Jan 2005 09:24:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050119082433.GE29037@elte.hu>
References: <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu> <87pt02pt0r.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pt02pt0r.fsf@sulphur.joq.us>
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

> Adding a tid field is relatively easy.  Fixing the race condition
> between setting it in the new thread and using it in the creating
> thread is harder, but not impossible.  But, even setting it in the new
> thread would create an incompatible interface.  With hundreds of JACK
> client applications, binary compatibility is a serious consideration.

i'm not suggesting that this is the way to go, it's just to test how
nice--20 tasks would perform (on the hacked kernel). We still dont have
this data, because in the other tests you tried, some non-highprio
threads got nice--20 priority as well, which can (and apparently do)
interfere with the highprio threads.

is it possible to call a function from the highprio-threads (and only
from them) themselves, during the setup of those threads? If this is
possible then all you need to add is a nice(-20); function call, which
only affects the current thread. (you dont have to know the TID or PID
and dont have to extend any Jack APIs and structures for this hack.)

('highprio threads' are the ones that normally get SCHED_FIFO priority
with -R, 'lowprio threads' are the other client-side threads, if any.)

	Ingo
