Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWCFCSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWCFCSD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 21:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWCFCSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 21:18:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21189 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751116AbWCFCSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 21:18:01 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Greg KH <gregkh@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Greg KH <greg@kroah.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
References: <20060227194623.GC9991@suse.de>
	<Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
	<20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
	<20060301003452.GG23716@kroah.com> <1141175870.2989.17.camel@entropy>
	<20060302042455.GB10464@suse.de>
	<m1fylwc1c8.fsf@ebiederm.dsl.xmission.com>
	<20060305232326.GC20768@kvack.org>
	<m1y7zoa0sf.fsf@ebiederm.dsl.xmission.com>
	<20060306003933.GE20768@kvack.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 05 Mar 2006 19:15:03 -0700
In-Reply-To: <20060306003933.GE20768@kvack.org> (Benjamin LaHaise's message
 of "Sun, 5 Mar 2006 19:39:33 -0500")
Message-ID: <m1lkvo9v4o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Sun, Mar 05, 2006 at 05:12:48PM -0700, Eric W. Biederman wrote:
>> Yes.  But it does sure stick out like a sore thumb in a patch or when
>> you try to use it.  Especially if you do something evil like require
>> user space to pass in a hash of the kernel code implementing the
>> interface.  So even the smallest changes of the implementation break
>> user space.
>
> I thought the decree / consensus was that You Can't Do That.  Yes, some 
> people want to, but that doesn't mean we should let them.

That is what I heard as well.  However look at the topic of this
thread.  Documenting various level of stability is the same as saying
something isn't stable.  Which is the same as saying something is
going to break.  So if we are going to break things on purpose we
should break them all of the time so dependencies don't build up.  So
that it is almost impossible to use unstable interfaces. 

>> I don't know all of the answers.  But if we are going to document something
>> is half backed, let have the code behave like the interface is half backed
>> and at least try to keep it out of the hands of most applications.
>
> Why should it be merged into base then?  If it's in the mainstream kernel, 
> it needs to be reasonably solid (which has always been a precondition for 
> merging patches, aiui).

I don't have a clue.

>> To a large extent I agree that we should have fully backed interfaces in
>> the stable kernel.  Is that always possible?  How often do things not show
>> up until they are being used in the real world?  Is it possible to
>> find those things out in experimental branches?
>
> There's a big difference between those interfaces that have had a decent 
> amount of thought put into them and those which have not.  Take ext2, 
> which is a good example as it can still mount a filesystem made back in 
> the early '90s today, yet it has undergone a huge amount of change.  What 
> was the secret?  The superblock has a few flags for compatible and 
> incompatible features.
>
> API design is not rocket science, it just requires effort.  So long as we 
> keep beating the drums about how important this is, people will learn and 
> we will get better at catching these issues during review.

Agreed.

However history does show that most people get API design wrong, at
least the first time.

If we were good at getting it right sys_ioctl would not be a problem,
and quite possibly would never have come into being.

So the question is can we get good enough at review that we can live
with the few mistakes that make it through?

Eric
