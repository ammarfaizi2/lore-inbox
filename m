Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRAKQjn>; Thu, 11 Jan 2001 11:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132388AbRAKQjd>; Thu, 11 Jan 2001 11:39:33 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:18507 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131930AbRAKQj1>; Thu, 11 Jan 2001 11:39:27 -0500
Date: Thu, 11 Jan 2001 10:39:25 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101111639.KAA72525@tomcat.admin.navo.hpc.mil>
To: phillips@innominate.de, Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@innominate.de>:
> Jamie Lokier wrote:
> > 
> > Daniel Phillips wrote:
> > >         DN_OPEN       A file in the directory was opened
> > >
> > > You open the top level directory and register for events.  When somebody
> > > opens a subdirectory of the top level directory, you receive
> > > notification and register for events on the subdirectory, and so on,
> > > down to the file that is actually modified.
> > 
> > If it worked, and I'm not sure the timing would be reliable enough, the
> > daemon would only have to have open every directory being accessed by
> > every program in the system.  Hmm.  Seems like overkill when you're only
> > interested in files that are being modified.
> 
> It gets to close some too.  Normally just the directories in the path to
> the file(s) being modified would be open.
> 
> Good point about the timing.  A directory should not disappear before an
> in-flight notification has been serviced.  I doubt the current scheme
> enforces this.  There is no more room for 'works most of the time' in
> this than there is in our memory page handling.
> 
> > It would be much, much more reliable to do a walk over d_parent in
> > dnotify.c.  Your idea is a nice way to flag kernel dentries such that
> > you don't do d_parent walks unnecessarily.
> 
> It's bottom-up vs top-down.  It's worth analyzing the top-down approach
> a little more, it does solve a lot of problems (and creates some as you
> pointed out, or at least makes some existing problems more obvious). 
> For make it's really quite nice.  The make daemon only needs to register
> in the top level directory of the source tree.  I think this solves the
> hard link problem too, because each path that's interested in
> notification will receive it.

It makes security checks impossible though. You would have to reboot
the system every time a directory changes permission to block unauthorized
monitoring of files that are no longer accessable by the user.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
