Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWBGRXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWBGRXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWBGRXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:23:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52366 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932164AbWBGRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:23:04 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net>
	<m1oe1jfa5n.fsf@ebiederm.dsl.xmission.com> <43E8C84D.6020107@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 10:20:46 -0700
In-Reply-To: <43E8C84D.6020107@sw.ru> (Kirill Korotaev's message of "Tue, 07
 Feb 2006 19:18:21 +0300")
Message-ID: <m18xsnf5ld.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>I can't think of any real use cases where you would specifically want A)
>>>without B).
>
>> You misrepresent my approach.
> [...]
>
>> Second I am not trying to just implement a form of virtualizing PIDs.
>> Heck I don't intend to virtualize anything.  The kernel has already
>> virtualized everything I require.  I want to implement multiple
>> instances of the current kernel global namespaces.  All I want is
>> to be able to use the same name twice in user space and not have
>> a conflict.
> if you want not virtualize anything, what is this discussion about? :)
> can you provide an URL to your sources? you makes lot's of statements about that
> your network virtualization solution is better/more complete, so I'd like to see
> your solution in whole rather than only words.
> Probably this will help.

Sure.

I think it is more an accident of time, and the fact that I am quite
proud of where I am at.  You quite likely have improved things in openvz
since last I looked as well.  Currently my code quality is only a proof
of concept but the tree is below.

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/linux-2.6-ns.git/

Basically the implementation appears to the user as a separate instance
of the network stack.  Since the tree was experimental the path is
absolutely horrible.  I am in the process of cleaning and redoing all
of that now in preparation for kernel inclusion.

But I suspect I am in the lead as no one else had noticed the ipv6 
reference counting bugs.

>> I disagree with a struct container simply because I do not see what
>> value it happens to bring to the table.  I have yet to see a problem
>> that it solves that I have not solved yet.
> again, source would help to understand your solution and problem you solved and
> not solved yet.

Above.  But at least with pids it has all been posted on the mailing list.

I think I have solved most of the code structural issues and the big
kernel API issues.  A lot of the little things I have not gotten to yet
as I figured it was best approached later.

>> In addition I depart from vserver and other implementations in another
>> regard.  It is my impression a lot of their work has been done so
>> those projects are maintainable outside of the kernel, which makes
>> sense as that is where those code bases live.  But I don't think that
>> gives the best solution for an in kernel implementation, which is
>> what we are implementing.
> These soltuions are in kernel implementations actually.

Sorry in/out in this context I was referring to the stock linux kernel.
As soon as I had a viable proof of concept I began working to get
my code merged.

Eric

