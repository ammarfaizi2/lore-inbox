Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319456AbSILGfu>; Thu, 12 Sep 2002 02:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319457AbSILGfu>; Thu, 12 Sep 2002 02:35:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40398 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319456AbSILGft>; Thu, 12 Sep 2002 02:35:49 -0400
Message-Id: <200209120640.g8C6eTD00198@eng4.beaverton.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34 
In-reply-to: Your message of "Wed, 11 Sep 2002 19:42:26 PDT."
             <3D7FFF12.24B0FDAA@digeo.com> 
Date: Wed, 11 Sep 2002 23:40:28 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kstat should be a lighter-weight per-cpu thing.  But the current
    disk accounting in there would make it 12 kilobytes per CPU.

    My vote: remove the disk accounting from kernel_stat and use this.

I have a patch from another contributor that takes disk stats out of
kstat and puts them into their own global structure.  I'll give that
some attention.

    > What follows works, but needs refinements.  Comments welcome.

    What are those refinements?

A couple I mentioned in my message: double collection of stats, and an
ugly hd_struct added to gendisk.  In addition, we should remove the
restriction on which and how many disks are reported on.

Lastly, a bit of a philosophical question.  /proc/stat and (with this
patch) /proc/diskstats provide some of the same information. Should

    a) all of it appear in /proc/stat?

    b) all of it appear in /proc/diskstats?

    c) keep the current (limited) info in /proc/stat (for backward
       compatibility) and introduce the expanded info in
       /proc/diskstats?

My preference is b, but I'm open to other opinions.

    What userspace tools are available for interpreting this
    information?

None that I'm aware of, although /proc/diskstats is formatted in a
program-friendly way.  Sample output (warning: wide):

          major minor  #blocks  name      rio   rmerge    rsect     ruse      wio   wmerge    wsect     wuse  running      use     aveq

f7d1e414    8     0          0 sda       1657     1403    46534    17391     3633     3974    61480   179110        0    34876   196501
f7c18000    8     1    2562367 sda1      1609        0    41522        0     5285        0    42280        0        0        0        0
f7c1810c    8     2          1 sda2         0        0        0        0        0        0        0        0        0        0        0
f7c18324    8     4      56196 sda4        96        0      768        0        0        0        0        0        0        0        0
f7c18430    8     5    1052226 sda5        16        0      128        0        0        0        0        0        0        0        0
f7c1853c    8     6    1052226 sda6       379        0     2802        0     2380        0    19032        0        0        0        0
f7c18648    8     7   13044748 sda7       946        0     1202        0       18        0      168        0        0        0        0

Just realized as I printed this that the first field is leftover
debugging, and should be removed!

Rick
