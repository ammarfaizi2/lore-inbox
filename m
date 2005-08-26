Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVHZR75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVHZR75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVHZR75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:59:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965152AbVHZR74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:59:56 -0400
Date: Fri, 26 Aug 2005 10:59:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tony Jones <tonyj@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 2/5] Rework stubs in security.h
Message-ID: <20050826175952.GP7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012148.690615000@localhost.localdomain> <20050826173151.GA1350@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826173151.GA1350@immunix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Jones (tonyj@suse.de) wrote:
> The discussion about composing with commoncap made me think about whether
> this is the best way to do this.   It seems that we're heading towards a
> requirement that every module internally compose with commoncap.  

Not a requirement, it's a choice ATM.

> If so (apart from the obvious correctness issues when they don't) it's work
> for each module and composing N of them under stacker obviously creates 
> overhead.
> 
> Would the following not be a better approach?
> 
> static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
> {
> int ret;
> 	ret=cap_ptrace (parent, child);
> #ifdef CONFIG_SECURITY
> 	if (!ret && security_ops->ptrace)
> 		ret=security_ops->ptrace(parent, child);
> #endif
> 	return ret;
> }

Heh, this was next on my list.  I just wanted to separate the changes to
one at a time so we can easily measure the impact.  This becomes another
policy shift.

> If every module is already internally composing, there shouldn't be a 
> performance cost for the additional branch inside the #ifdef.

This needs measurement to verify.

> I havn't looked at every single hook and it's users to see if this would
> cause a problem.  I noticed SELinux calls sec->capget() post rather than pre 
> it's processing which may be an issue.

Yes, that need careful inspection.

thanks,
-chris
