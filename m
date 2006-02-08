Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWBHQm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWBHQm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbWBHQm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:42:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16797 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030589AbWBHQmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:42:55 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, Dmitry Mishin <dim@sw.ru>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<43E92602.8040403@vilain.net> <43E92AC9.3090308@watson.ibm.com>
	<m1oe1ia1c9.fsf@ebiederm.dsl.xmission.com>
	<43E9FC85.1000500@watson.ibm.com> <43EA11C5.5010908@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 09:39:51 -0700
In-Reply-To: <43EA11C5.5010908@sw.ru> (Kirill Korotaev's message of "Wed, 08
 Feb 2006 18:44:05 +0300")
Message-ID: <m14q399548.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> My point was to mainly identify the performance culprits and provide
>> an direct access to those "namespaces" for performance reasons.
>> So we all agreed on that we need to do that..
> After having looked at Eric's patch, I can tell that he does all these
> dereferences in quite the same amount.
>
> For example, lot's of skb->sk->host->...
> while in OpenVZ it would be econtainer()->... which is essentially
> current->container->...

Except at that point in time I cannot use current, because it
does not have necessarily have the appropriate context.  So doubt
you could correctly use econtainer there.

> So until someone did measurements it looks doubtfull that one solution is better
> than the another.

I agree, exactly where we look is a minor matter, unless we can find
an instance where there are good reasons for preferring one representation
over another.  Performance currently does not look a sufficient reason.


My basis for preferring a flat layout is essentially because
that is how other similar interfaces are currently implemented
in the kernel.

In linux we have a plan9 inspired system call called clone.
One of the ideas with clone is that when you create a new
task you either share or you don't share resources.  Namespaces
are one of those resources.

Since we are dealing with concepts that appear to fit the
existing model beautifully my feeling is to use the existing
model of how things are currently implemented in the kernel.


The only other reason I can think of is namespace implementation
independence.  If we have an additional structure that we collect
up the pointers it feels like it causes unnecessary tying.



The best justification I can think of for putting it all in
one structure seems like the current->container current->econtainer
thing that comes out of OpenVZ.  Currently I have followed the
threads enough to know it exists but I yet understand it.

If there is a good reason for the container/econtainer thing I can
certainly seem some benefit.  

Eric
