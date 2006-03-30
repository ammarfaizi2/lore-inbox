Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWC3Cty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWC3Cty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWC3Cty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:49:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51118 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751457AbWC3Ctx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:49:53 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
References: <20060328085206.GA14089@MAIL.13thfloor.at>
	<4428FB29.8020402@yahoo.com.au>
	<20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 29 Mar 2006 19:48:15 -0700
In-Reply-To: <20060330013618.GS15997@sorel.sous-sol.org> (Chris Wright's
 message of "Wed, 29 Mar 2006 17:36:18 -0800")
Message-ID: <m164lwfy1c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:


>> At least one implementation Linux Jails by Serge E. Hallyn was done completely
>> with security modules, and the code was pretty minimal.
>
> Yes, although the networking area was something that looked better done
> via namespaces (at least that's my recollection of my conversations with
> Serge on that one a few years back).

For general networking yes the namespace flavor seems to be the sane
way to do it.

As I currently understand the problem everything goes along nicely
nothing really special needed until you start asking the question
how do I implement a root user with uid 0 who does not own the
machine.  When you start asking that question is when the creepy
crawlies come out.

On most virtual filesystems the default owner of files is uid 0.
Additional privilege checks are not applied.  Writing to those
files could potentially have global effect.

It is completely unclear how permissions checks should work
between two processes in different uid namespaces.  Especially
there are cases where you do want interactions.

If every guest/container/jail is configured so the uids with the same
value mean the same user there are no security issues even when they
interact because the isolation is not perfect.  So my gut feel it to
postpone a bunch of these problems and say making uids non-global
is a security module issue.

Eric

