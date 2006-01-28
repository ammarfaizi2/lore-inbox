Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWA1OOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWA1OOF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 09:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWA1OOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 09:14:04 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18328 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751267AbWA1OOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 09:14:03 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Sat, 28 Jan 2006 16:13:16 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281613.16199.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old PII server box with just 32MB of RAM.

Yesterday I was preparing it for use by other people, not just me,
and went on checking and tightening filesystem permissions with
chmod -R and/or chown -R.

On deep directories box started to OOM-kill processes en masse!

I updated kernel to 2.6.15.1 - doesn't help.
I stopped some of more memory hungry processes before running
chmod -R  -  doesn't help.

Details:

2006-01-28_13:35:57.55341 kern.notice: Linux version 2.6.15.1 (root@firebird) (gcc version 3.4.1) #1 Sat Jan 28 14:01:51 EET 2006
2006-01-28_13:35:57.55380 kern.info: BIOS-provided physical RAM map:
2006-01-28_13:35:57.55391 kern.warn:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
2006-01-28_13:35:57.55402 kern.warn:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
2006-01-28_13:35:57.55413 kern.warn:  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
2006-01-28_13:35:57.55423 kern.warn:  BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
2006-01-28_13:35:57.55434 kern.warn:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
2006-01-28_13:35:57.55444 kern.warn:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
2006-01-28_13:35:57.55455 kern.warn:  BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
2006-01-28_13:35:57.55466 kern.notice: 32MB LOWMEM available.
2006-01-28_13:35:57.55474 kern.debug: On node 0 totalpages: 8192
2006-01-28_13:35:57.55483 kern.debug:   DMA zone: 4096 pages, LIFO batch:0
2006-01-28_13:35:57.55492 kern.debug:   DMA32 zone: 0 pages, LIFO batch:0
2006-01-28_13:35:57.55502 kern.debug:   Normal zone: 4096 pages, LIFO batch:0
2006-01-28_13:35:57.55511 kern.debug:   HighMem zone: 0 pages, LIFO batch:0

Here is the first OOM kill in the last test run:

13:36:00.85 ip_conntrack version 2.4 (256 buckets, 2048 max) - 216 bytes per conntrack
13:36:04.10 NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
13:36:04.10 NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
13:36:04.10 NFSD: starting 90-second grace period
13:39:27.71 SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount
13:39:28.21 SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount
13:40:26.63 SysRq : Changing Loglevel
13:40:26.64 Loglevel set to 9
13:41:07.46 oom-killer: gfp_mask=0x200d2, order=0
13:41:07.47 Mem-info:
13:41:07.47 DMA per-cpu:
13:41:07.47 cpu 0 hot: low 0, high 0, batch 1 used:0
13:41:07.47 cpu 0 cold: low 0, high 0, batch 1 used:0
13:41:07.47 DMA32 per-cpu: empty
13:41:07.47 Normal per-cpu:
13:41:07.48 cpu 0 hot: low 0, high 0, batch 1 used:0
13:41:07.48 cpu 0 cold: low 0, high 0, batch 1 used:0
13:41:07.48 HighMem per-cpu: empty
13:41:07.48 Free pages:         952kB (0kB HighMem)
13:41:07.48 Active:2217 inactive:2002 dirty:0 writeback:4 unstable:0 free:238 slab:1383 mapped:23 pagetables:243
13:41:07.48 DMA free:432kB min:360kB low:448kB high:540kB active:4556kB inactive:3988kB present:16384kB pages_scanned:390 all_unreclaimable? no
13:41:07.48 lowmem_reserve[]: 0 0 16 16
13:41:07.48 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
13:41:07.48 lowmem_reserve[]: 0 0 16 16
13:41:07.48 Normal free:520kB min:360kB low:448kB high:540kB active:4312kB inactive:4020kB present:16384kB pages_scanned:4 all_unreclaimable? no
13:41:07.48 lowmem_reserve[]: 0 0 0 0
13:41:07.48 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
13:41:07.48 lowmem_reserve[]: 0 0 0 0
13:41:07.48 DMA: 2*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 432kB
13:41:07.48 DMA32: empty
13:41:07.48 Normal: 40*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 520kB
13:41:07.48 HighMem: empty
13:41:07.48 Swap cache: add 6654, delete 6608, find 1126/2081, race 0+0
13:41:07.49 Free swap  = 92080kB
13:41:07.49 Total swap = 98296kB
13:41:07.49 Free swap:        92080kB
13:41:07.49 8192 pages of RAM
13:41:07.49 0 pages of HIGHMEM
13:41:07.49 1301 reserved pages
13:41:07.49 3949 pages shared
13:41:07.49 46 pages swap cached
13:41:07.49 0 pages dirty
13:41:07.49 4 pages writeback
13:41:07.49 23 pages mapped
13:41:07.49 1383 pages slab
13:41:07.49 243 pages pagetables
13:41:07.49 Out of Memory: Killed process 1173 (top).

