Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWF2P3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWF2P3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWF2P3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:29:03 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:5760 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750781AbWF2P3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:29:01 -0400
Subject: Re: [PATCH 1/3] SELinux: Extend task_kill hook to handle signals
	sent by AIO completion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Quigley <dpquigl@tycho.nsa.gov>
In-Reply-To: <20060629001628.GQ11588@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
	 <20060629001628.GQ11588@sequoia.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 29 Jun 2006 11:31:44 -0400
Message-Id: <1151595104.6999.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 17:16 -0700, Chris Wright wrote:
> > +	void (*task_getsecid) (struct task_struct * p, u32 * secid);
> 
> Why not just:
> 	u32 (*task_getsecid) (struct task_struct *p);

That's fine, although we should then change the SELinux exports as well
to be consistent (and convert them all to secid rather than sid or
ctxid, and eliminate duplication there that has crept in).  That can be
done by later patch.

> >  	int (*task_kill) (struct task_struct * p,
> > -			  struct siginfo * info, int sig);
> > +			  struct siginfo * info, int sig, u32 secid);
> 
> This breaks the build, which breaks bisection.  Be nice to avoid that
> since there's no reason the patches couldn't split that way.

Not sure how one would split them - they are logically all one change
(change interface and all callers, propagating up the call chain).  The
original split up was just for review purposes, by subsystem.  We can
submit it as a single patch if that is preferable.

-- 
Stephen Smalley
National Security Agency

