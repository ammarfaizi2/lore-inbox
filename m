Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbTDOSkZ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTDOSkY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:40:24 -0400
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:28688 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S263023AbTDOSkW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:40:22 -0400
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <36696BAFD8467644ABA0050BE35890591257FD@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: Paul.McKenney@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and
 maintain backward
Date: Tue, 15 Apr 2003 13:52:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12828B52137049-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use devlabel?  It's a small userspace app which maps symlinks to
underlying disk names.  It uses Page83/Page80 data to track the true
locations of disks even if their hd/sd name changes and simply updates the
symlink to point to the right place.

devlabel to do list:
- support multipath configs (if devlabel currently finds the same uuid on 2
disks, it wont let you add a symlink to either)
- utilize sysfs info (rather than using my user apps to get 83/80 info, just
get it from sysfs)

http://www.lerhaupt.com/devlabel

Gary

---
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

