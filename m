Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282824AbRK0Gkl>; Tue, 27 Nov 2001 01:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRK0Gk3>; Tue, 27 Nov 2001 01:40:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:40201 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282824AbRK0GkV>;
	Tue, 27 Nov 2001 01:40:21 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011126232515.V730@lynx.no>
In-Reply-To: <1006831902.842.0.camel@phantasy>  <20011126232515.V730@lynx.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 01:40:48 -0500
Message-Id: <1006843248.971.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 01:25, Andreas Dilger wrote:
> On Nov 26, 2001  22:31 -0500, Robert Love wrote:
> > Reading and writing /proc/<pid>/affinity will get and set the affinity.
> > 
> > Security is implemented: the writer must possess CAP_SYS_NICE or be the
> > same uid as the task in question.  Anyone can read the data.
> 
> Hmm, now that I think about it, anyone should be able to restrict the
> CPUs that their processes should run on, but like "nice", you should
> have CAP_SYS_NICE in order to increase the number of CPUs your process
> can run on.  This makes it possible to "throttle" a user so that they
> can only max out a single CPU.
> 
> Why would you do that?  Maybe because "ulimit" and friends only allow
> you to set an absolute limit on the number of CPU seconds you can use
> per process, but not a "percentage" of a processor or some equivalent
> "cycles per second" unit.
> 
> Not that I see this as being hugely necessary, but it may as well be
> consistent with current behaviour (c.f. nice, ulimit, etc, can all go
> down, but not necessarily up).

I thought about this too, and I realized that cpus_allowed is by default
0xffffffff (i.e., all procs in the system).  That means this is only an
issue when the administrator explicitly changed affinity.

And that would occur in the situation you describe ... personally, I
think users should be able to set their masks but I completely see your
argument.

I suppose we could count the bits in cpus_allowed and make sure they are
less than or equal to the new_mask bits.  This seems overkill, though. 
We could just not allow users to change their own affinity without
CAP_SYS_NICE, and allow root to do anything (via CAP_SYS_ADMIN).

Anyone else have an opinion?

	Robert Love

