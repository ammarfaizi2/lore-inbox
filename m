Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWDGTlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWDGTlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWDGTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:41:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42945 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964915AbWDGTlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:41:24 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 0/5] uts namespaces: Introduction
References: <20060407095132.455784000@sergelap>
	<m1wte1mcim.fsf@ebiederm.dsl.xmission.com>
	<20060407192800.GE28729@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 07 Apr 2006 13:39:20 -0600
In-Reply-To: <20060407192800.GE28729@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Fri, 7 Apr 2006 14:28:00 -0500")
Message-ID: <m1y7yhkwev.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> 
>> > Introduce utsname namespaces.  Instead of a single system_utsname
>> > containing hostname domainname etc, a process can request it's
>> > copy of the uts info to be cloned.  The data will be copied from
>> > it's original, but any further changes will not be seen by processes
>> > which are not it's children, and vice versa.
>> >
>> > This is useful, for instance, for vserver/openvz, which can now clone
>> > a new uts namespace for each new virtual server.
>> >
>> > This patchset is based on Kirill Korotaev's Mar 24 submission, taking
>> > comments (in particular from James Morris and Eric Biederman) into
>> > account.
>> >
>> > Some performance results are attached.  I was mainly curious whether
>> > it would be worth putting the task_struct->uts_ns pointer inside
>> > a #ifdef CONFIG_UTS_NS.  The result show that leaving it in when
>> > CONFIG_UTS_NS=n has negligable performance impact, so that is the
>> > approach this patch takes.
>> 
>> Ok.  This looks like the best version so far.
>> 
>> I like the utsname() function thing to shorten the 
>> idiom of  current->uts_ns->name.
>> 
>> We probably want to introduce utsname() and an init_utsname()
>> before any of the other changes, and then perform the substitutions,
>
> This is the same as what Sam is saying, right?  Just making sure I
> understand.

Yes.

>> before we actually change the code so the patchset can make it
>> through a git-bisect.  This will also allows for something
>
> Ok, I've finally got the rest of git doing my bidding, I'll go read
> up on git-bisect.

Basically git-bisect is an automated binary search through patches
to help find bugs.  If you ever can't compile at an intermediate
patch git-bisect and other people walking through the patches
looking for bugs won't like it.

It's not mandatory that you never break anything in a patchset,
but it is much friendlier when you can avoid breakage.

Eric
