Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVBXCoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVBXCoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVBXCoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:44:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261768AbVBXCnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:43:23 -0500
Date: Wed, 23 Feb 2005 18:43:08 -0800
Message-Id: <200502240243.j1O2h8Bk010811@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
In-Reply-To: Chris Wright's message of  Wednesday, 23 February 2005 18:32:45 -0800 <20050224023245.GA28536@shell0.pdx.osdl.net>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Roland McGrath (roland@redhat.com) wrote:
> > Indeed, I think your patch does not go far enough.  I can read POSIX to say
> > that the siginfo_t data must be available when `kill' was used, as well.
> 
> How?  I only see reference to filling in SI_USER for rt signals?
> Just curious...(I've only got SuSv3 and some crusty old POSIX rt docs).

There is stuff about a SA_SIGINFO signal handler's siginfo_t argument
"shall contain" the various specified information like si_pid/si_uid values
for a kill caller.

> Good point.  Although it's RLIMIT_SIGPENDING + (31 * user_nprocs).  So
> that could be 31 * 8k, for example.

And a "good point" back to you, sir!  I think the right way to think about
this in terms of resource consumption is that sizeof(struct sigqueue)*31 is
part of the potential per-process overhead that make up the consumption
units one should have in mind when choosing how to set the RLIMIT_NPROC limit.


Thanks,
Roland
