Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVKOC3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVKOC3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVKOC3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:29:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18879 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932285AbVKOC3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:29:34 -0500
Date: Mon, 14 Nov 2005 20:29:31 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115022931.GB6343@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114175140.06c5493a.pj@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> Serge wrote:
> > But when one of the
> > processes looks for process 10, task_vpid_to_pid(current, 10) will return
> > the real pid for the vpid 10 in current's pidspace.
> 
> So a "kill -1 10" will mean different things, depending on the pidspace
> that the kill is running in.  And pid's passed about between user
> tasks as if they were usable system-wide are now aliased by their
> invisible pidspace.
> 
> Yuck.  Such virtualizations usually have a much harder time addressing
> the last 10% of situations than they did the easy 90%.

For simplicity, the only pids a process will see are those in its own
pidspace, and the only controls (I expect) will be the ability to start
a new pidspace, and request a pid.  So it is no more complicated than
the vserver model, where a process becomes pid 1 only for other proceses
in the same vserver, and process don't see processes in other vservers -
except that now every process in the pidspace can be known as a different
pid, not just the first.

> How about instead having a way to put the pid's of checkpointed tasks
> in deep freeze, saving them for reuse when the task restarts?
> System calls that operate on pid values could error out with some
> new errno, -EFROZEN or some such.

Unfortunately that would not work for checkpoints across boots, or, more
importantly, for process (set) migration.

> This would seem far less invasive.  Not just less invasive of the code,
> but more importantly, not introducing some never entirely realizable
> semantic change to the scope of pids.

Hopefully the next patchset, implementing the pid-vpid split, will show
it's not as complicated as I've made it sound.

Of course, if it remains too complicated a conceptual change to be
mergeable, we're better off knowing that now...

thanks,
-serge
