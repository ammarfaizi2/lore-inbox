Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTBKCGi>; Mon, 10 Feb 2003 21:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTBKCGi>; Mon, 10 Feb 2003 21:06:38 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:24559 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265777AbTBKCGf>; Mon, 10 Feb 2003 21:06:35 -0500
Date: Mon, 10 Feb 2003 21:21:58 -0500
To: linux-kernel@vger.kernel.org
Subject: No /proc/*/wchan files in 2.5.60 - dbench does nothing
Message-ID: <20030211022158.GA12425@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running dbench 64 on 2.5.60 on quad P3 xeon... 

uptime
  6:09pm  up 29 min,  1 user,  load average: 0.00, 0.00, 0.03

There are 64 dbench processes though...
rwhron@dev4-003:~$ ps aux|grep -c dbench
66

There are no files in the dbench tmp directory.
I can cp a file and mkdir with no problem.

wli suggested looking at the wchan file, but there is none.

root@dev4-003:/proc/1134# ls
cmdline  cwd  environ  exe  fd  maps  mem  mounts  root  stat  statm  status

root@dev4-003:/proc/1134# find /proc -name wchan
root@dev4-003:/proc/1134#


root@dev4-003:/proc/1134# cat status
Name:   dbench
State:  S (sleeping)
Tgid:   1134
Pid:    1134
PPid:   1109
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups: 0 1 2 3 4 6 10 1 2 3 4 6 10
VmSize:     1468 kB
VmLck:         0 kB
VmRSS:       400 kB
VmData:      100 kB
VmStk:         8 kB
VmExe:        12 kB
VmLib:      1312 kB
SigPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 8000000000000007
SigCgt: 0000000000020000
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff

root@dev4-003:/proc/1134# cat statm
367 100 340 4 0 363 0

root@dev4-003:/proc/1134# cat stat
1134 (dbench) S 1109 957 851 768 1221 256 95 0 103 0 0 1 0 0 15 0 0 0 34359 1503232 100 4294967295 134512640 134523852 3221223712 3221223520 1074715817 0 0 7 131072 3222392583 0 0 17 2 0 0

Based on 3222392583 in /proc/dbench_parent/stat, wli suggested looking for 0xC011CF07 in System.map:

root@dev4-003:/proc/1134# grep -C3 -i C011CF /boot/System.map-2.5.60
c011ca10 t wait_task_zombie
c011cb70 t wait_task_stopped
c011cce0 T sys_wait4
c011cf40 T sys_waitpid
c011cf5a t .text.lock.exit
c011d0f0 T do_getitimer
c011d1f0 T sys_getitimer
c011d260 T it_real_fn

wli said it looks like wait4 is broken.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

