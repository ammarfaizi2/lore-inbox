Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTKESmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTKESmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:42:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:17318 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263088AbTKESmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:42:07 -0500
X-Authenticated: #4512188
Message-ID: <3FA944E3.1050303@gmx.de>
Date: Wed, 05 Nov 2003 19:43:47 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <3FA8D059.7010204@cyberone.com.au> <20031105102904.GK1477@suse.de> <3FA8D2B6.5020508@gmx.de> <3FA8DB9F.1090708@cyberone.com.au>
In-Reply-To: <3FA8DB9F.1090708@cyberone.com.au>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Prakash K. Cheemplavam wrote:
> 
>> Jens Axboe wrote:
>>
>>> On Wed, Nov 05 2003, Nick Piggin wrote:
>>>
>>>>
>>>> Prakash K. Cheemplavam wrote:
>>>>
>>>>
>>>>> SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
>>>>> stutters slighty when burning (in atapi mode). I am now using as 
>>>>> sheduler. Shoudl I try deadline or do you this it is something 
>>>>> else? Should I open a new topic?
>>>>>
>>>>
>>>> This is more likely to be the CPU scheduler or something holding
>>>> interrupts for too long. Are you running anything at a modified
>>>
>>>
>>>
>>>                  ^^^^^^^^
>>>
>>> precisely, that's why the actual interface that cdrecord uses is the
>>> primary key to knowing what the problem is.
>>
>>
>>
>> As said, I'll report back later...
> 
> 
> 
> please do the following while burning is in progress
> ps -Afl > file
> and send me the file.

So here is the ps:

