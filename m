Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVEABeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVEABeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVEABeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:34:03 -0400
Received: from taco.zianet.com ([216.234.192.159]:5897 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261491AbVEABd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:33:56 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Valdis.Kletnieks@vt.edu
Subject: Using git over 56k (was Re: 2.6.12-rc3-mm1)
Date: Sat, 30 Apr 2005 19:29:21 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200504301929.21462.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, Valdis  Kletnieks wrote:
>On Sat, 30 Apr 2005 08:27:43 EDT, Ed Tomlinson said:
>
>> If we stick with git it might make sense not to include a linux-patch.  cogito
>> is quite fast to export using a commit id.  Suspect some bandwidth could be 
>> saved if you just stated the commit id that you based the mm patch on.
>
>I suspect that the majority of people who build -mm kernels build -mm kernels
>because they *weren't* using BK to pull the trees they were interested in.
>
>Currently I can pull the pieces needed for a -mm kernel over a 56K modem
>without *too* much pain, which means it's something I can easily do in an
>evening.   What would be the additional disk space requirements to store enough
>of a git tree so I can pull the corresponding linus.patch myself, and how long
>would it take to do at 56K?  Also, what's the comparative CPU/bandwidth hit
>on the server end for me to download the additional data if it's bundled
>into Andrew's patch, versus me doing a 'git update' or whatever the command is?
>
>I'm suspecting that it's less strain overall to just include the 180K or so that
>the bzip'ed linus.patch takes than to make everybody pull the data needed to
>create their own linus.patch

Here is some data.  I'm on 56k dialup here at home. (I'm also not on lkml here,
so please make sure I'm on the cc-list).

I brought home a recent git repo of the linux-2.6 tree via sneaker-net yesterday, and
used cg-update to keep updated.  Here is a recent sample:

[steven@spc linux-2.6]$ cg-branch-ls
linux-2.6       rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
origin  rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
[steven@spc linux-2.6]$ time cg-update linux-2.6
MOTD:
MOTD:   Welcome to the Linux Kernel Archive.

[snipped verbose messages]

receiving file list ... done
.git/refs/heads/linux-2.6

wrote 141 bytes  read 857 bytes  285.14 bytes/sec
total size is 41  speedup is 0.04

receiving file list ... done
00/83f2ab03ca2ec99ef2d31104710cf3898ce065

[more snippage]

wrote 873 bytes  read 1096615 bytes  8540.76 bytes/sec
total size is 70393608  speedup is 64.14

[more snippage]

Tree change: 49e7dc54cd4cbdb439ecc4e06214b0ca1a1a72b4:e8e6993178344eb348f60f05b16d9dc30db3b9cf
*100644->100644 blob    8da3a306d0c0c070d87048d14a033df02f40a154->48990899db0d9a9506e72fe2fa79570c3b5a306b     Makefile
*100644->100644 blob    68e15c36e33610d6ed0ccec61d7d7a23ebcd4fa3->3b948e8c27513f7896263a87a99123ad5394b860     arch/arm/mach-integrator/integrator_cp.c
*100644->100644 blob    314c7146e9bf0a58c9df75c86065b4ad7598b419->04783ceb050c13d7a475a60bdb916b6eb56ffddf     arch/i386/Makefile
*100644->100644 blob    774de8e2387193be0570a3fba681fd6dd1936816->f850fb0fb5118be47d976291ee028697fbdeb688     arch/ppc/boot/images/Makefile
*100644->100644 blob    3e386fd4c5c6e627699ccd04117b712030f0f3f4->321dbe91dc14e270450216cf4cc79562d89ca225     drivers/video/amba-clcd.c
*100644->100644 blob    d31c1a71f781ccc7c189e3bff9dc1ee4ee282188->1ab353e235955eee63e43a3a030d0b8b4b719a2b     include/asm-arm/arch-integrator/cm.h

Applying changes...
Fast-forwarding 49e7dc54cd4cbdb439ecc4e06214b0ca1a1a72b4 -> e8e6993178344eb348f60f05b16d9dc30db3b9cf
        on top of 49e7dc54cd4cbdb439ecc4e06214b0ca1a1a72b4...
7.80user 13.43system 3:01.56elapsed 11%CPU (0avgtext+0avgdata 0maxresident)k

Three minutes isn't really bad.  If you're still using 56k, patience is required.
The machine is a 450Mhz PIII.

The size of that linux-2.6 git repo is currently 358M. 

[steven@spc GIT]$ du --max-depth=1 linux-2.6
19M     linux-2.6/fs
785K    linux-2.6/mm
168K    linux-2.6/ipc
554K    linux-2.6/lib
11M     linux-2.6/net
20K     linux-2.6/usr
130M    linux-2.6/.git
43M     linux-2.6/arch
108K    linux-2.6/init
15M     linux-2.6/sound
1.1M    linux-2.6/scripts
99M     linux-2.6/drivers
645K    linux-2.6/crypto
733K    linux-2.6/security
1.2M    linux-2.6/kernel
7.9M    linux-2.6/Documentation
32M     linux-2.6/include
358M    linux-2.6

Steven



