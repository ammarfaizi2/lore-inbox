Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVAYWTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVAYWTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVAYWRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:17:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6851 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262206AbVAYWIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:08:31 -0500
Date: Tue, 25 Jan 2005 23:08:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125220814.GA11331@elte.hu>
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <20050125135508.A24171@build.pdx.osdl.net> <20050125215758.GA10811@elte.hu> <20050125140302.C24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125140302.C24171@build.pdx.osdl.net>
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


* Chris Wright <chrisw@osdl.org> wrote:

> > did that thread go into technical details? There are some rlimit users
> > that might not be prepared to see the rlimit change under them. The
> > RT_CPU_RATIO one ought to be safe, but generally i'm not so sure.
> 
> Not really.  I mentioned the above, as well as the security concern.
> Right now, at least the task_setrlimit hook would have to change to
> take into account the task.  And I never convinced myself that async
> changes would be safe for each rlimit.

e.g. the stack rlimit looks dangerous, if any VM codepath ever looks
twice on it (and relies on it being the same, somehow).

But if someone reviewed all of the rlimit use in the kernel, we could
make it a policy that rlimits might change. Any unsafe use could be made
safe pretty easily. Since they are ulongs they are updated atomically
even without any locking - but e.g. the default and the hard limit might
change separately. (from the viewpoint of rlimit-using kernel code.)

obviously a remote rlimit must listen to same kind of security
permissions as e.g. ptrace or signal sending.

	Ingo
