Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264861AbSKFKh1>; Wed, 6 Nov 2002 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264898AbSKFKh1>; Wed, 6 Nov 2002 05:37:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:50962 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264861AbSKFKh0>;
	Wed, 6 Nov 2002 05:37:26 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error 
In-reply-to: Your message of "Wed, 06 Nov 2002 01:41:43 PDT."
             <20021106084143.GN588@clusterfs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 21:43:49 +1100
Message-ID: <24197.1036579429@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002 01:41:43 -0700, 
Andreas Dilger <adilger@clusterfs.com> wrote:
>If you don't simultaneously crash your system running ext3, and then reboot
>into a kernel which does not support ext3 you will be fine.  A clean
>shutdown will clear the "needs_recovery" flag (and any ext2-only kernel
>can blissfully use that filesystem), any ext3-aware kernel can also
>mount it again and do a journal flush, or any modern (last year or two)
>e2fsck will clean it up too (from a rescue disk if 

You are right, but the 2.4.18 kernel is lying to me.

Linux version 2.4.18-14smp (bhcompile@stripples.devel.redhat.com) (gcc
version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Wed Sep 4
12:34:47 EDT 2002
has ext2 built in but it boots with initrd containing ext3 as a module.
VFS: Mounted root (ext2 filesystem)
...
Loading jbd module
Journalled Block Device driver loaded 
Loading ext3 module
Mounting root filsystem
EXT3-fs: mounted filesystem with ordered data mode
init starts ...
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/sda1 [PASSED]
Remounting root filesystem in read-write mode:  [  OK  ]
...
# mount
/dev/sda1 on / type ext2 (rw)

VFS said that / was ext2, init ran fsck.ext2 against /, fstab says /
whoudl be ext2 and mount claims that it is ext2.  Lies!  It is still
ext3, the only indication is that lsmod shows a use count of 1 against
ext3.  Crashing out of this kernel and into 2.4.20-rc1 which has no
initrd gets the error.  And I thought I had got rid of ext3 ...

