Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVBBV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVBBV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVBBV5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:57:07 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:21418 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S262563AbVBBVyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:54:36 -0500
Message-ID: <42014C10.60407@bigpond.net.au>
Date: Thu, 03 Feb 2005 08:54:24 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: "Jack O'Quin" <joq@io.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com>
In-Reply-To: <20050202111045.GA12155@nietzsche.lynx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Tue, Feb 01, 2005 at 11:10:48PM -0600, Jack O'Quin wrote:
> 
>>Ingo Molnar <mingo@elte.hu> writes:
>>
>>>(also, believe me, this is not arrogance or some kind of game on our
>>>part. If there was a nice clean solution that solved your and others'
>>>problems equally well then it would already be in Linus' tree. But there
>>>is no such solution yet, at the moment. Moreover, the pure fact that so
>>>many patch proposals exist and none looks dominantly convincing shows
>>>that this is a problem area for which there are no easy solutions. We
>>>hate such moments just as much as you do, but they do happen.)
>>
>>The actual requirement is nowhere near as difficult as you imagine.
>>You and several others continue to view realtime in a multi-user
>>context.  That doesn't work.  No wonder you have no good solution.
> 
> 
> A notion of process/thread scoping is needed from my point of view. How
> to implement that is another matter and there are no clear solutions
> that don't involve major changes in some way to fundamental syscalls
> like fork/clone() and underlying kernel structures from what I see.
> The very notion of Unix fork semantics isn't sufficient enough to
> "contain" these semantics. It's more about controlling things with
> known quantities over time, not about process creation relationships,
> and therein lies the mismatch.
> 
> Also, as media apps get more sophisticated they're going to need some
> kind of access to the some traditional softirq facilities, possibily
> migrating it into userspace safely somehow, with how it handles IO
> processing such as iSCSI, FireWire, networking and all peripherals
> that need some kind of prioritized IO handling. It's akin to O_DIRECT,
> where folks need to determine policy over the kernel's own facilities,
> IO queues, but in a more broad way. This is inevitable for these
> category of apps. Scary ? yes I know.
> 
> Think XFS streaming with guaranteed rate IO, then generalize this for
> all things that can be streamed in the kernel. A side note, they'll
> also be pegging CPU usage and attempting to draw to the screen at the
> same time. It would be nice to have slack from scheduler frames be use
> for less critical things such as drawing to the screen.
> 
> The policy for scheduling these IO requests maybe divorced from the
> actual priority of the thread requesting it which present some problems
> with the current Linux code as I understand it.
> 
> Whether this suitable for main stream inclusion is another matter. But
> as a person that wants to write apps of this nature, I came into this
> kernel stuff knowing that there's going to be a conflict between the
> the needs of media apps folks and what the Linux kernel folks will
> tolerate as a community.
> 
> 
>>The humble RT-LSM was actually optimal for the multi-user scenario:
>>don't load it.  Then it adds no security issues, complexity or
>>scheduler pathlength.  As an added benefit, the sysadmin can easily
>>verify that it's not there.
>>
>>The cost/performance characteristics of commodity PC's running Linux
>>are quite compelling for a wide range of practical realtime
>>applications.  But, these are dedicated machines.  The whole system
>>must be carefully tuned.  That is the only method that actually works.
>>The scheduler is at most a peripheral concern; the best it can do is
>>not screw up.
> 
> 
> It's very compelling and very deadly to the industry if these things
> become common place in the normal Linux kernel. It would instantly
> make Linux the top platform for anything media related, graphic and
> audio. (Hopefully, I can get back to kernel coding RT stuff after this
> current distraction that has me reassigned onto an emergency project)
> 
> I hope I clarified some of this communication and not completely scare
> Ingo and others too much. Just a little bit is ok. :)

As Ingo said in an earlier a post, with a little ingenuity this problem 
can be solved in user space.  The programs in question can be setuid 
root so that they can set RT scheduling policy BUT have their 
permissions set so that they only executable by owner and group with the 
group set to a group that only contains those users that have permission 
to run this program in RT mode.  If you wish to allow other users to run 
the program but not in RT mode then you would need two copies of the 
program: one set up as above and the other with normal permissions.

It may be necessary for users that are members of this RT group to do a 
newgrp before running this program if it isn't their primary group.  But 
that could be done in a shell wrapper.

If you have the source code for the programs then they could be modified 
to drop the root euid after they've changed policy.  Or even do the 
group membership check inside the program and if the user that launches 
the program is not a member of the group drop root euid immediately on 
start up.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
