Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVBBVZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVBBVZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVBBVV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:21:56 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:28172 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262328AbVBBVOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:14:34 -0500
Date: Wed, 2 Feb 2005 13:14:05 -0800
To: "Jack O'Quin" <joq@io.com>
Cc: Bill Huey <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202211405.GA13941@nietzsche.lynx.com>
References: <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is5ahpy1.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:44:22AM -0600, Jack O'Quin wrote:
> Bill Huey (hui) <bhuey@lnxw.com> writes:
> > Also, as media apps get more sophisticated they're going to need some
> > kind of access to the some traditional softirq facilities, possibily
> > migrating it into userspace safely somehow, with how it handles IO
> > processing such as iSCSI, FireWire, networking and all peripherals
> > that need some kind of prioritized IO handling. It's akin to O_DIRECT,
> > where folks need to determine policy over the kernel's own facilities,
> > IO queues, but in a more broad way. This is inevitable for these
> > category of apps. Scary ? yes I know.
> 
> I believe Ingo's RT patches already support this on a per-IRQ basis.
> Each IRQ handler can run in a realtime thread with priority assigned
> by the sysadmin.  Balancing the interrupt handler priorities with
> those of other realtime activities allows excellent control.  

No they don't. That's a physical mapping of these kernel entities, not a
logic organization that projects upward to things like individual sockets
or file streams. The current irq-thread patches are primarily for dealing
with the low level acks and stuff for the devices in question. It does not
deal with queuing policy or how these things are scheduler on a logical
basis, which is what softirqs do. softirqs group a number of things together
in one big uncontrollable chunk. Really, a bit of time spent in the kernel
regarding this would clarify it more in the future. Don't speculate.

This misunderstanding, often babble, from app folks is why kernel folks
partially dismiss the needs requested from this subgroup. It's important
to understand your needs before articulating it to a wider community.

The kernel community must understand the true nature of these needs and
then facilitate them. If the relationship is where kernel folks dictate
what apps folks have, you basically pervert the relationbship and the
responsiblities of overall development, which fatally cripples app
and all development of this nature. It's a two way street, but kernel
folks can be more proactive about it, definitely.

Step one in this is to acknowlege that Unix scheduling semantics is
"inantiquated" with regard to media apps. Some notion of scoping needs to
be put in.

Everybody on the same page ?

> This is really only useful within the context of a dedicated realtime
> system, of course.
> 
> Stephane Letz reports a similar feature in Mac OS X.

OS X is very coarse grained (two funnels) and I would seriously doubt
that it would perform without scheduling side effects to the overall
system because of that. With a largely stalled FreeBSD SMPng project
where they hijack a good chunk of their code into an antiquate and
bloated Mach threading system, that situation isn't helping it.

What the Linux community has with the RT patches is potentially light
years ahead of OS X regarding overall system latency, since RT and
SMP performance is tightly related. It's just a matter of getting 
right folks to understand the problem space and then make changes so
that the overall picture is completed.

bill

