Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSJ0WeE>; Sun, 27 Oct 2002 17:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSJ0WeE>; Sun, 27 Oct 2002 17:34:04 -0500
Received: from burfw1-ext.castandcrew.com ([63.109.215.130]:20475 "EHLO
	gopher.unnerving.org") by vger.kernel.org with ESMTP
	id <S262679AbSJ0WeD>; Sun, 27 Oct 2002 17:34:03 -0500
Subject: bizzare slowdowns and hangs w/ 2.4.18, 2.4.19
From: "Gregory K. Ade" <gregory@castandcrew.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Oct 2002 15:40:23 -0800
Message-Id: <1035762024.3397.53.camel@gopher>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am posting this here somewhat out of desperation, as I'm trying to
find a good explaination for some bizzare slowdowns and lockups and have
been turning up empty so far.

We have a Dell PowerEdge 6600, 4x 1.6HGz Xeon, 8GB RAM, PERC3/DCL
(MegaRAID) controller with 128MB cache, driving two channels each with 3
36GB 15krpm UltraSCSI/LVD 160 drives.  I currently have 8GB of swapspace
set up (4 2gb swapspaces, in descending priority.)  It's a real beast.

When it's been running for a couple hours, doing a `find /` will drag it
to it's knees, as evidenced by this scraping from top during one of it's
bad moments:

--->8--[ Cut Here ]--->8--
  1:17pm  up 14:34,  4 users,  load average: 0.83, 0.98, 1.11
78 processes: 76 sleeping, 1 running, 1 zombie, 0 stopped
CPU0 states:  0.0% user, 53.0% system,  0.0% nice, 46.0% idle
CPU1 states:  0.1% user, 41.1% system,  0.0% nice, 57.0% idle
CPU2 states:  0.1% user, 42.0% system,  0.0% nice, 56.1% idle
CPU3 states:  0.0% user, 41.1% system,  0.0% nice, 58.0% idle
Mem:  7762204K av, 7756320K used,    5884K free,       0K shrd,  236704K buff
Swap: 8388544K av,     432K used, 8388112K free                 7260064K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 8595 gregory    9   0   664  664   528 D    41.3  0.0   0:02 find /usr
 7195 root       9   0  2080 2080  1476 S    40.2  0.0   0:02 /usr/sbin/sshd
  333 root       9   0 15252  14M 15072 D    35.0  0.1   0:38 /usr/sbin/MegaSer
 7115 root      10   0  2092 2092  1476 S    28.1  0.0   0:25 /usr/sbin/sshd
    7 root      15   0     0    0     0 SW   22.9  0.0   3:06 kswapd
 7300 root      10   0   928  928   720 R    14.9  0.0   1:19 top
    1 root       8   0   224  224   184 S     0.0  0.0   1:21 init [3]
    2 root       9   0     0    0     0 SW    0.0  0.0   0:01 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      18  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
--->8--[ Cut Here ]--->8--

This was still on it's way to total oblivion.  Once it's _at_ oblivion,
all 4 CPU's are at 100% system, with find, kswapd and kupdated usually
the top three processes, but always find & kswapd are up at the top.

Something as simple as a find should not do this, and doesn't, even on
much whimpier machines (single 300mhz P-III with a single IDE drive &
128MB ram doesn't even break a sweat.)

Software: Kernel v. 2.4.19 (from kernel.org), patched with LVM 1.0.5 and
Dell's BroadCom Gigabit Ethernet drivers.  Userland LVM tools are from
the same 1.0.5 sources.  Using the kernel megaraid driver for the RAID
controller.

So far, on the advice of one of the Dell developers for the megaraid
driver, I've tried flashing the PERC card back to firmware 1.61O (it
shipped with 1.72).  This didn't seem to have much positive effect. 
I've since flashed up to 1.73, and am letting the system warm up a bit
to see if it'll have any affect.

The problem never manifests itself within an hour so or so of startup,
but after a certain amount of time, it becomes progressively more
noticable.  After 21 days of uptime, the system became so unresponsive
on a Thursday morning (our busiest day) that we had to restart.

So, what other information can I provide to make the problem more
diagnosable, and where else can I look for an explaination?

I have been unable to replicate this on any other hardware.  I have at
least three other systems running the same version of SuSE Linux (7.2),
all with the same version of the kernel and LVM as mentioned above. 
Unfortunately, this Dell PE6600 is the only one of its kind that we
own...

Thanks in advance for any help.  Feel free to reply to the list, as I am
subscribed.

-- 
Gregory K. Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

