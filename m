Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRGCInw>; Tue, 3 Jul 2001 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbRGCInm>; Tue, 3 Jul 2001 04:43:42 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:41484 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S265620AbRGCIng>; Tue, 3 Jul 2001 04:43:36 -0400
Date: Tue, 3 Jul 2001 03:43:35 -0500
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Recent change in directory g+s behavior (bug?)
Message-ID: <20010703034335.A3735@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere between 2.4.5-pre1 and 2.4.6-pre3, the behavior of the setgid
bit on directories has changed:

2.4.5-pre1:
# mkdir foo
# chgrp adm foo
# chmod 2775 foo
# cd foo
# ls -las
total 12
   4 drwxrwsr-x    3 root     adm          4096 Jul  3 01:11 .
   4 drwxr-xr-x    6 root     adm          4096 Jul  3 00:23 ..
# mkdir bar
# ls -las
total 12
   4 drwxrwsr-x    3 root     adm          4096 Jul  3 01:11 .
   4 drwxrwxrwt    6 root     root         4096 Jul  3 00:23 ..
   4 drwxr-sr-x    2 root     adm          4096 Jul  3 01:11 bar

2.4.6-pre3 and later, including pre9:
# mkdir foo
# chgrp adm foo 
# chmod 2775 foo
# cd foo
# ls -las 
total 12
   4 drwxrwsr-x    3 root     adm          4096 Jul  3 01:23 .
   4 drwxr-xr-x    6 root     adm          4096 Jul  3 00:38 ..
# mkdir bar
# ls -las
total 12
   4 drwxrwsr-x    3 root     adm          4096 Jul  3 01:23 .
   4 drwxrwxrwt    6 root     root         4096 Jul  3 00:38 ..
   4 drwxr-xr-x    2 root     adm          4096 Jul  3 01:23 bar

The setgid bit on directories created within g+s directories is no
longer being set, which is a marked change of behavior that breaks quite
a few things here, most notably shared CVS trees.  The group ownership
does however still seem to be inherited properly for both directories
and files.

I'm seeing a lot of VFS and ext2 work in the ChangeLog during this
kernel interval, but nothing specific to this problem.  Because of that,
I'm assuming this isn't expected behavior since it breaks many
real-world systems that I'm familiar with and differs from other Unixes
(Unices?).

I apologize for not being able to narrow down the specific kernel
revision at the moment, but I will be able to do this soon.  Is anyone
else seeing this?  Also, who would be the best person to talk to about
these issues right now (if they're not on lkml)?

Thanks very much,
-- 
Ken.
brownfld@irridia.com

