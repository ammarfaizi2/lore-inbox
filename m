Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVBBQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVBBQoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVBBQoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:44:21 -0500
Received: from mail.joq.us ([67.65.12.105]:50066 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262613AbVBBQnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:43:40 -0500
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	<20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu>
	<873bwfo8br.fsf@sulphur.joq.us>
	<20050202111045.GA12155@nietzsche.lynx.com>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 10:44:22 -0600
In-Reply-To: <20050202111045.GA12155@nietzsche.lynx.com> (Bill Huey's
 message of "Wed, 2 Feb 2005 03:10:45 -0800")
Message-ID: <87is5ahpy1.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) <bhuey@lnxw.com> writes:

> Also, as media apps get more sophisticated they're going to need some
> kind of access to the some traditional softirq facilities, possibily
> migrating it into userspace safely somehow, with how it handles IO
> processing such as iSCSI, FireWire, networking and all peripherals
> that need some kind of prioritized IO handling. It's akin to O_DIRECT,
> where folks need to determine policy over the kernel's own facilities,
> IO queues, but in a more broad way. This is inevitable for these
> category of apps. Scary ? yes I know.

I believe Ingo's RT patches already support this on a per-IRQ basis.
Each IRQ handler can run in a realtime thread with priority assigned
by the sysadmin.  Balancing the interrupt handler priorities with
those of other realtime activities allows excellent control.  

This is really only useful within the context of a dedicated realtime
system, of course.

Stephane Letz reports a similar feature in Mac OS X.

> Whether this suitable for main stream inclusion is another matter. But
> as a person that wants to write apps of this nature, I came into this
> kernel stuff knowing that there's going to be a conflict between the
> the needs of media apps folks and what the Linux kernel folks will
> tolerate as a community.

That's a price both groups pay for doing realtime within the context
of a general-purpose OS.  But, for many, many applications it's the
best option.

Fortunately, most of what we need also improves the general quality
and responsiveness of the kernel.  The important things like short
lock hold times are really just good concurrent programming practice.

>> The cost/performance characteristics of commodity PC's running Linux
>> are quite compelling for a wide range of practical realtime
>> applications.  But, these are dedicated machines.  The whole system
>> must be carefully tuned.  That is the only method that actually works.
>> The scheduler is at most a peripheral concern; the best it can do is
>> not screw up.
>
> It's very compelling and very deadly to the industry if these things
> become common place in the normal Linux kernel. It would instantly
> make Linux the top platform for anything media related, graphic and
> audio.

Yes, many people want to take advantage of this.
-- 
  joq
