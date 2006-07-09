Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbWGIUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWGIUCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWGIUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:02:00 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:29887 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161112AbWGIUB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:01:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7D2INpU+l+yBv350YQxcKlge5gYn3JvAW07BLB2B5Q6R68IFHHeDfAQ28bBeaKOfaCp42lWy1rbR8goFSd/22CxDvkzD2YokHpYge8EGYuGZJfKxfWkOGCD+SD5wWPWx2v+bw79TdGZyAm4+vaNevmdDzJKFpfvWJWvq3vcNFs=
Message-ID: <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
Date: Sun, 9 Jul 2006 16:01:58 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Automatic Kernel Bug Report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060709191107.GN13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >There are cases where the machine is simply dead with exactly zero
> > >information. These are the really hard ones.
> >
> > Then really there isn't anything that we can do, except to expect the
> > kindness of the user in taking a picture of his screen and posting on
> > the kernel's bugzilla.
>
> No, I'm talking about freezes without anything printed.
> As soon as anything is printed, it becomes easier.
>

Hopefully, in some bugs where nothing is printed (i.e., syslog died,
is not running, or we are in kernel context and never get back to user
mode), having a notifier on the kernel may ensure that the bug report
is sent (since we don't need userspace interaction to get it working).

> > >Then there are cases where the kernel is able to print a BUG() or Oops
> > >to a log file. Or the error message is printed to the screen and the
> > >user uses a digital camera and sends the photo.
> >
> > Then again, users may just continue using the machine (without even
> > noticing the Oops), or notice but never care to report it, or forgets,
> > etc.
>
> If the user doesn't notice what is written into his logs, the solution
> is to change this (e.g. via logcheck).
>

Sometimes the user may be just somebody that just started using linux,
or is in an industry that has nothing related to computers. He doesn't
even know that syslog exists, and even if he did, he could not even
care about it. The whole idea of the system is, in fact, not needing
interaction from the user to let the kernel development community be
acknowledged that a BUG_ON() was triggered somewhere, having a basic
set of information that could be used to debug the problem (if
somebody decides to pick a random report to take a deeper look, or
just group the reports by frequency, and take a look on the most
frequent ones).

> And if the user doesn't care, there's no reason for getting the bug
> report - a bug report from a not responsive user is worse than no bug
> report.
>

I disagree. We may not be talking about something that will bulk up
the kernel's bugzilla, so developers and bug trackers won't be
overwhelmed with a flood of less-than-ideal bug reports. We may even
have something totally unrelated with the bugzilla to keep track of
those reports. It may end up just providing statistics about the most
faulty pieces of code. Hopefully, a good set of information can be
already sufficient to have a clue on where bugs lies, and since the
report will include the (assumed) most important info needed to know,
we won't have to read more from the user. If that's not enough, we
still have the option of contacting the user to ask further details,
because the report will be signed by his e-mail (some kind of "If you
agree to have bug reports sent to linux developers, having in mind
that no confidential information is sent, sign with your e-mail on
/sys/kernel/bugreport/contact" done by initrd).

> >...
> > In resume, don't being able to investigate each report isn't a reason
> > for not being acknowledged of its existance, and even we don't
> > investigate it, having it for statistical purposes is already a great
> > deal.
>
> I'm still sure the important points are
> - developer manpower and
> - responsive bug submitters,
> and your proposal doesn't help with any of these.
>

Well, none of your proposed problems may be solved easily, which
doens't mean that the "problem" can't be ammenized. My proposal may
help _current_ developers to know that their code have actual bugs. It
doesn't obligate anybody to work on them. You may agree with me that,
considering the current number of linux users and the current number
of bug reports on mozilla, hardly 1% of bugs are reported. If I had
thousands of people using a driver that I wrote for some fancy
wireless adapter, I would like to know if people are actually getting
problems with it or not, what kind of problems, etc (and that doesn't
mean that I need to look at each of the thousands of bug reports on
the system, neither that I'm obligated to fix them), and I think that
other developers would like to know that too.

> But this is open source, so feel free to send a patch implementing your
> ideas and prove me wrong.
>

Well, even though I know that it is a good idea, I wouldn't do
anything unless I hear at least a little bunch of developers saying
that they think that this is good. The system itself is worthless if
nobody will use it, as anything else. I can do and maintain everything
by myself, I just need to know if people think that this is a good
thing to have or not (and that it would be used), since this is not
something that "well if nobody uses it, at least I can use it myself",
like a driver for an exotic device.

Independent of wheter you think that this is useful or not, do you see
any cleaner way to send those reports, having in mind that the
userspace may not be responsive ?

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