Process tree on this box looks like this while I was doing tests
(PIDs won't match, I rebooted the box):

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:00 /bin/sh /init HOME=/ TERM=linux devfs=nomount
    2 ?        SWN    0:00   [ksoftirqd/0]
    3 ?        SW     0:00   [watchdog/0]
    4 ?        SW<    0:00   [events/0]
    5 ?        SW<    0:00   [khelper]
    6 ?        SW<    0:00   [kthread]
    8 ?        SW<    0:00     [kblockd/0]
  164 ?        SW<    0:00     [aio/0]
  239 ?        SW<    0:00     [kseriod]
  349 ?        SW<    0:00     [scsi_eh_0]
  387 ?        SW<    0:00     [ata/0]
  648 ?        SW<    0:00     [reiserfs/0]
  940 ?        SW     0:00     [pdflush]
  943 ?        SW     0:00     [pdflush]
 1518 ?        SW<    0:00     [nfsd4]
 1533 ?        SW<    0:00     [rpciod/0]
  163 ?        SW     0:00   [kswapd0]
  559 ?        S<     0:00   udevd
  784 ?        S      0:00   rpc.portmap
 1088 ?        S      0:00   inetd
 1118 ?        S      0:00   svscan /var/service PATH=/bin:/usr/bin
 1122 ?        S      0:00     supervise fw PATH=/bin:/usr/bin
 1123 ?        S      0:00     supervise sshd PATH=/bin:/usr/bin
 1127 ?        S      0:00       sshd -D -e -p22 -u0
 1643 ?        S      0:00         sshd -D -e -p22 -u0
 1644 pts/0    S      0:00           -bash USER=vda LOGNAME=vda HOME=/home/vda PATH=/usr/bin:/bin:/usr/sbin:/sbin MAIL=/var/mail/vda SHELL=/bin/bash SSH_CLIENT=172.17.2.38 33504 22 SSH_TTY=/dev/pts/0 TERM=xterm
 1653 pts/0    S      0:05             mc MANPATH=/usr/man HOSTNAME=pegasus.port.imtp.ilyichevsk.odessa.ua TERM=xterm SHELL=/bin/bash SSH_CLIENT=172.17.2.38 33504 22 SSH_TTY=/dev/pts/0 USER=vda LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=
 1836 pts/0    S      0:00               /bin/bash -c psahe >psahe MANPATH=/usr/man HOSTNAME=pegasus.port.imtp.ilyichevsk.odessa.ua TERM=xterm SHELL=/bin/bash SSH_CLIENT=172.17.2.38 33504 22 SSH_TTY=/dev/pts/0 USER=vda LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg
 1837 pts/0    S      0:00                 /bin/sh /home/vda/bin/psahe MANPATH=/usr/man HOSTNAME=pegasus.port.imtp.ilyichevsk.odessa.ua SHELL=/bin/bash TERM=xterm SSH_CLIENT=172.17.2.38 33504 22 SSH_TTY=/dev/pts/0 USER=vda LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.
 1838 pts/0    R      0:00                   ps -AH e --width=500 MANPATH=/usr/man HOSTNAME=pegasus.port.imtp.ilyichevsk.odessa.ua TERM=xterm SHELL=/bin/bash SSH_CLIENT=172.17.2.38 33504 22 OLDPWD=/.local/tmp SSH_TTY=/dev/pts/0 USER=vda LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:
 1839 pts/0    D      0:00                   most MANPATH=/usr/man HOSTNAME=pegasus.port.imtp.ilyichevsk.odessa.ua TERM=xterm SHELL=/bin/bash SSH_CLIENT=172.17.2.38 33504 22 OLDPWD=/.local/tmp SSH_TTY=/dev/pts/0 USER=vda LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jp
 1124 ?        S      0:00     supervise ntp PATH=/bin:/usr/bin
 1125 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1129 ?        S      0:00       multilog t n5 /var/log/service/ntp
 1131 ?        S      0:00     supervise dhcp PATH=/bin:/usr/bin
 1132 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1144 ?        S      0:00       multilog t /var/log/service/dhcp
 1145 ?        S      0:00     supervise watcher PATH=/bin:/usr/bin
 1152 ?        S      0:00       /bin/sh ./run PATH=/bin:/usr/bin
 1823 ?        S      0:00         sleep 33
 1150 ?        S      0:00     supervise klog PATH=/bin:/usr/bin
 1167 ?        S      0:00       socklog ucspi
 1151 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1158 ?        S      0:00       svlogd -tt /var/log/service/klog
 1155 ?        S      0:00     supervise syslog PATH=/bin:/usr/bin
 1168 ?        S      0:00       socklog unix /dev/log PATH=/bin:/usr/bin PWD=/.local/var/service/syslog SHLVL=0 GID=50 UID=59
 1156 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1174 ?        S      0:00       svlogd /var/log/service/syslog
 1161 ?        S      0:00     supervise pop3 PATH=/bin:/usr/bin
 1183 ?        S      0:00       tcpserver -v -R -H -l 0 -c 40 0.0.0.0 pop3 setuidgid root qmail-popup  checkpassword qmail-pop3d maildir
 1162 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1199 ?        S      0:00       multilog t /var/log/service/pop3
 1171 ?        S      0:00     supervise top PATH=/bin:/usr/bin
 1200 ?        S      0:14       top c s TERM=linux
 1172 ?        S      0:00     supervise mysql PATH=/bin:/usr/bin
 1173 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1190 ?        S      0:00       multilog t n5 /var/log/service/mysql
 1198 ?        S      0:00     supervise getty_tty2 PATH=/bin:/usr/bin
 1598 tty2     S      0:00       agetty 38400 /dev/tty2 linux TERM=linux
 1213 ?        S      0:00     supervise getty_tty3 PATH=/bin:/usr/bin
 1619 tty3     S      0:00       agetty 38400 /dev/tty3 linux TERM=linux
 1218 ?        S      0:00     supervise getty_tty4 PATH=/bin:/usr/bin
 1224 tty4     S      0:00       agetty 38400 /dev/tty4 linux TERM=linux
 1225 ?        S      0:00     supervise getty_tty5 PATH=/bin:/usr/bin
 1244 tty5     S      0:00       agetty 38400 /dev/tty5 linux TERM=linux
 1235 ?        S      0:00     supervise getty_tty6 PATH=/bin:/usr/bin
 1243 tty6     S      0:00       agetty 38400 /dev/tty6 linux TERM=linux
 1242 ?        S      0:00     supervise getty_tty7 PATH=/bin:/usr/bin
 1252 tty7     S      0:00       agetty 38400 /dev/tty7 linux TERM=linux
 1253 ?        S      0:00     supervise getty_tty8 PATH=/bin:/usr/bin
 1260 tty8     S      0:00       agetty 38400 /dev/tty8 linux TERM=linux
 1261 ?        S      0:00     supervise getty_tty1 PATH=/bin:/usr/bin
 1265 tty1     S      0:00       agetty 38400 /dev/tty1 linux TERM=linux
 1274 ?        S      0:00     supervise httpd PATH=/bin:/usr/bin
 1276 ?        S      0:00       tcpserver -v -R -H -l 0 -c 40 0.0.0.0 www setuidgid root httpd -X -f /.local/var/service/httpd/httpd.conf PATH=/bin:/usr/bin
 1275 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1277 ?        S      0:00       multilog t /var/log/service/httpd
 1278 ?        S      0:00     supervise httpd_ssl PATH=/bin:/usr/bin
 1280 ?        S      0:00       stunnel -d 443 -D 6 -p https.pem -S 0 -f -P none -N httpd -l setuidgid -- setuidgid root httpd -X -f /.local/var/service/httpd_ssl/httpd.conf
 1279 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1332 ?        S      0:00       multilog /var/log/service/httpd_ssl
 1281 ?        S      0:00     supervise qmail PATH=/bin:/usr/bin
 1282 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1303 ?        S      0:00       multilog t s300000 /var/log/service/qmail -@* status: local * remote * -@* new msg * -@* end msg * /var/log/service/qmail_nostatus -@* delivery *: success: * /var/log/service/qmail_nosuccess -@* info msg *: * -@* starting delivery *: * /var/log/service/qmail_problems
 1296 ?        S      0:00     supervise smtp PATH=/bin:/usr/bin
 1299 ?        S      0:00       tcpserver -v -R -H -l 0 -c 60 0.0.0.0 25 setuidgid mail smtpfront-qmail QMAILQUEUE=/usr/bin/qmail-scanner-queue.pl CVM_SASL_PLAIN=/usr/app/cvm-0.11/bin/cvm-unix
 1297 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1304 ?        S      0:00       multilog t s200000 /var/log/service/smtp
 1310 ?        S      0:00     supervise smb_n PATH=/bin:/usr/bin
 1311 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1348 ?        S      0:00       multilog t /var/log/service/smb_n
 1320 ?        S      0:00     supervise smb_s PATH=/bin:/usr/bin
 1321 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1365 ?        S      0:00       multilog t /var/log/service/smb_s
 1322 ?        S      0:00     supervise smb_w PATH=/bin:/usr/bin
 1323 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1363 ?        S      0:00       multilog t /var/log/service/smb_w
 1346 ?        S      0:00     supervise nfs PATH=/bin:/usr/bin
 1364 ?        S      0:00       /bin/sh ./run PATH=/bin:/usr/bin
 1542 ?        S      0:00         sleep 32000
 1380 ?        S      0:00     supervise proxy-tcp PATH=/bin:/usr/bin
 1391 ?        S      0:00       tcpserver -U -v -R -H -l 0 -c 100 0.0.0.0 9123 ./startproxy GID=50 UID=50
 1381 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1404 ?        S      0:00       multilog t /var/log/service/proxy-tcp
 1392 ?        S      0:00     supervise pgsql PATH=/bin:/usr/bin
 1393 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1414 ?        S      0:00       multilog t /var/log/service/pgsql
 1396 ?        S      0:00     supervise once PATH=/bin:/usr/bin
 1405 ?        S      0:00     supervise ovpn-1 PATH=/bin:/usr/bin
 1406 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1445 ?        S      0:00       multilog /var/log/service/ovpn-1
 1443 ?        S      0:00     supervise automount PATH=/bin:/usr/bin
 1447 ?        S      0:00       automount -f -s -v --timeout 15 /.local/mnt/auto program /root/bin/mapper.sh
 1444 ?        S      0:00     supervise log PATH=/bin:/usr/bin
 1452 ?        S      0:00       multilog t n5 /var/log/service/automount
 1121 ?        S      0:00   sleep 32000
 1524 ?        SW     0:00   [nfsd]
 1525 ?        SW     0:00   [nfsd]
 1526 ?        SW     0:00   [nfsd]
 1527 ?        SW     0:00   [nfsd]
 1532 ?        SW     0:00   [lockd]
 1534 ?        S      0:00   rpc.mountd
 1536 ?        S      0:00   rpc.statd

daemontools, bash and some other programs are compiled
againts dietlibc or uclibc. top b n1 output:

 16:01:33  up 15 min,  2 users,  load average: 0,32, 0,16, 0,17
121 processes: 120 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   3,3% user   2,4% system   0,0% nice  14,1% iowait  80,0% idle
Mem:    27564k av,   25088k used,    2476k free,       0k shrd,     936k buff
        12944k active,               2468k inactive
Swap:   98296k av,       0k used,   98296k free                    9432k cached

(swap usage is 0 here because box was just rebooted. It starts to use swap
in normal use. A few mins later: "98296k av,     152k used,   98144k free")

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 1870 root      17   0  2164 1168   804 R     8,1  4,2   0:00   0 top
    1 root      15   0  1044  616   516 S     0,0  2,2   0:00   0 init
    2 root      34  19     0    0     0 SWN   0,0  0,0   0:00   0 ksoftirqd/0
    3 root      RT   0     0    0     0 SW    0,0  0,0   0:00   0 watchdog/0
    4 root      10  -5     0    0     0 SW<   0,0  0,0   0:00   0 events/0
    5 root      11  -5     0    0     0 SW<   0,0  0,0   0:00   0 khelper
    6 root      11  -5     0    0     0 SW<   0,0  0,0   0:00   0 kthread
    8 root      10  -5     0    0     0 SW<   0,0  0,0   0:00   0 kblockd/0
  164 root      17  -5     0    0     0 SW<   0,0  0,0   0:00   0 aio/0
  163 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 kswapd0
  239 root      10  -5     0    0     0 SW<   0,0  0,0   0:00   0 kseriod
  349 root      11  -5     0    0     0 SW<   0,0  0,0   0:00   0 scsi_eh_0
  387 root      11  -5     0    0     0 SW<   0,0  0,0   0:00   0 ata/0
  559 root      16  -4   128   16     4 S <   0,0  0,0   0:00   0 udevd
  648 root      10  -5     0    0     0 SW<   0,0  0,0   0:00   0 reiserfs/0
  784 rpc       16   0  1444  560   460 S     0,0  2,0   0:00   0 rpc.portmap
  940 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 pdflush
  943 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 pdflush
 1088 root      18   0  1344  460   384 S     0,0  1,6   0:00   0 inetd
 1118 root      16   0   132   24     8 S     0,0  0,0   0:00   0 svscan
 1121 root      18   0  1816  464   388 S     0,0  1,6   0:00   0 sleep
 1122 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1123 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1124 root      18   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1125 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1127 root      16   0  2568 1192   940 S     0,0  4,3   0:01   0 sshd
 1129 daemon    18   0   108   28    16 S     0,0  0,1   0:00   0 multilog
 1131 root      18   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1132 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1144 daemon    17   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1145 root      16   0   100   20     8 S     0,0  0,0   0:00   0 supervise
 1150 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1151 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1152 root      16   0  1048  624   524 S     0,0  2,2   0:00   0 run
 1155 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1156 root      16   0   100   20     8 S     0,0  0,0   0:00   0 supervise
 1158 logger    18   0   120   40    20 S     0,0  0,1   0:00   0 svlogd
 1161 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1162 root      16   0   104   16     8 S     0,0  0,0   0:00   0 supervise
 1167 root      16   0   116   32    12 S     0,0  0,1   0:00   0 socklog
 1168 logger    16   0   120   32    12 S     0,0  0,1   0:00   0 socklog
 1171 root      16   0   104   16     8 S     0,0  0,0   0:00   0 supervise
 1172 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1173 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1174 logger    18   0   116   40    20 S     0,0  0,1   0:00   0 svlogd
 1183 root      17   0   128   48    32 S     0,0  0,1   0:00   0 tcpserver
 1190 daemon    17   0   108   28    16 S     0,0  0,1   0:00   0 multilog
 1198 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1199 mail      15   0   108   28    16 S     0,0  0,1   0:00   0 multilog
 1200 user0     17   0  1840 1004   728 S     0,0  3,6   0:14   0 top
 1213 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1218 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1224 root      16   0  1312  456   380 S     0,0  1,6   0:00   0 agetty
 1225 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1235 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1242 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1243 root      16   0  1308  452   380 S     0,0  1,6   0:00   0 agetty
 1244 root      16   0  1312  456   380 S     0,0  1,6   0:00   0 agetty
 1252 root      16   0  1312  456   380 S     0,0  1,6   0:00   0 agetty
 1253 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1260 root      16   0  1308  452   380 S     0,0  1,6   0:00   0 agetty
 1261 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1265 root      17   0  1308  452   380 S     0,0  1,6   0:00   0 agetty
 1274 root      16   0   100   20     8 S     0,0  0,0   0:00   0 supervise
 1275 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1276 root      15   0   124   40    32 S     0,0  0,1   0:00   0 tcpserver
 1277 apache    17   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1278 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1279 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1280 root      16   0  2888 1340  1072 S     0,0  4,8   0:00   0 stunnel
 1281 root      18   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1282 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1296 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1297 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1299 root      18   0   128   40    28 S     0,0  0,1   0:00   0 tcpserver
 1303 mail      17   0   116   36    16 S     0,0  0,1   0:00   0 multilog
 1304 mail      17   0   112   36    16 S     0,0  0,1   0:00   0 multilog
 1310 root      17   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1311 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1320 root      17   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1321 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1322 root      17   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1323 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1332 apache    17   0   112   36    16 S     0,0  0,1   0:00   0 multilog
 1346 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1348 logger    17   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1363 logger    17   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1364 root      16   0  1056  628   520 S     0,0  2,2   0:00   0 run
 1365 logger    17   0   112   36    16 S     0,0  0,1   0:00   0 multilog
 1380 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1381 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1391 daemon    18   0   124   36    28 S     0,0  0,1   0:00   0 tcpserver
 1392 root      18   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1393 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1396 root      17   0   104   24     8 S     0,0  0,0   0:00   0 supervise
 1404 daemon    16   0   108   28    16 S     0,0  0,1   0:00   0 multilog
 1405 root      18   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1406 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1414 mysql     15   0   112   36    16 S     0,0  0,1   0:00   0 multilog
 1443 root      16   0   100   16     8 S     0,0  0,0   0:00   0 supervise
 1444 root      16   0   104   20     8 S     0,0  0,0   0:00   0 supervise
 1445 daemon    15   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1447 root      16   0  1440  648   540 S     0,0  2,3   0:00   0 automount
 1452 logger    16   0   112   32    16 S     0,0  0,1   0:00   0 multilog
 1518 root      10  -5     0    0     0 SW<   0,0  0,0   0:00   0 nfsd4
 1524 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 nfsd
 1525 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 nfsd
 1526 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 nfsd
 1527 root      15   0     0    0     0 SW    0,0  0,0   0:00   0 nfsd
 1532 root      16   0     0    0     0 SW    0,0  0,0   0:00   0 lockd
 1533 root      11  -5     0    0     0 SW<   0,0  0,0   0:00   0 rpciod/0
 1534 root      17   0  1512  584   408 S     0,0  2,1   0:00   0 rpc.mountd
 1536 root      16   0  3380 1392   952 S     0,0  5,0   0:00   0 rpc.statd
 1542 root      18   0  1816  464   388 S     0,0  1,6   0:00   0 sleep
 1598 root      16   0  1312  456   380 S     0,0  1,6   0:00   0 agetty
 1619 root      16   0  1308  452   380 S     0,0  1,6   0:00   0 agetty
 1644 root      16   0  1152  824   596 S     0,0  2,9   0:00   0 bash
 1653 root      15   0  1412  948   592 S     0,0  3,4   0:05   0 mc
 1854 root      18   0  1816  464   388 S     0,0  1,6   0:00   0 sleep
 1869 root      18   0  1052  572   468 S     0,0  2,0   0:00   0 bash
--
vda
