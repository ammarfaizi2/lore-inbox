Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSAILTD>; Wed, 9 Jan 2002 06:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSAILSx>; Wed, 9 Jan 2002 06:18:53 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:8615 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S284144AbSAILSm>; Wed, 9 Jan 2002 06:18:42 -0500
Message-ID: <3C3C2686.52491F7@u.washington.edu>
Date: Wed, 09 Jan 2002 03:16:22 -0800
From: "B. Wehrle" <bwehrle@u.washington.edu>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-34.1mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.8 fs corruption and subsequent fs problems with links
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I have scoured a bit and cannot find anyone with my similar
problem. I have read the changelogs for 2.4.x and only found a somewhat
similar
problem cropping up in 2.4.16,17, which is similar only in the respect
that the fs is
marked dirty incorrectly.

First, I am using:
Mandrake 8.1 w/ 2.4.8 kernel on Intel P3 w/ SCSI disk drive.  Fsck
reports no bad blocks on my fs's.

I have been seeing various problems with my / ext2 filesystem.  They
occur after a fsck,
and this fsck happens infrequenly.  I do not know how to make it happen
again.
  
First, the system will cleanly halt and on reboot it will report
that the filesystem is not clean.  Then it will fsck for a long time.
Fsck will complain that things are really messy and asks if I want it to
automatically clean the fs.  I always reply 'yes'.
During this time it will spit out a huge long list of inode numbers. 
This will continue for a _while_.
The system will come up in runlevel 5, but X will not start.  Tracing
this back, I find that symlinks will not work and hardlinks will not
work either.
If I do: touch foo; ln foo foobar, it will fail with error ENOENT. 
touch foo; ln -s foo foobar
will succeed, but (!) foobar will point to itself!

The reason X will not start is related to the fact that it makes several
links.  Further digging reveals that a certain file is also being
affected by fs
problem, and it is /var/log/XFree86.0.log.  EIO is returned when the
file is accessed. 
Using debugfs I can see that the file thinks it holds inode 0!  
The only way to fix the problem is to wipe out XFree86.0.log using the
kill command in debugfs (using / mounted RO).

Now This is the weird part: if you use this file (stat, cat, etc) the
symlink problem will occur. Removing the file and restarting works just
fine.  Hence, runlevel 1 is
OK because X hasn't touched that nasty file. Once the file is removed, a
debugfs "stat"
command shows that it holds an expected inode close in value to its
neighbors in the directory.  So, to repeat, if I boot in single user
mode, and don't mess with this file, I can symlink and hardlink.  If I
do touch
the file, all hell breaks loose.

This did happen when my / fs was very full- I doubt that there was more
than a few K of space on it due to a large RPM installation.  However,
new files could still be
made (using cat, etc). I ran this system with 2.2 for a year w/o a
single(!) problem.

I am not subscribed to this list, please respond to me privately.
  Thank you,
        Brian Wehrle
