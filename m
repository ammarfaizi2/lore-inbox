Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVAYONw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVAYONw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVAYONu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:13:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64411 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261951AbVAYOMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:12:44 -0500
Date: Tue, 25 Jan 2005 15:12:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125141231.GA19539@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <41F5E727.4000208@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F5E727.4000208@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > This is a far better idea from an API perspective.  We can continue
> > writing to the POSIX realtime standard interfaces.  Yet users can
> > actually take advantage of them.  I like it.
> 
> This still doesn't solve your privlige problem though. If I can't
> renice something as a regular user, it makes no sense to allow such
> realtime behaviour.
> 
> I still think the ulimit patches aren't a bad idea to solve your
> privilege problem. At that point, is there still a need for
> rt_cpu_limit?

i do believe it is not robust to give unprivileged users RT priorities,
without safeguards installed. Most normal desktops have some sort of
audio playback capability, so this problem needs a robust, API-neutral
and configurable/flexible solution.

RT-LSM and rlimit privileges are configurable, API-neutral but not
robust, while rt_cpu_limit is robust but not flexible. SCHED_ISO meets
all those needs.

there's a fourth option which is simpler than SCHED_ISO: in the previous
mail i've announced the RLIMIT_RT_CPU_RATIO feature, which should meet
all these requirements as well: the security and API ease-of-use of
rt_cpu_limit, and the maximum flexibility of rlimits. (It also has the
extra bonus of enabling the tweaking/securing of existing RT classes,
which SCHED_ISO doesnt do.)

	Ingo
