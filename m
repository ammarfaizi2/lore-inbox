Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbULGQTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbULGQTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbULGQTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:19:49 -0500
Received: from viking.sophos.com ([194.203.134.132]:32274 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261852AbULGQTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:19:46 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 07/12/2004 16:19:34,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 07/12/2004 16:19:34,
	Serialize complete at 07/12/2004 16:19:34,
	S/MIME Sign failed at 07/12/2004 16:19:34: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 07/12/2004 16:19:40,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 07/12/2004 16:19:40,
	Serialize complete at 07/12/2004 16:19:40,
	S/MIME Sign failed at 07/12/2004 16:19:40: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 07/12/2004 16:19:45,
	Serialize complete at 07/12/2004 16:19:45
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, viro@math.psu.edu
Subject: Strange NFS(D) behaviour
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF973958E1.9601CF51-ON80256F63.0058704F-80256F63.0059B12C@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Tue, 7 Dec 2004 16:19:40 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to everyone, and apologies to the ones I didn't have to CC!

I am experiencing a strange behaviour in a interaction of kernel 2.6.8.1 
(2.6.9 also tested) and util-linux 2.12c. It is 100% reproducable.

The setup:

Reboot.

start portmapper
start nfsserver (kernel one)

cat /etc/exports
/test   127.0.0.1(rw,all_squash,async)

ls -ld /test
drwxr-xr-x 3 root root 96 2004-12-06 14:59 /test

ls -l /test
total 4
-rw-r--r-- 1 root root 11 2004-12-06 14:59 a
drwxr-xr-x 2 root root 48 2004-12-06 14:59 mnt

cd /test
mount localhost:/test mnt
find
umount mnt
umount: /test/mnt: device is busy
umount: /test/mnt: device is busy
umount -l mnt (ok)
mount localhost:/test mnt
find
umount mnt (ok)

And it is now impossible to get -EBUSY on umount. Also, before the first 
umount -l mnt invocation, it is impossible to un-mount mnt without 
specifying "-l" no matter how long I wait, or how much I try.

I found this strange, the behavior should be consistent, no?



