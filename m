Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVCHGny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVCHGny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVCHGnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:43:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:35470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVCHGkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:40:43 -0500
Date: Mon, 7 Mar 2005 22:40:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, paul@linuxaudiosystems.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308064006.GI5389@shell0.pdx.osdl.net>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au> <20050308054931.GA20200@elte.hu> <422D4628.8060203@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422D4628.8060203@bigpond.net.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Williams (pwil3058@bigpond.net.au) wrote:
> But the patch you describe still seems a little loose to me in that it 
> doesn't control both which users AND which programs they can run. 
> Although I suppose that can be managed by suitable setting of file 
> permissions?

rlimits are typically handled per user or per group.  this is set during
login and the limits apply to the users session.  none of the solutions
limit which programs the user can run, however strictly group based priv
granting can reduce the number of processes with the privs (using setgid
programs).

> Also I presume that root privileges are needed to set the rlimits which 
> means that the program has to be setuid root or run from a setuid root 
> wrapper.  In the first of these cases the program will be running for a 
> (hopefully) short while with way more privilege than it needs.  This is 
> why I'm attracted to mechanisms that allow programs to be given a subset 
> of root's privileges and only for specified users.

typically this is handled via pam during login, so yes, root (or more
specifically CAP_SYS_RESOURCE) is required, but need not be in any
wrapper.  limiting the allowed programs a user/role/domain/context/etc
can run is the goal of other type of security restrictions (such as
SELinux).

> I would be nice to have a solution to this particular problem that fits 
> in with such a generalized "granular" privilege mechanism (when/if such 
> a mechanism becomes available in the future) rather than a quirky fix 
> that is specific to this problem and doesn't generalize well to similar 
> problems when they arise in the future.  However, I agree with your 
> opinion that granting CAP_SYS_NICE is dangerous without some limit on 
> the priority levels is dangerous and think that a generalized "granular" 
> privilege mechanism would need to include such restrictions.
> 
> >The patch does not attempt to do any
> >"damage control" of abuse caused by RT tasks, and is hence much simpler
> >than my patch or Con's SCHED_ISO patch. ("damage control" could be done
> >from userspace anyway)
> 
> Yes.  In kernel "damage control" is an optional extra not a necessity 
> with this solution.  Not so sure about with the RT LSB solution though.

This has one advantage over RT LSM in that area, which is it places an
upper bound on the priority (in control of the admin).  So it's possible
to save some space for damage control in the top few prio slots.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
