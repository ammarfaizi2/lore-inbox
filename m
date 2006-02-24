Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWBXVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWBXVsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWBXVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:48:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17065 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932567AbWBXVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:48:20 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@sawoct.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Stanislav Protassov <st@sw.ru>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>
Subject: Re: Which of the virtualization approaches is more suitable for
 kernel?
References: <43F9E411.1060305@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 14:44:42 -0700
In-Reply-To: <43F9E411.1060305@sw.ru> (Kirill Korotaev's message of "Mon, 20
 Feb 2006 18:45:21 +0300")
Message-ID: <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Linus, Andrew,
>
> We need your help on what virtualization approach you would accept to
> mainstream (if any) and where we should go.
>
> If to drop VPID virtualization which caused many disputes, we actually
> have the one virtualization solution, but 2 approaches for it. Which one
> will go depends on the goals and your approval any way.

My apologies for not replying sooner.

>From the looks of previous replies I think we have some valid commonalities
that we can focus on.

Largely we all agree that to applications things should look exactly as
they do now.  Currently we do not agree on management interfaces.

We seem to have much more agreement on everything except pids, so discussing
some of the other pieces looks worth while.

So I propose we the patches to solve the problem into three categories.
- General cleanups that simplify or fix problems now, but have
  a major advantage for our work.
- The kernel internal implementation of the various namespaces
  without an interface to create new ones.
- The new interfaces for how we create and control containers/namesp    aces.

This should allow the various approach to start sharing code, getting
progressively closer to each other until we have an implementation
we can agree is ready to go into Linus's kernel.  Plus that will
allow us to have our technical flame wars without totally stopping
progress.

We can start on a broad front, looking at several different things.
But I suggest the first thing we all look at is SYSVIPC.  It is
currently a clearly recognized namespace in the kernel so the scope is
well defined.  SYSVIPC is just complicated enough to have a
non-trivial implementation while at the same time being simple enough
that we can go through the code in exhausting detail.  Getting the
group dynamics working properly.

Then we can as a group look at networking, pids, and the other pieces.

But I do think it is important that we take the problem in pieces
because otherwise it is simply to large to review properly.

Eric
