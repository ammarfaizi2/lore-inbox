Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263520AbTDMOH6 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDMOH6 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:07:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17809 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263520AbTDMOHx (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 10:07:53 -0400
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain	backward
 compatibility
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andries.Brouwer@cwi.nl, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF85D814FD.F3C3D932-ON88256D07.004CD13F@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Sun, 13 Apr 2003 06:59:25 -0700
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 04/13/2003 08:14:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> On Fri, 2003-04-11 at 20:13, Paul McKenney wrote:
> > Some compatibility needs more code than other compatibility.
> > The desired compatibility includes the following, much of which
> > has been noted earlier in this thread, and some of which may
> > need to wait for multipath I/O and other of which might be best
> > provided by a volume manager:
>
> We're talking about two types of compatibility.  The first (which
> everyone agrees on) is that /dev names don't change between 2.4 and
> 2.5.  The second is direct numerical compatibility so that a /dev still
> using the old 8:8 scheme works.
>
> What you're asking for is more a wish list of enhancements:

True, and the more disks one has, the more one would be wishing
for them.

> > o     It must be possible to switch between 2.4 and 2.5/6
> >       kernels without a given disk's name changing.
>
> By and large, this is true.  There will be problems where probe order
> has altered because of changes to bus enumeration schemes or for other
> reasons.

Exactly.

> > o     New 2.5/6 installations should se a clean disk naming
> >       scheme without historical cruft.
>
> They'll all see /dev/sd<A>[n] as in 2.4
>
> > o     Removing or adding one disk should not affect the
> >       names of other disks.  Ideally, moving a given disk
> >       from one place to another should not change its
> >       name.  "The good news is that we repaired your
> >       disk.  The bad news is that, due to the resulting
> >       name changes, your application thoroughly
> >       corrupted all of its data."
>
> True until a reboot, as in 2.4

Again, exactly.  The current state requires the sysadm to
disable the application automatically running on reboot so
that the application's pathnames could be changed -- after
the sysadm works out what the names have changed to.  Ouch.

This does not necessarily need to be done in the kernel,
one could use a volume manager as noted above, or udev
with appropriate plugins, as you noted below.

> > o     Adding or removing a FC or SCSI adapter should not
> >       affect the names of disks hanging off of other
> >       FC or SCSI controllers.  Ideally, the name of
> >       a disk should not change when its FC or SCSI
> >       controller is moved from one slot to another.
>
> That's not a 2.4 guarantee, it won't be a 2.5 one.

Again, one really does not want to have to figure out
which disk changed to what name, then hand-edit all
mount commands, application config files, etc. to change
all the disk and partition names.

And again, something like udev or a volume manager might
be appropriate if this functionality is not to be provided
by the base kernel itself.

> > o     Failures of or repairs to the FC fabric should
> >       not change the names of any of the disks (though
> >       a sufficiently thorough failure might make some
> >       of the disks unreachable).
>
> True until reboot, as in 2.4

See above...

> > o     Cluster nodes should ideally have the same name
> >       for a given disk.  Extra credit, though greatly
> >       appreciated by anyone who has ever had to deal
> >       with a cluster where different nodes have different
> >       names for the same disk.  ;-)
>
> That has never been true in Linux, and not in most commerical unixes,
> either.  Cluster tools are used to do this mapping and most commercially
> available linux cluster tools solve this problem, so there's no need for
> the kernel to do it.
>
> A lot of these enhancements will be covered (or at least a solution will
> be facilitated) by udev.  See
>
> http://marc.theaimsgroup.com/?t=105003184600001&r=1&w=2
>
> (unfortunately, the announcement thread has grown rather big).

Yes, given a plugin that used SCSI's UUID, this could work quite well.

                                    Thanx, Paul

