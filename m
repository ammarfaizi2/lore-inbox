Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310363AbSCQDSU>; Sat, 16 Mar 2002 22:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311273AbSCQDSK>; Sat, 16 Mar 2002 22:18:10 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:6664 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S310363AbSCQDRw>; Sat, 16 Mar 2002 22:17:52 -0500
Date: Sat, 16 Mar 2002 19:17:51 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /dev/md0: Device or resource busy
In-Reply-To: <E16mRJX-00082B-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203161911560.7016-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Alan Cox wrote:

> > i have 3 other md devices which i can stop no problem (even with 0xfd
> > autodetection), just not /dev/md0.
> >
> > % raidstop /dev/md0
> > /dev/md0: Device or resource busy
> >
> > i don't have any filesystem mounted on md0, and "lsof | grep md" doesn't
> > show anything.
>
> lsof isnt always the most reliable to tools if a kernel thread or nfs
> ran off with it. Is md0 doing anything else - like rebuilding. Is there
> anything that has been triggered or run from it - paticularly kernel
> threads

nothing that i'm aware of -- i've never put these devices into fstab.  i
disabled smartsuite because it was holding /dev/hdN open, but that didn't
change anything.

i just tried a "linux init=/bin/sh" boot, and it's still saying Device or
resource busy:

init-2.05a# raidstop /dev/md0
md: md0 still in use.
/dev/md0: Device or resource busy
init-2.05a# mount /proc
init-2.05a# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1]
read_ahead 1024 sectors
md0 : active raid1 hdi1[1] hde1[0]
      131392 blocks [2/2] [UU]

md1 : active raid1 hdi2[1] hde2[0]
      78045824 blocks [2/2] [UU]

md2 : active raid1 hdk1[1] hdg1[0]
      78177344 blocks [2/2] [UU]

unused devices: <none>
init-2.05a# ps auxww
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  6.9  0.1  2312 1284 ?        S    11:11   0:07 init
root         2  0.0  0.0     0    0 ?        SW   11:11   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  11:11   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  11:11   0:00 [ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   11:11   0:00 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   11:11   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   11:11   0:00 [kupdated]
root         8  0.0  0.0     0    0 ?        SW   11:11   0:00 [mdrecoveryd]
root         9  0.0  0.0     0    0 ?        SW   11:11   0:00 [raid1d]
root        10  0.0  0.0     0    0 ?        SW   11:11   0:00 [raid1d]
root        11  0.0  0.0     0    0 ?        SW   11:11   0:00 [raid1d]
root        16  0.0  0.0  2600  792 ?        R    11:13   0:00 ps auxww

-dean

