Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVAKWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVAKWLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKWJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:09:58 -0500
Received: from waste.org ([216.27.176.166]:42418 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262901AbVAKWHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:07:07 -0500
Date: Tue, 11 Jan 2005 14:05:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111220544.GZ2940@waste.org>
References: <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org> <1105479495.4295.61.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105479495.4295.61.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:38:14PM -0500, Lee Revell wrote:
> On Tue, 2005-01-11 at 13:28 -0800, Matt Mackall wrote:
> > But I'm also still not convinced this policy can't be most flexibly
> > handled by a setuid helper together with the mlock rlimit.
> 
> Quoting my message from a few days ago:
> 
> On Thu, 2005-01-06 at 17:18 -0800, Matt Mackall wrote:
> > Why can't this be done with a simple SUID helper to promote given
> > tasks to RT with sched_setschedule, doing essentially all the checks
> > this LSM is doing? 
> > 
> > Objections of "because it requires dangerous root or suid" don't fly,
> > an RT app under user control can DoS the box trivially. Never mind you
> > need root to configure the LSM anyway..
> 
> Yes but a bug in an app running as root can trash the filesystem.  The
> worst you can do with RT privileges is lock up the machine.

Yes. So can a bug in an LSM or in new rlimits code.

But bugs can be fixed. Poorly designed APIs cannot. That's why the
best API from the kernel perspective is no API: do it in userspace
wherever possible. Bring the kernel in only when the kernel can do it
better, more cleanly, and more generally. The rlimits-on-priorities
approach may qualify in that it might solve problems for other folks
(games on the desktop, CD burning, and the like) and isn't a bad fit
into the rest of the standard security model, but it's still got a
wart or two.

I suppose I ought to spell out my personal LSM bias while I'm at it:

- it invites ad-hoc extensions like this
- we have enough security issues without supporting a proliferation of
  incompatible security models

So while I think it's perfectly fine for people to kludge up things
like this, I don't think they belong in the tree unless they're _very_
generally applicable and _very_ well thought out. LSMs should not be
treated like drivers.

-- 
Mathematics is the supreme nostalgia of our time.
