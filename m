Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWBMXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWBMXpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWBMXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:45:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030298AbWBMXpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:45:34 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	<m1wtg2w41c.fsf@ebiederm.dsl.xmission.com> <43F04B28.9090300@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Feb 2006 16:41:24 -0700
In-Reply-To: <43F04B28.9090300@sw.ru> (Kirill Korotaev's message of "Mon, 13
 Feb 2006 12:02:32 +0300")
Message-ID: <m1k6byvnbv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>Actually I can't say your patch is cleaner somehow.
>>>It is very big and most of the changes are trivial, which creates an illusion
>>>that it is straightforward and clean.
>> It is hard to make a comparison.  Your patch posted to the mail list
>> was incomplete, and I could only find a giant patch for OpenVZ.
> this is wrong. it lacked only alpha get_xpid().
> sure, we didn't do that dirty games with /proc you did, so maybe this is why you
> have such a feeling.

Not at all.
- You didn't have a system call interface.
- You didn't include your patches to proc.
- The fact that you missed several whole subsystems, (as did I)
  is a minor issue.
etc.

The patches we posted were a different subset of the whole, and as such
a clear comparison could not be made.

>> Beyond that if your patch introduced a type change for internal pids
>> and used that generate compile errors when someone did not use the
>> appropriate type, I would be a lot happier and the code would
>> be a lot more maintainable.  I.e. It would not take an audit of
>> the kernel source to find the issues an allyesconfig build would find
>> them for you.
> it is not a problem at all and can be done.

Then why isn't it done in OpenVZ?

I agree it can be done.  But an audit of the entire kernel is painful.

>> The advantages I see with my approach.
>> - I have hierarchical pids so nesting is possible.
> Once again, our approach doesn't prohibit hierarchical pids.
> But in addition to yours it allows to select whether weak or strong isolation is
> required.

Again. I have not heard this assertion before, and I don't see it.
But let me ask a question that helps frame the issue.

Can I migrate all of the processes and (containers) on a real server
(not in a container) into a container on another machine without
any change in pids?

I believe that would require 3 on the inner most nested processes with
your approach.


>> - The state after migration is not suboptimal.
> sorry?

You have 2 approaches, in your patch.  I have one approach that works
for everything.  Possibly I misunderstood my skimming, but usually
optimizations are only added when needed.

>> - I cause compiler errors which makes maintenance easier.
> it is not a question to the approach itself, you see? so not an argument.

How the code will be maintained when discussing merging with the mainline
kernel is one of the most important issues to consider.

>> - Other kernel developers gut feel is that (container, pid) is the proper
>>   representation.    I actually flip flop on the issue of if I want the
>> internal representation
>>   to be (container, pid) or a magic kpid that combines the into one integer.
>>   I know I don't want the kpid to be user space visible though.
>> So far you have not addressed the issues of maintaining code in the
>> kernel tree.
> Uhhh... I see that you have no real arguments. Nice.

I wasn't trying to argue simply to lay it out as I saw it.

Eric
