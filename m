Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268130AbTCFRBw>; Thu, 6 Mar 2003 12:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268137AbTCFRBw>; Thu, 6 Mar 2003 12:01:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47026 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268140AbTCFRBt>;
	Thu, 6 Mar 2003 12:01:49 -0500
Date: Thu, 6 Mar 2003 18:11:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060842270.7206-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> See, the thing is, I don't actually believe that X is _special_ in this
> regard.

X is special. Especially in Andrew's wild-window-dragging experiment X is
a pure CPU-bound task that just eats CPU cycles no end. There _only_ thing
that makes it special is that there's a human looking at the output of the
X client. This is information that is simply not available to the kernel.

Windows solves this problem by giving the application that owns 'the
foreground window' a special boost - they have the window manager in the
kernel after all. I do not like this approach, i could very well depend on
an application's latency that is not directly connected to the foreground
task.

the only thing that is more or less a good sign of humans being involved,
is delay. It's not always the case, but _most_ of the time, when a human
is involved, there's lots of sleep time. The 2.4 scheduler kind of
rewarded tasks based on this, the 2.5 scheduler does this more
prominently.

now which are those tasks that are CPU-bound but still have a human eye
looking at them most of the time? The two main ones are games and video
playback. Games tend to be CPU hogs for natural reasons, and video
playback is something that is CPU-intensive but non-smooth output is still
easily noticed by humans.

note that there isnt all that much problem with any but these two
categories.

and for those two categories, we have to give up and just help the kernel
a bit. We have to tell the kernel that there's a human looking at the
output of these applications. One plan that i think might work would be to
enable users to raise priority of applications by 2 or 3 priority levels,
which the kernel would allow. If the interface only allows such priority
setting for the current process, and if it's not inherited across fork(),
then at least initially, it would be harder to abuse this mechanism for a
'boost all of my processes' tool in .bashrc.

another experiment (a really bad hack) was to do the boost in iopl() -
recognizing the fact that if an application uses iopl(), it's privileged
and it's special. This of course unacceptable, but it isolated X and a
couple of other 'important' apps. It doesnt solve the 'xine problem'.

	Ingo

