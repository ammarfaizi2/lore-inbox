Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWC3TVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWC3TVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWC3TVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:21:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11395 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750741AbWC3TVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:21:48 -0500
Date: Thu, 30 Mar 2006 11:23:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330192308.GZ15997@sorel.sous-sol.org>
References: <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <m164lwfy1c.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164lwfy1c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> As I currently understand the problem everything goes along nicely
> nothing really special needed until you start asking the question
> how do I implement a root user with uid 0 who does not own the
> machine.  When you start asking that question is when the creepy
> crawlies come out.

Hehe.  uid 0 _and_ full capabilities.  So reducing capabilities is one
relatively easy way to handle that.  And, if you have a security module
loaded it's going to use security labels, which can be richer than both
uid and capabilites combined.

> On most virtual filesystems the default owner of files is uid 0.
> Additional privilege checks are not applied.  Writing to those
> files could potentially have global effect.

Yes, many (albeit far from all) have a capable() check as well.

> It is completely unclear how permissions checks should work
> between two processes in different uid namespaces.  Especially
> there are cases where you do want interactions.

Are there?  Why put them in different containers then?  I'd think
network sockets is the extent of the interaction you'd want.  Sharing
filesystem does leave room for named pipes and unix domain sockets (also
in the abstract namespace).  And considering the side channel in unix
domain sockets, they become a potential hole.  So for solid isolation,
I'd expect disallowing access to those when the object owner is in a
different security context from context which is trying to attach.

thanks,
-chris
