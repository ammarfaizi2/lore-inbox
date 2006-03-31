Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCaNkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCaNkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCaNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:40:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53376 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932141AbWCaNkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:40:24 -0500
Date: Fri, 31 Mar 2006 07:40:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       David Lang <dlang@digitalinsight.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060331134021.GB8505@sergelap.austin.ibm.com>
References: <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com> <20060330153012.GA16720@MAIL.13thfloor.at> <m1fykzdd8s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fykzdd8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > sorry folks, I don't think that we _ever_ want container
> > root to be able to load any kernel modues at any time
> > without having CAP_SYS_ADMIN or so, in which case the
> > modules can be global as well ... otherwise we end up
> > as a bad Xen imitation with a lot of security issues,
> > where it should be a security enhancement ...
> 
> Agreed.  At least until someone defines a user-mode
> linux-security-module.  We may want a different security module

It's been done before, at least for some hooks (ie one implementation by
antivirus folks).  But to actually do this with full support for all
hooks would require some changes.  For example, the security_task_kill()
hook is called under several potential locks.  At least
read_lock(tasklist_lock) and plain rcu_read_lock() (and I thought also
write_lock(tasklist_lock), but can't find that instance right now).

Clearly that can be fixed, but atm a user-mode lsm isn't entirely
possible.

-serge
