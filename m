Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbULBUMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbULBUMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULBUMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:12:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:19338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261749AbULBUMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:12:32 -0500
Date: Thu, 2 Dec 2004 12:12:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
Subject: Re: [PATCH 4/6] Add dynamic context transition support to SELinux
Message-ID: <20041202121228.F2357@build.pdx.osdl.net>
References: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil> <20041202103456.O14339@build.pdx.osdl.net> <1102013788.26015.192.camel@moss-spartans.epoch.ncsc.mil> <20041202111859.A2357@build.pdx.osdl.net> <1102017022.26015.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1102017022.26015.249.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Dec 02, 2004 at 02:50:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2004-12-02 at 14:18, Chris Wright wrote:
> > No, I was thinking of actually tracking the threads, since you know when
> > they come and go.  One way would be to share task_security_struct via
> > refcnt for threads, although this could get sticky.
> 
> Hmm...that would be a significant change, and I'm not clear that the
> existing security_task_alloc() hook even allows for it (no clone_flags
> passed to it).  ptrace_sid could also be an issue for sharing.

True, guess that's filed under "sticky" ;-)

> Note that the mm checking logic is already after one permission check
> (setcurrent), which will only be allowed to the small set of privileged
> processes that use this feature.  That acts as the gatekeeper for any
> use of this feature, then the dyntransition check controls the possible
> transitions among security contexts using this feature.  In the case of
> exec-based transitions, the corresponding transition check is deferred
> until the actual exec processing.  So even as it stands, arbitrary
> processes aren't allowed to reach the code in question, which is better
> than the [gs]etpriority cases.

OK, I misread that any threaded app could write to /proc/self/attr/current
and trigger that loop, only to fail the avc lookup.  Yes, now I see the
PROCESS__SETCURRENT test, thanks.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
