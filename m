Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVBXDNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVBXDNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVBXDNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:13:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:50857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVBXDMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:12:34 -0500
Date: Wed, 23 Feb 2005 19:12:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
Message-ID: <20050224031222.GH15867@shell0.pdx.osdl.net>
References: <20050224023245.GA28536@shell0.pdx.osdl.net> <200502240243.j1O2h8Bk010811@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502240243.j1O2h8Bk010811@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> > * Roland McGrath (roland@redhat.com) wrote:
> > > Indeed, I think your patch does not go far enough.  I can read POSIX to say
> > > that the siginfo_t data must be available when `kill' was used, as well.
> > 
> > How?  I only see reference to filling in SI_USER for rt signals?
> > Just curious...(I've only got SuSv3 and some crusty old POSIX rt docs).
> 
> There is stuff about a SA_SIGINFO signal handler's siginfo_t argument
> "shall contain" the various specified information like si_pid/si_uid values
> for a kill caller.

OK, guess it's odd corner case, since they aren't queued anyway.

> > Good point.  Although it's RLIMIT_SIGPENDING + (31 * user_nprocs).  So
> > that could be 31 * 8k, for example.
> 
> And a "good point" back to you, sir!  I think the right way to think about
> this in terms of resource consumption is that sizeof(struct sigqueue)*31 is
> part of the potential per-process overhead that make up the consumption
> units one should have in mind when choosing how to set the RLIMIT_NPROC limit.

As in dynamic, and work with the patch that you sent to redo default
sigpending as per nproc?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
