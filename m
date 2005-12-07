Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVLGWwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVLGWwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVLGWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:52:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48071 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030416AbVLGWwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:52:25 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	<1133977623.24344.31.camel@localhost>
	<m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
	<1133991650.30387.17.camel@localhost>
	<m18xuwd015.fsf@ebiederm.dsl.xmission.com>
	<1133994685.30387.47.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 15:51:26 -0700
In-Reply-To: <1133994685.30387.47.camel@localhost> (Dave Hansen's message of
 "Wed, 07 Dec 2005 14:31:25 -0800")
Message-ID: <m14q5kcyhd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2005-12-07 at 15:17 -0700, Eric W. Biederman wrote:
>> But beyond that a general test to see if you have done a good
>> job of virtualizing something is to see if you can recurse.
>
> I admit it would be interesting at the very least.  But, using that
> definition, we haven't done any good virtualization in Linux that I can
> think of.  Besides some vague ranting I heard about zSeries (the real
> IBM mainframes) I can't think of anything that does this today.
>
> I don think any of Solaris containers, ppc64 LPARs, Xen, UML, or
> vservers can recurse.  
>
> Can you think of any?

There is Xnest that allows X to run on X.

There are process groups and sessions that while they may
not strictly nest you don't loose the ability to create new
ones.

There is the CLONE_NEWNS and just about any of the other
clone flags in linux.

There is bochs that emulates the whole machine.

I am actually a little surprised that UML can't run UML.  I
suspect it is an address space conflict and not something fundamental.

With pidspaces as long as the parent isn't required to send
signals to arbitrary children  I don't think nesting pids spaces
is hard.  Or more properly have a process in one pidspace be
the parent of a process in another.  Although I grant there
are a few boundary issues, that have to be handled carefully.

Eric
