Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271599AbRHPRzB>; Thu, 16 Aug 2001 13:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271603AbRHPRyv>; Thu, 16 Aug 2001 13:54:51 -0400
Received: from houston.jhuapl.edu ([128.244.26.10]:1278 "EHLO
	houston.jhuapl.edu") by vger.kernel.org with ESMTP
	id <S271599AbRHPRyk>; Thu, 16 Aug 2001 13:54:40 -0400
Date: Thu, 16 Aug 2001 13:54:28 -0400
From: Chris Schanzle <chris.schanzle@jhuapl.edu>
Subject: I/O causes performance problem with 2.4.8-ac3
To: linux-kernel@vger.kernel.org
Message-id: <3B7C08D4.9070303@jhuapl.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726
 Netscape6/6.1
X-Accept-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This probably belongs in the "use-once" thread...

I ran into a significant (lack of) performance situation with 2.4.8-ac3 
that does not exist with 2.4.8.  Perhaps someone can shed some light on 
what happened and how to avoid it in the future.

The system is a new dual PIII 866MHz VALinux server, 2 GB of RAM, with two 
eight-disk JBODs connected through a Mylex ExtremeRAID 2000 (i.e., not a 
pig).  I am doing testing of various kernels and filesystems (ext3, 
reiserfs) to see which will be most appropriate for production use (mostly 
as an NFS server).  Using SMP-enabled kernels.

The system had been up for several hours, I had netscape going, a few 
emacs windows, untarred and compiled a bunch of linux source trees, built 
a few RPMS, did some NFS write testing, etc.  In other words, system had 
cached a bunch of buffers.

Performance was excellent until I decided to "dd bs=1024k </dev/cdrom 
 >somefile" a 600+MB cdrom while a kernel build was going on.  It took 
nearly 7 minutes to complete the dd and near the end, the cdrom drive 
light was only occasionally flickering activity (not "on" as it was at the 
start), keystrokes were delayed, refreshes were sluggish.  "top" showed 
the loadavg was hovering around 4-5, and the top-runnng processes were 
kswapd, kreclaimd, and kjournald and they were taking 30-60% of the 
processor time.  Top also showed 3.7 MB free, 425 MB buff, and about 1.5 
GB cached.  I think the first was a "dd" to an ext3 fs, then I tried 
dumping to a reiserfs, with similar performance problems.

So this morning, I built a 2.4.8 SMP kernel with only the ext3 patches 
applied and have been unable to replicate the problem.  The "dd" completed 
in under 3 minutes, while free memory dropped to lowish-levels, 
(fluctuates between 5-20 MB), and system response and loadavg were 
"reasonable."  It appears when kswapd kicks in, I get another 5-10 MB free.

So, what is one in my situation to gather from this?

--Chris

