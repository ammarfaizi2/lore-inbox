Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVGaDot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVGaDot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGaDot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:44:49 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:61693 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261595AbVGaDos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:44:48 -0400
Date: Sat, 30 Jul 2005 22:44:09 -0500
From: serge@hallyn.com
To: Steve Beattie <sbeattie@suse.de>
Cc: Tony Jones <tonyj@suse.de>, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050731034409.GA17120@vino.hallyn.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com> <20050730201852.GA8223@immunix.com> <20050731032226.GC25629@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731032226.GC25629@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steve Beattie (sbeattie@suse.de):
> On Sat, Jul 30, 2005 at 01:18:52PM -0700, Tony Jones wrote:
> > # cat /proc/2322/attr/current 
> > unconstrained (subdomain)
> > foobar (foobar)
> > 
> > # ps -Z -p 2322
> > LABEL                             PID TTY          TIME CMD
> > unconstrained                    2322 ttyS0    00:00:00 bash
> 
> Actually, no, it is the space preceding the open paren that is invalid;
> see this patch for the expanded allowed character set in procps 3.2.5:
> 
>   http://cvs.sourceforge.net/viewcvs.py/procps/procps/ps/output.c?r1=1.51&r2=1.52
> 
> When I discussed this with Albert Cahalan, he *strongly* objected to
> allowing whitespace in security contexts, as he felt it would break
> scripts that parsed 'ps -Z' output.

Right, I thought this was actually a feature :)  This is how ps
continues to show expected output under stacker.  Given naturally limited
space, showing output for multiple modules may not be a good idea.  If
you want more detail, you go to /proc/pid/attr/current...

Clearly this is limiting, but then so is the one line per process you
get with ps - "fixing" that is obviously not acceptable.  Is there
another suggestion for how to handle this, in such a way that ps would
show info for >1 module?  Is there any example where the current
behavior is actually a problem - two modules which it makes sense to
stack, which both need to give output under ps?

thanks,
-serge
