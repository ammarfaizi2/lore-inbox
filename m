Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVCHE7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVCHE7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCHE7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:59:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:37866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261759AbVCHE6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:58:46 -0500
Date: Mon, 7 Mar 2005 20:58:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, paul@linuxaudiosystems.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308045811.GF5389@shell0.pdx.osdl.net>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308035503.GA31704@infradead.org> <20050307201646.512a2471.akpm@osdl.org> <20050308042242.GA15356@elte.hu> <20050307202821.150bd023.akpm@osdl.org> <20050308043250.GA32746@infradead.org> <20050308044757.GH3120@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308044757.GH3120@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Tue, Mar 08, 2005 at 04:32:50AM +0000, Christoph Hellwig wrote:
> > On Mon, Mar 07, 2005 at 08:28:21PM -0800, Andrew Morton wrote:
> > > > please describe this "very simple and very real-world problem" in simple
> > > > terms. Lets make sure "problem" and "solution" didnt become detached.
> > > > 
> > > 
> > > Well others can do that better than I but I'd describe it as
> > > 
> > > - Audio apps need to meet their realtime requirements
> 
> Add video, data acquisition, motion control, CD burning, etc..
> 
> > > - The way to implement that is to give them !SCHED_OTHER and mlockall
> > >   capabilities.
> > > 
> > > - But they don't want to run as root.
> > 
> > Which all fits very nicely with MEMLOCK rlimit and a tiny wrapper
> > that sets !SCHED_OTHER and execs the audio app..
> 
> This is somewhat complicated by the fact that the existing apps are
> already running and instead need promotion. Then we run into problems
> lie set_rlimit doesn't want to work on other processes and issues with
> sched_setparam on other threads, etc.
> 
> Part of me wants to say, well you designed it wrong. You should have
> planned a setuid launcher for the rt threads. But at the same time,
> the rlimits thing seems like a reasonably clean way to give RT access
> to users, and still allows for protect watchdog processes..
>  
> > and as I mentioned a few times if we really want to go for a magic
> > uid/gid-based approach we should at least have one that's useable for
> > all capabilities so it can replace the oracle hack aswell.  But the
> > proponents of the patch weren't iterested to invest the tiniest bit
> > of work over what they submited.
> 
> Does the mlock rlimit not already address the Oracle problem?

It does, that's effectively dead code as far as I'm concerned.  The mlock
bit just came in a bit later.  I had a patch around here to rip it out,
this should be a good time to dust that off.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