F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY 
TIME CMD
4 S root         1     0  0  76   0 -   365 schedu 19:21 ? 
00:00:06 init [3]
1 S root         2     1  0  94  19 -     0 ksofti 19:21 ? 
00:00:00 [ksoftirqd/0]
1 S root         3     1  0  65 -10 -     0 worker 19:21 ? 
00:00:00 [events/0]
1 S root         4     1  0  65 -10 -     0 worker 19:21 ? 
00:00:00 [kblockd/0]
1 S root         5     1  0  75   0 -     0 hub_th 19:21 ? 
00:00:00 [khubd]
1 S root         6     1  0  85   0 -     0 pdflus 19:21 ? 
00:00:00 [pdflush]
1 S root         7     1  0  75   0 -     0 pdflus 19:21 ? 
00:00:00 [pdflush]
1 S root         8     1  0  85   0 -     0 kswapd 19:21 ? 
00:00:00 [kswapd0]
1 S root         9     1  0  70 -10 -     0 worker 19:21 ? 
00:00:00 [aio/0]
1 S root        10     1  0  70 -10 -     0 worker 19:21 ? 
00:00:00 [aio_fput/0]
1 S root        11     1  0  65 -10 -     0 worker 19:21 ? 
00:00:00 [xfslogd/0]
1 S root        12     1  0  70 -10 -     0 worker 19:21 ? 
00:00:00 [xfsdatad/0]
1 S root        13     1  0  75   0 -     0 pagebu 19:21 ? 
00:00:00 [pagebufd]
1 S root        14     1  0  77   0 -     0 serio_ 19:21 ? 
00:00:00 [kseriod]
1 S root        15     1  0  77   0 -     0 down_i 19:21 ? 
00:00:00 [i2oevtd]
1 S root        16     1  0  75   0 -     0 schedu 19:21 ? 
00:00:00 [xfs_syncd]
5 S root       128     1  0  77   0 -   457 devfsd 19:21 ? 
00:00:00 /sbin/devfsd /dev
5 S root      3122     1  0  75   0 -   391 schedu 19:21 ? 
00:00:00 metalog [MASTER]
5 S root      3131  3122  0  75   0 -   385 syslog 19:21 ? 
00:00:00 metalog [KERNEL]
5 S root      3153     1  0  76   0 -  1184 schedu 19:21 ? 
00:00:00 /usr/sbin/cupsd
5 S xfs       3589     1  0  76   0 -  1893 schedu 19:21 ? 
00:00:00 /usr/X11R6/bin/xfs -daemon -config /etc/X11/fs/config -droppriv 
-user xfs -port -1
4 S root      3615     1  0  77   0 -   374 schedu 19:21 tty1 
00:00:00 /sbin/agetty 38400 tty1 linux
4 S root      3616     1  0  77   0 -   374 schedu 19:21 tty2 
00:00:00 /sbin/agetty 38400 tty2 linux
4 S root      3617     1  0  77   0 -   374 schedu 19:21 tty3 
00:00:00 /sbin/agetty 38400 tty3 linux
4 S root      3618     1  0  77   0 -   374 schedu 19:21 tty4 
00:00:00 /sbin/agetty 38400 tty4 linux
4 S root      3619     1  0  77   0 -   374 schedu 19:21 tty5 
00:00:00 /sbin/agetty 38400 tty5 linux
4 S root      3620     1  0  77   0 -   374 schedu 19:21 tty6 
00:00:00 /sbin/agetty 38400 tty6 linux
5 S root      3637     1  0  76   0 -   642 schedu 19:21 ? 
00:00:00 /usr/kde/3.1/bin/kdm
4 S root      3639  3637  2  75   0 - 71390 schedu 19:21 ? 
00:00:21 /etc/X11/X -auth /var/run/xauth/A:0-dp9cjG
5 S root      3640  3637  0  76   0 -   851 wait4  19:21 ? 
00:00:00 -:0
4 S light     3711  3640  0  82   0 -  1094 wait4  19:21 ? 
00:00:00 /bin/sh /etc/X11/Sessions/kde-3.1.4
0 S light     3733  3711  0  76   0 -  1095 wait4  19:21 ? 
00:00:00 /bin/sh --login /usr/kde/3.1/bin/startkde
1 S light     3759     1  0  77   0 -  6613 schedu 19:21 ? 
00:00:00 kdeinit: Running...
1 S light     3762     1  0  76   0 -  7092 schedu 19:21 ? 
00:00:00 kdeinit: dcopserver --nosid
1 S light     3765     1  0  76   0 -  7457 schedu 19:21 ? 
00:00:00 kdeinit: klauncher
1 S light     3767     1  0  75   0 -  7911 schedu 19:21 ? 
00:00:00 kdeinit: kded
1 S light     3773     1  0  76   0 -  7962 schedu 19:22 ? 
00:00:00 kdeinit: kxkb
1 S light     3789     1  0  76   0 -  9171 schedu 19:22 ? 
00:00:00 kdeinit: knotify
0 S light     3790  3733  0  76   0 -   362 clock_ 19:22 ? 
00:00:00 kwrapper ksmserver
1 S light     3792     1  0  76   0 -  7649 schedu 19:22 ? 
00:00:00 kdeinit: ksmserver
1 S light     3793  3759  0  75   0 -  8074 schedu 19:22 ? 
00:00:00 kdeinit: kwin
1 S light     3795     1  0  75   0 -  8277 schedu 19:22 ? 
00:00:00 kdeinit: kdesktop
1 S light     3797     1  0  75   0 -  8642 schedu 19:22 ? 
00:00:01 kdeinit: kicker
1 S light     3798  3759  0  76   0 -  6774 schedu 19:22 ? 
00:00:00 kdeinit: kio_file file 
/tmp/ksocket-light/klauncherSzBMlc.slave-socket 
/tmp/ksocket-light/kdesktop4a5OQb.slave-socket
0 S light     3799  3795  0  75   0 -  6137 schedu 19:22 ? 
00:00:00 /home/light/.kde/Autostart/gkrellm2
1 S light     3804     1  0  76   0 -  7946 schedu 19:22 ? 
00:00:00 kdeinit: klipper
1 S light     3807     1  0  76   0 -  7622 schedu 19:22 ? 
00:00:00 kalarmd --login
1 S light     3808     1  0  76   0 -  7819 schedu 19:22 ? 
00:00:00 korgac --miniicon korganizer
0 S light     3810  3759  0  77   0 -  1094 wait4  19:22 ? 
00:00:00 /bin/bash /home/light/mozilla-start
0 S light     3813  3810  0  75   0 - 27556 schedu 19:22 ? 
00:00:06 /usr/lib/mozilla/mozilla-bin
0 S light     3846     1  0  76   0 -  1651 schedu 19:22 ? 
00:00:00 /usr/libexec/gconfd-2 10
0 Z light     3856  3813  0  77   0 -     0 exit   19:22 ? 
00:00:00 [netstat] <defunct>
0 S light     3859     1  0  75   0 -   649 schedu 19:22 ? 
00:00:00 /usr/bin/esd -terminate -nobeeps -as 2 -spawnfd 43
1 S light     3869  3759  0  75   0 -  8482 schedu 19:22 ? 
00:00:01 kdeinit: konsole
0 S light     3871  3869  0  75   0 -  1145 wait4  19:22 pts/0 
00:00:00 /bin/bash
0 S light     3893  3759  1  75   0 - 13965 schedu 19:24 ? 
00:00:08 k3b
1 S light     3933  3759  0  76   0 -  6770 schedu 19:24 ? 
00:00:00 kdeinit: kio_file file 
/tmp/ksocket-light/klauncherSzBMlc.slave-socket 
/tmp/ksocket-light/k3bPj2Bsa.slave-socket
0 D light     4162  3893  0  78   0 -  1469 blk_do 19:36 ? 
00:00:00 /usr/bin/cdrecord -v gracetime=2 
dev=/dev/ide/host0/bus1/target0/lun0/cd speed=10 driveropts=burnfree 
-eject -overburn -pad -dao -data /mnt/d/livecd-2.6_10-23-2003.iso
1 S light     4163  4162  0  75   0 -  1469 clock_ 19:36 ? 
00:00:00 /usr/bin/cdrecord -v gracetime=2 
dev=/dev/ide/host0/bus1/target0/lun0/cd speed=10 driveropts=burnfree 
-eject -overburn -pad -dao -data /mnt/d/livecd-2.6_10-23-2003.iso
0 R light     4170  3871  0  77   0 -   611 -      19:37 pts/0 
00:00:00 ps -Afl



