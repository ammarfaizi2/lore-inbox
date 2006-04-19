Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWDSMKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWDSMKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDSMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:10:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:20916 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750718AbWDSMKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:10:40 -0400
Date: Wed, 19 Apr 2006 07:10:34 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kurt Garloff <garloff@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419121034.GE20481@sergelap.austin.ibm.com>
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org> <20060418213833.GC5741@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418213833.GC5741@tpkurt.garloff.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kurt Garloff (garloff@suse.de):
> Hi,
> 
> On Tue, Apr 18, 2006 at 12:58:19PM +0100, Christoph Hellwig wrote:
> > It's doing access control on pathnames, which can't work in unix enviroments.
> > It's following the default permit behaviour which causes pain in anything
> > security-related (compare [1]).
> 
> Pathnames are problematic, no doubt.
> So AppArmor does currently do some less-than-nice things to get around
> this.
> On the other side, pathnames is what the admins see and use, so it is
> the right abstraction for the sysadmin, if you want to make a higher
> level of security available to people without the need to get them
> a large amount of extra training.
> So that gap needs to be bridged somehow.
> Maybe there are better ways compared to what AA does currently, and
> constructive suggestions are very welcome!
> 
> And no, just claiming that AA is useless or crap is not constructive
> AFAICT. And saying that is should be better done as part of SElinux
> is not either.

Ok, but...  why not?

Have you ever tried, at 4pm some afternoon, sitting in a room with some
paper and implementing the AA user interface on top of selinux?

An initial selinux policy can basically be:

print "type base_t;"

for c in object_class:
	"allow base_t base_t:c *;"

Then, if the AA user has a profile

	/bin/login {
		/etc/shadow r
	}

it creates domain login_t, entry type login_et assigned to /bin/login,
and shadow_t as a type which login_t can only read, but non-restricted
domains (i.e. base_t) can read and write.  It also makes read and write
macros for a bunch of selinux perms (i.e. ioctl, etc), the way the
Tresys CDE tool does.

I do want LSM to survive, and am reserving my judgement of AA until
I see the code, but if it really is just about ease of use, then
perhaps it should be a pure userspace thing?

OTOH perhaps there are reasons why you can't do this, and you can
explain why the above won't work.

-serge
