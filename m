Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVLGVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVLGVlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVLGVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:41:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33410 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030365AbVLGVlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:41:12 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 13:40:50 -0800
Message-Id: <1133991650.30387.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 12:19 -0700, Eric W. Biederman wrote:
> Process groups are also pids, and there are direct relationships
> between pids and process group ids and session ids.  I agree keeping
> the focus tight make sense but not so tight that you miss pieces.

There's a "reference implementation" that the kernel community hasn't
seen which is certainly not mergeable, but shows all of the pieces.
Personally, I really want to share it, and I hope that we can soon.

> >> At the current time the patch definitely fails the no in kernel
> >> users test because it doesn't go as far as taking advantage
> >> of the abstraction it attempts to introduce.  Which means
> >> other people can't read through the code and make sense
> >> of what you are trying to do or to see if there is a better way.
> >
> > This isn't excatly a new feature, nor does it add any appreciable code
> > or complexity.  I'm not sure that test even applies. 
> 
> A very common comment on the thread up to now is that people haven't
> seen the big picture so they can't comment.

Yup, this is a big issue.  I think getting that "other code" out there
is part of filling you guys in.  The other part is discussions like
this. :)

>From your comments, I can see that you have a much bigger piece of the
picture in your head than you think.

> >> Another question is how do your pid spaces nest.
> >
> > They don't, and thankfully there is anybody asking for it.  It adds
> > loads of complexity, and nobody apparently needs it.
> 
> So only very special pids can generate a pidspace.  That will
> tend to reduce the generality of the solution.  What do you do
> if I am running your code in a vserver?

I don't think it would be a good idea to stack these containers within
vservers, either.  vserver uses different pidspaces, and will use the
same infrastructure.  The only difference is that they only have a very
small change to the different pidspaces for init.

> >> Who do you report as the source of your signal.  
> >
> > I've never dealt with signal enough from userspace to give you a good
> > answer.  Can you explain the mechanics of how you would go about doing
> > this?
> 
> Look at siginfo_t si_pid....

Are those things that are exported outside of the kernel?  It's not
immediately obvious.

> >> While something allowing multiple pidspaces may be mergeable,
> >> unnecessary and incomplete changes rarely are.  This is a fundamental
> >> change to the unix API so it will take a lot of scrutiny to get
> >> merged.
> >
> > Lots of good questions.  I think we need to take some of our initial,
> > private discussions and get them out on an open list somewhere.  Any
> > suggestions?  I hate creating new sourceforge projects :)
> 
> I wonder if you could hook up with the linux vserver project.  The
> requirements are strongly similar, and making a solution that
> would work for everyone has a better chance of getting in.

Already hooked up.  They need the same stuff we want, just in smaller
quantities.  They can easily stack on top of whatever we do.

-- Dave

