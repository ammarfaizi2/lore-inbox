Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263111AbVG3TFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbVG3TFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbVG3TDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:47 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:56223 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263110AbVG3TCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:02:54 -0400
Date: Sat, 30 Jul 2005 14:02:22 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@immunix.com>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050730190222.GA12473@vino.hallyn.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730050701.GA22901@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@immunix.com):

Thanks, Tony.  I'll address each of these in the next patchset.  Just
two things I wanted to actually converse about:

> 5) /*
>  * Workarounds for the fact that get and setprocattr are used only by
>  * selinux.  (Maybe)
>  */
> 
> No complaints on selinux getting to avoid the (module), they are intree.
> Just a FYI that SubDomain/AppArmor uses these hooks also.

And is it ok with using the "some_data (apparmor)" convention?

The special handling of selinux is intended to be temporary, due to the
large base of installed userspace which hasn't yet been updated.  I
would imagine that at some point that code would go away.

> I noticed the conditional CONFIG_SECURITY_STACKER code went away, previously
> it would look at the value chain head only for the !case. But this comment
> still remains.

Yes, after I added the unlink function, it started to seem that the
special cases for !CONFIG_SECURITY_STACKER wouldn't be any faster than
the stacker versions.  They still might be, but I'll have to think about
it.  If I just ditch those, then I can probably ditch the whole
security-stack.h file, and move those declarations into security.h.
They were just in their own file because Stephen had pointed out that
switching between stacker and non-stacker would cause too much code to
be recompiled.

thanks,
-serge
