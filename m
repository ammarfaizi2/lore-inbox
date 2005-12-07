Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVLGWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVLGWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVLGWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:18:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24263 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030402AbVLGWSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:18:54 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 15:17:58 -0700
In-Reply-To: <1133991650.30387.17.camel@localhost> (Dave Hansen's message of
 "Wed, 07 Dec 2005 13:40:50 -0800")
Message-ID: <m18xuwd015.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2005-12-07 at 12:19 -0700, Eric W. Biederman wrote:
>> >> Another question is how do your pid spaces nest.
>> >
>> > They don't, and thankfully there is anybody asking for it.  It adds
>> > loads of complexity, and nobody apparently needs it.
>> 
>> So only very special pids can generate a pidspace.  That will
>> tend to reduce the generality of the solution.  What do you do
>> if I am running your code in a vserver?
>
> I don't think it would be a good idea to stack these containers within
> vservers, either.  vserver uses different pidspaces, and will use the
> same infrastructure.  The only difference is that they only have a very
> small change to the different pidspaces for init.

Well that depends on the implementation.  The first concern with
the implementation is of course maintainability.

But beyond that a general test to see if you have done a good
job of virtualizing something is to see if you can recurse.

One of my wish list items would be to run my things like my
web browser in a container with only access to a subset of
the things I can normally access.  That way I could be less
concerned about the latest browser security bug.

Although I do expect that just like private namespaces it will
take a while to figure out how to allow non-privileged access
to these kinds of powerful concepts.

In the bsdjail paper the point is made that as systems grow
more complex creating minimal privilege containers is easy
and simple compared to what it takes to get a complex system
up and going today.  (I expressed that badly)  

And then of course there is the other pipe dream if you can
consider the whole system in a container then you can implement
the equivalent of swsuspend by checkpointing the top level
container.

At least this should solve the classic complaint about job
control.  That it wasn't transparent to processes.

>> >> Who do you report as the source of your signal.  
>> >
>> > I've never dealt with signal enough from userspace to give you a good
>> > answer.  Can you explain the mechanics of how you would go about doing
>> > this?
>> 
>> Look at siginfo_t si_pid....
>
> Are those things that are exported outside of the kernel?  It's not
> immediately obvious.

Sorry do a man sigaction.  Basically the signal handler
needs to be configured with SA_SIGINFO but it should get
that information.  

I believe you have to 

Eric

