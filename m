Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTGAS4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGAS4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:56:08 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:49321 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263338AbTGAS4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:56:05 -0400
Message-Id: <200307011911.h61JBrP8026175@pasta.boston.redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: semtimedop() support on s390/s390x
In-Reply-To: Your message of "Mon, 30 Jun 2003 15:06:09 EDT."
Date: Tue, 01 Jul 2003 15:11:53 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 30-Jun-2003 at 15:6 EDT, Pete Zaitcev wrote:

> > Date: Mon, 30 Jun 2003 14:33:28 -0400
> > From: Ernie Petrides <petrides@redhat.com>
>
> > On Friday, 27-Jun-2003 at 23:5 EDT, Pete Zaitcev wrote:
>
> > > > +-	if (call <= SEMCTL)
> > > > ++	if (call <= SEMTIMEDOP)
> > > >   		switch (call) {
> > > >  +		case SEMTIMEDOP:
> > >
> > > I guess this is the reason for the ENOSYS. Good catch!
> >
> > Thanks ... there's no substitute for actual testing.  :)
> >
> > That odd "switch-optimization" sequence in the s390x compat code
> > is also in several 2.5.73 (....) architectures, but none of
> > them have yet implemented semtimedop() support:
> >
> > 	h8300, m68k, m68knommu, sh, sparc, sparc64
> >
> > They'll all hit the same problem if/when they ever do semtimedop().
>
> What do folks think about the attached patch, then?
>
> Linus was making noises that he wishes to throttle "cleanups",
> and this is a cleanup. But still... It's contained in arch code.
> I'm pretty sure I can slip it in quietly if there's a sense
> it is likely to save us the same problem in the future.
>
> Also, I hate "<=" irrationally for some reason. I always
> use "<" and ">=". This has something to do with programming
> in pseudo-code and compiling by hand. On some brain-dead CPUs
> and with some data types it is a better comparison.
>
> I'll replicate to s390 and see if s390 -S output changes
> if the source level looks ok to Martin's & Ulrich's eyes.
>
> -- Pete

Actually, what I called the "odd switch-optimization sequence" is in
fact a lose-lose.  To clean up the code, the 3 "switch" constructs
that are guarded by 3 "if" statements should be merged into a single
conventional "switch".  On s390, this would reduce the code size by
96 bytes and only increase the .rodata section size by 88 bytes.  So,
there would be a minor memory savings, more efficient code execution,
and more maintainable source code.

Cheers.  -ernie
