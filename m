Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270687AbTGNQrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270679AbTGNQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:46:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:36512 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270667AbTGNQpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:45:20 -0400
From: neilb@cse.unsw.edu.au (Neil F. Brown)
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 15 Jul 2003 03:00:01 +1000
Message-Id: <1030714170001.24267@cse.unsw.edu.au>
Subject: ANNOUNCE: nfs-utils 1.0.4
cc: Janusz Niewiadomski <funkysh@isec.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release of nfs-utils contains:

 1/ Fix for a remotely exploitable buffer-overflow bug.
 2/ assorted minor bug fixes
 3/ Extensive changes to make use of new functionality in linux-2.6.0 nfsd

nfs-utils 1.0.4 can be downloaded from 
  http://sourceforge.net/project/showfiles.php?group_id=14
or
  http://www.{countrycode}.kernel.org/pub/linux/utils/nfs/

I consider this release to be a pre-release for 1.1.0 which I hope to
release before linux-2.6.0-final.  Bug reports are very welcome.


1/ A buffer-overflow bug was found by 
    Janusz Niewiadomski
    iSEC Security Research
    http://isec.pl/

  It is trivially exploitable to effect a remote denial of service.
  More subtle exploits may be possible.

  I recommend that all users of nfs-utils either:
    1/ upgrade to 1.0.4 
  or
    2/ Get an update from their vendor (most vendors should have an
       update available).

  I also recommend that all NFS services be protected from the
  internet-at-large by a firewall where that is possible.

2/ See the change log in the source for details on bug fixes.

3/ In 2.4 and earlier kernels, the nfs server needed to know about any
 client that expected to be able to access files via NFS.  This
 information would be given to the kernel by "mountd" when the client
 mounted the filesystem, or by "exportfs" at system startup.  exportfs
 would take information about active clients from /var/lib/nfs/rmtab.

 This approach is quite fragile as it depends on rmtab being correct
 which is not always easy, particularly when trying to implement
 fail-over.  Even when the system is working well, rmtab suffers from
 getting lots of old entries that never get removed.

 With 2.6 we have the option of having the kernel tell mountd when it
 gets a request from an unknown host, and mountd can give appropriate
 export information to the kernel.  This removes the dependancy on
 rmtab and means that the kernel only needs to know about currently
 active clients.

 To enable this new functionality, you need to:
   mount -t nfsd nfsd /proc/fs/nfs

 before running exportfs or mountd.  

 If you are using 2.6.0-testX and exporting files with NFS *please*
 test this out and let me know of any problems.

NeilBrown - July 2003

