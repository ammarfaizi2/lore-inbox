Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVCWAAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVCWAAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCWAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:00:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64906 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262499AbVCVX6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:58:14 -0500
Subject: Re: kernel bug: futex_wait hang
From: Lee Revell <rlrevell@joe-job.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Chris Morgan <cmorgan@alum.wpi.edu>, paul@linuxaudiosystems.com,
       seto.hidetoshi@jp.fujitsu.com
In-Reply-To: <20050322063405.GN32746@devserv.devel.redhat.com>
References: <1111463950.3058.20.camel@mindpipe>
	 <20050321202051.2796660e.akpm@osdl.org>
	 <20050322044838.GB32432@mail.shareable.org>
	 <20050321210802.14be70cc.akpm@osdl.org> <1111469453.3563.0.camel@mindpipe>
	 <20050322063405.GN32746@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 18:58:06 -0500
Message-Id: <1111535887.4691.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 01:34 -0500, Jakub Jelinek wrote:
> On Tue, Mar 22, 2005 at 12:30:53AM -0500, Lee Revell wrote:
> > On Mon, 2005-03-21 at 21:08 -0800, Andrew Morton wrote:
> > > Jamie Lokier <jamie@shareable.org> wrote:
> > > > 
> > > > The most recent messages under "Futex queue_me/get_user ordering",
> > > > with a patch from Jakub Jelinek will fix this problem by changing the
> > > > kernel.  Yes, you should apply Jakub's most recent patch, message-ID
> > > > "<20050318165326.GB32746@devserv.devel.redhat.com>".
> > > > 
> > > > I have not tested the patch, but it looks convincing.
> > > 
> > > OK, thanks.  Lee && Paul, that's at
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/futex-queue_me-get_user-ordering-fix.patch
> > > 
> > 
> > Does not fix the problem.
> 
> Have you analyzed the use of mutexes/condvars in the program?
> The primary suspect is a deadlock, race of some kind or other bug
> in the program.  All these will show up as a hang in FUTEX_WAIT.
> The argument that it works with LinuxThreads doesn't count,
> the timing and internals of both threading libraries are so different
> that a program bug can only show up with one of the threading libraries
> and not both.
> Only once you distill a minimal self-contained testcase that proves
> the program is correct and it gets analyzed, it is time to talk about
> NPTL or kernel bugs.

Paul is on vacation for a week so I suspect this will have to wait for
his return.  But he's been right about similar issues in the past so I'm
inclined to believe him.

In the meantime if anyone cares to investigate, the problem is trivial
to reproduce.  All you need is JACK, XMMS, xmms-jack and any 2.6 kernel.

Lee

