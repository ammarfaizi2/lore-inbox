Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVA0AZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVA0AZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVA0AYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:24:19 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:16821 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262517AbVAZX3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:29:43 -0500
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <87fz0neshg.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	 <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	 <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu>
	 <87fz0neshg.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 10:29:25 +1100
Message-Id: <1106782165.5158.15.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 16:27 -0600, Jack O'Quin wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> >  - exported the current RT-average value to /proc/stat (it's the last 
> >    field in the cpu lines)
> 
> > e.g. the issue Con and others raised: privileged tasks. By default, the
> > root user will likely have a 0 rlimit, for compatibility. _But_ i can
> > easily imagine users wanting to put in a safety limit even for
> > root-owned RT tasks by making the rlimit 98% or so. Nonprivileged users
> > would have this rlimit at say 20% in a typical desktop distribution.
> 
> That seems rather small.  CPU starvation is not generally much of a
> problem on desktop machines.  If that (single) user wants to eat up
> 70% or 80% of the CPU, that's not likely to be a problem.  Mac OS X
> allows 90% on their desktop systems.
> 

Just a bit off the topic of this sub-thread...

I'm a bit concerned about this kind of policy and breakage of
userspace APIs going into the kernel. I mean, if an app is
succeeds in gaining SCHED_FIFO / SCHED_RR scheduling, and the
scheduler does something else, that could be undesirable in some
situations.

Secondly, I think we should agree upon and get the basic rlimit
support in ASAP, so the userspace aspect can be firmed up a bit
for people like Paul and Jack (this wouldn't preclude further
work from happening in the scheduler afterwards).

And finally, with rlimit support, is there any reason why lockup
detection and correction can't go into userspace? Even RT
throttling could probably be done in a userspace daemon.

Nick



