Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWHXUIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWHXUIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWHXUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:08:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15423 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422632AbWHXUII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:08:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=DbEicsTTUj1yh7RONtFPTCe636Gt9VL/dGpuBDbQpVdr+tKvzawdX3XEjyrUIoNtMCSky4QvYtvJMIKHTMDVvsRlWCIDK0p9wnQCekYaevYrnhm/cQUz3Glvl6XT8s/qhJtL43Bn5SA10FSoozY4oB/OnpgifsDNRJZXHSsBzvk=
Date: Thu, 24 Aug 2006 22:07:47 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Amnon Shiloh <amnons@cs.huji.ac.il>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, gregkh@suse.de
Subject: Re: [2.6.18 patch] fix mem_write return value (was: Re: bug report: mem_write)
Message-ID: <20060824220747.GA3197@slug>
References: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il> <20060824140001.GE1543@slug> <m17j0ym6un.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j0ym6un.fsf@ebiederm.dsl.xmission.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:33:20AM -0600, Eric W. Biederman wrote:
> Frederik Deweerdt <deweerdt@free.fr> writes:
> 
> > On Thu, Aug 24, 2006 at 11:25:37AM +0300, Amnon Shiloh wrote:
> >> Hi,
> >> 
> >> Alright, I know that "mem_write" (fs/proc/base.c) is a "security hazard",
> >> but I need to use it anyway (as super-user only), and find it broken,
> >> somewhere between Linux-2.6.17 and Linux-2.6.18-rc4.
> >> 
> >> The point is that in the beginning of the routine, "copied" is set to 0,
> >> but it is no good because in lines 805 and 812 it is set to other values.
> >> Finally, the routine returns as if it copied 12 (=ENOMEM) bytes less than
> >> it actually did.
> > True, it looks like the faulty commit is:
> > de7587343bfebc186995ad294e3de0da382eb9bc
> 
> Actually it was: 99f895518368252ba862cc15ce4eb98ebbe1bec6
> Which is what you url points to, odd.
> 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=99f895518368252ba862cc15ce4eb98ebbe1bec6;hp=8578cea7509cbdec25b31d08b48a92fcc3b1a9e3
> >
> > The attached patch should fix it. Maybe that should go to 2.6.18.
> > Thanks for the bug report,
> 
> The patch looks correct.  Although this won't cause anyone problems as the code
> is disabled.
Right, I missed this, so this is really not urgent.
> 
> Signed-off-by: Eric Biederman <ebiederm@xmission.com>
> 
> As for enabling this.  I believe we need an extra permission check just before
> we copy the data from our temporary buffer to the target task, to ensure
> nothing has changed.  The history does not really capture why this code
> was disabled, but before this gets enabled I would like to understand more
> than just the comment.  I believe with a little care this can be safely enabled
> as it doesn't let you do anything ptrace wouldn't do, and it should let you do
> it anytime except when ptrace would allow it.  Thus not introducing any new
> security holes.
I've found two interesting links on that:
http://lkml.org/lkml/2006/3/10/224
and
http://www.google.com/search?q=cache:4y8MWSuHOpIJ:files.security-protocols.com/kernelhacking/procpidmem.pdf&hl=en&ct=clnk&cd=3&client=firefox-a
The second one in particular goes in great detail on why the author
thinks this is dangerous, and what could be done to re-enable it.

Regards,
Frederik
