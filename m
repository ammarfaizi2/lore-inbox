Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTDLBF5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTDLBF4 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 21:05:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30147 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262219AbTDLBFy (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 21:05:54 -0400
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward
 compatibility
To: Andries.Brouwer@cwi.nl
Cc: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAD4FBC86.382E53DF-ON88256D06.0006AAF3@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Fri, 11 Apr 2003 18:13:24 -0700
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 04/11/2003 19:13:00
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > It would also be nice for numeric compatibility to be a compile time
option
>
> It sounds as if you expect a lot of old cruft.
> But the compatibility code is just ten lines or so.
> Internally the kernel has an index. Externally there is a dev_t.
> At open() time the dev_t is converted. At registration time
> sd announces interest in three or four dev_t regions.
> That is all.

Some compatibility needs more code than other compatibility.
The desired compatibility includes the following, much of which
has been noted earlier in this thread, and some of which may
need to wait for multipath I/O and other of which might be best
provided by a volume manager:

o     It must be possible to switch between 2.4 and 2.5/6
      kernels without a given disk's name changing.

o     New 2.5/6 installations should se a clean disk naming
      scheme without historical cruft.

o     Removing or adding one disk should not affect the
      names of other disks.  Ideally, moving a given disk
      from one place to another should not change its
      name.  "The good news is that we repaired your
      disk.  The bad news is that, due to the resulting
      name changes, your application thoroughly
      corrupted all of its data."

o     Adding or removing a FC or SCSI adapter should not
      affect the names of disks hanging off of other
      FC or SCSI controllers.  Ideally, the name of
      a disk should not change when its FC or SCSI
      controller is moved from one slot to another.

o     Failures of or repairs to the FC fabric should
      not change the names of any of the disks (though
      a sufficiently thorough failure might make some
      of the disks unreachable).

o     Cluster nodes should ideally have the same name
      for a given disk.  Extra credit, though greatly
      appreciated by anyone who has ever had to deal
      with a cluster where different nodes have different
      names for the same disk.  ;-)

                              Thanx, Paul

