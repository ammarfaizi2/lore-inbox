Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTBREXR>; Mon, 17 Feb 2003 23:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTBREXR>; Mon, 17 Feb 2003 23:23:17 -0500
Received: from dsl093-081-236.chi2.dsl.speakeasy.net ([66.93.81.236]:11392
	"EHLO server1.skippy.net") by vger.kernel.org with ESMTP
	id <S267607AbTBREW5>; Mon, 17 Feb 2003 23:22:57 -0500
Message-ID: <33000.66.93.81.185.1045542660.squirrel@www.skippy.net>
Date: Mon, 17 Feb 2003 23:31:00 -0500 (EST)
Subject: kernel oops: kswapd (?)
From: "Scott Merrill" <skippy@skippy.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030217233100_29119"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20030217233100_29119
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

To whom it may concern:
Please accept my sincere apologies if any necessary information is
omitted.  This is my first oops submission.  I will gladly provide any
missing information.

I was copying ogg vorbis files freshly ripped from my desktop to my
server, Debian 'woody' running on a Pentium II 450MHz box with 512MB RAM. 
The scp process aborted. "Weird," though I, so I started it again.  It
aborted a second time.  "Not good," thought I.

tail /var/log/messages on the server reported the following:
Feb 17 21:29:07 server1 kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Feb 17 21:29:07 server1 kernel:  printing eip:
Feb 17 21:29:07 server1 kernel: c013f600
Feb 17 21:29:07 server1 kernel: Oops: 0000
Feb 17 21:29:07 server1 kernel: CPU:    0
Feb 17 21:29:07 server1 kernel: EIP:    0010:[prune_dcache+16/296]    Not
tainted
Feb 17 21:29:07 server1 kernel: EFLAGS: 00010213
Feb 17 21:29:07 server1 kernel: eax: 0000224c   ebx: 00000000   ecx:
00000006   edx: 00000002
Feb 17 21:29:07 server1 kernel: esi: 000001f0   edi: 00000020   ebp:
0000224c   esp: c857fe50
Feb 17 21:29:07 server1 kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 21:29:07 server1 kernel: Process sshd (pid: 29389, stackpage=c857f000)
Feb 17 21:29:07 server1 kernel: Stack: 00000019 000001f0 00000020 00000006
c013f96b 0000224c c0129eb6 00000006
Feb 17 21:29:07 server1 kernel:        000001f0 00000006 000001f0 c01f2948
c01f2948 c01f2948 c0129f0f 00000020
Feb 17 21:29:07 server1 kernel:        c857e000 00000120 00000000 c012a722
c01f2aa4 00000120 00000010 00000000
Feb 17 21:29:07 server1 kernel: Call Trace: [shrink_dcache_memory+27/52]
[shrink_caches+102/136] [try_to_free_pages+55/88]
[balance_classzone+78/360] [sock_alloc_send_pskb+112/440]
Feb 17 21:29:07 server1 kernel:    [__alloc_pages+262/356]
[_alloc_pages+22/24] [__get_free_pages+10/24] [__pollwait+51/140]
[tcp_poll+46/340] [sock_sendmsg+105/136]
Feb 17 21:29:07 server1 kernel:    [sock_poll+35/40] [do_select+226/476]
[sys_select+802/1124] [system_call+51/56]
Feb 17 21:29:07 server1 kernel:
Feb 17 21:29:07 server1 kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b
89 5b 04 8d 73 e8 8b 46

I thought perhaps something was wrong with the disk or partition
(/dev/hdc1) that I was copying these .ogg files to, so I tried to umount
it.

A quick message to my local LUG and some googling pointed me toward
ksymoops.  I didn't have it installed, so I tried to apt-get it:
skippy@server1:/tmp/ksymoops-2.4.8$ sudo apt-get install ksymoops
Reading Package Lists... Done
Building Dependency Tree... Done
The following NEW packages will be installed:
  ksymoops
0 packages upgraded, 1 newly installed, 0 to remove and 0  not upgraded.
Need to get 0B/174kB of archives. After unpacking 382kB will be used.
Selecting previously deselected package ksymoops.
(Reading database ... 32862 files and directories currently installed.)
Unpacking ksymoops (from .../ksymoops_2.4.5-1_i386.deb) ...
E: Sub-process /usr/bin/dpkg received a segmentation fault.

Maybe I can compile from source, you say?  No such luck, since the
kernel.org source version of ksymoops requires the Debian binutils-dev
package, which apt-get also segfaults on:
skippy@server1:/tmp/ksymoops-2.4.8$ sudo apt-get install binutils-dev
Reading Package Lists... Done
Building Dependency Tree... Done
The following NEW packages will be installed:
  binutils-dev
0 packages upgraded, 1 newly installed, 0 to remove and 0  not upgraded.
Need to get 313kB of archives. After unpacking 954kB will be used.
Get:1 http://mirrors.kernel.org stable/main binutils-dev 2.12.90.0.1-4
[313kB]
Fetched 313kB in 6s (51.1kB/s)
E: Sub-process /usr/bin/dpkg received a segmentation fault.

I tried to apt-get ksymoops twice, then binutils-dev twice, and finally
ksymoops once more.  Silly, I know.

More posting to my LUG ensues.  I'm told that I can reboot provided I save
the oops with a 'dmesg > oops.txt', which is attached.

After rebooting, I was able to install the ksymoops package.  The output
is attached as ksymoops.txt.

I realize now that my initial diagnosis was too shallow, and that I should
have tailed a bit further up into /var/log/messages and /var/log/kern.log.
 I originally thought the problem was with ssh, or with the drive or
partition (/dev/hdc1) I was copying to.  Looking through the ksymoops.txt
file, I see that the original problem was kswapd.

If I've omitted anything, please let me know!  I'll help however I can!


------=_20030217233100_29119
Content-Type: text/plain; name="oops.txt"
Content-Disposition: attachment; filename="oops.txt"

00 PREC=0x00 TTL=48 ID=44463 PROTO=UDP SPT=2605 DPT=135 LEN=88 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.74.63.207 DST=66.93.81.236 LEN=108 TOS=0x00 PREC=0x00 TTL=48 ID=45524 PROTO=UDP SPT=2605 DPT=135 LEN=88 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.74.63.207 DST=66.93.81.236 LEN=108 TOS=0x00 PREC=0x00 TTL=48 ID=47726 PROTO=UDP SPT=2605 DPT=135 LEN=88 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.74.63.207 DST=66.93.81.236 LEN=116 TOS=0x00 PREC=0x00 TTL=48 ID=50628 PROTO=UDP SPT=2605 DPT=135 LEN=96 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=157.134.168.109 DST=66.93.81.236 LEN=404 TOS=0x00 PREC=0x00 TTL=113 ID=45762 PROTO=UDP SPT=3010 DPT=1434 LEN=384 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.186.229.11 DST=66.93.81.236 LEN=48 TOS=0x10 PREC=0x00 TTL=114 ID=43250 DF PROTO=TCP SPT=4662 DPT=21 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.186.229.11 DST=66.93.81.236 LEN=48 TOS=0x10 PREC=0x00 TTL=114 ID=43577 DF PROTO=TCP SPT=4662 DPT=21 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.186.229.11 DST=66.93.81.236 LEN=48 TOS=0x10 PREC=0x00 TTL=114 ID=43900 DF PROTO=TCP SPT=4662 DPT=21 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=128.211.197.213 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=117 ID=28940 DF PROTO=TCP SPT=2349 DPT=1433 WINDOW=64512 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=128.211.197.213 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=117 ID=29343 DF PROTO=TCP SPT=2349 DPT=1433 WINDOW=64512 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.120.109.81 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=112 ID=36868 DF PROTO=TCP SPT=40401 DPT=57 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.120.109.81 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=112 ID=37318 DF PROTO=TCP SPT=40401 DPT=57 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=212.120.109.81 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=112 ID=38234 DF PROTO=TCP SPT=40401 DPT=57 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=61.174.134.74 DST=66.93.81.236 LEN=404 TOS=0x00 PREC=0x00 TTL=112 ID=20526 PROTO=UDP SPT=2846 DPT=1434 LEN=384 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=81 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=1080 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=1180 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=3128 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=4480 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=6588 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=8000 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=8080 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=24.30.199.228 DST=66.93.81.236 LEN=40 TOS=0x00 PREC=0x00 TTL=37 ID=30583 DF PROTO=TCP SPT=2049 DPT=8081 WINDOW=16384 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=195.245.179.61 DST=66.93.81.236 LEN=404 TOS=0x00 PREC=0x00 TTL=104 ID=9534 PROTO=UDP SPT=2940 DPT=1434 LEN=384 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=72 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35443 LEN=52 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=72 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35443 LEN=52 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=72 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35484 LEN=52 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=72 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35484 LEN=52 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=74 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35491 LEN=54 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=64.81.159.2 DST=66.93.81.236 LEN=74 TOS=0x00 PREC=0x00 TTL=62 ID=0 DF PROTO=UDP SPT=53 DPT=35491 LEN=54 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=128.211.197.172 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=117 ID=19180 DF PROTO=TCP SPT=1427 DPT=1433 WINDOW=64240 RES=0x00 SYN URGP=0 
Shorewall:net2all:DROP:IN=eth0 OUT= MAC=00:00:c0:c8:95:b1:00:10:67:00:ba:41:08:00 SRC=128.211.197.172 DST=66.93.81.236 LEN=48 TOS=0x00 PREC=0x00 TTL=117 ID=19315 DF PROTO=TCP SPT=1427 DPT=1433 WINDOW=64240 RES=0x00 SYN URGP=0 
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013f608
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013f608>]    Not tainted
EFLAGS: 00010216
eax: c01f35fc   ebx: d463ae58   ecx: cd81b020   edx: 00000000
esi: d49a83e0   edi: 00000000   ebp: 000026b2   esp: c1831f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1831000)
Stack: 0000000e 000001d0 00000015 00000005 c013f96b 000029bd c0129eb6 00000005 
       000001d0 00000005 000001d0 c01f2948 00000000 c01f2948 c0129f0f 00000015 
       c01f2948 00000001 c1830000 c0129fa3 c01f28a0 00000000 c1830249 0008e000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c0129fa3>] [<c0129ffe>] 
   [<c012a10d>] [<c0105688>] 

Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a8 08 74 27 24 f7 89 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 00002249   ebx: 00000000   ecx: 00000006   edx: 00000001
esi: 000001f0   edi: 00000020   ebp: 00002249   esp: d9fc3e50
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 29319, stackpage=d9fc3000)
Stack: 00000019 000001f0 00000020 00000006 c013f96b 00002249 c0129eb6 00000006 
       000001f0 00000006 000001f0 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       d9fc2000 00000120 00000000 c012a722 c01f2aa4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c012a9aa>] [<c013c027>] [<c019e8da>] [<c01834af>] [<c013c206>] 
   [<c013c64a>] [<c0106d2b>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000224c   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001f0   edi: 00000020   ebp: 0000224c   esp: c857fe50
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 29389, stackpage=c857f000)
Stack: 00000019 000001f0 00000020 00000006 c013f96b 0000224c c0129eb6 00000006 
       000001f0 00000006 000001f0 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       c857e000 00000120 00000000 c012a722 c01f2aa4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c018540c>] 
   [<c012a942>] [<c012a6d2>] [<c012a9aa>] [<c013c027>] [<c019e8da>] [<c0183095>] 
   [<c01834af>] [<c013c206>] [<c013c64a>] [<c0106d2b>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013f8f3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f8f3>]    Not tainted
EFLAGS: 00010202
eax: d67c3cf8   ebx: dd46d8e0   ecx: dd46d8f8   edx: 00000000
esi: c24a0d80   edi: d008b9c0   ebp: 00000001   esp: cbefbf28
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 29591, stackpage=cbefb000)
Stack: dcdcb1c0 dcdcb1c0 e0824820 00000000 d008b9e8 dcdcb1c0 c013f946 dcdcb1c0 
       c187ec00 c0134268 dcdcb1c0 dfd613e0 c187ec00 cbefbf98 c0142866 c187ec00 
       dfd613e0 dcdcb1c0 cbefbf98 c4b9b000 c0137cff dfd613e0 00000000 c0142e5f 
Call Trace: [<e0824820>] [<c013f946>] [<c0134268>] [<c0142866>] [<c0137cff>] 
   [<c0142e5f>] [<c012331d>] [<c0142e78>] [<c0106d2b>] 

Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000229e   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001d2   edi: 00000020   ebp: 0000229e   esp: cf7e7dd0
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29698, stackpage=cf7e7000)
Stack: 0000001a 000001d2 00000020 00000006 c013f96b 0000229e c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cf7e6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<e081a56c>] [<c012a6d2>] [<c012409a>] [<c012410e>] [<c0125373>] [<c0122179>] 
   [<c012229a>] [<c0112b98>] [<c0112a38>] [<c011c687>] [<c0123454>] [<c011946a>] 
   [<c0122553>] [<c0106e1c>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000229e   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001d2   edi: 00000020   ebp: 0000229e   esp: d0bf5e04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29708, stackpage=d0bf5000)
Stack: 0000000f 000001d2 00000020 00000006 c013f96b 0000229e c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       d0bf4000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<e0894ea0>] [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022a5   ebx: 00000000   ecx: 00000006   edx: 00000005
esi: 000001d2   edi: 00000020   ebp: 000022a5   esp: cffd7e04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29731, stackpage=cffd7000)
Stack: 00000011 000001d2 00000020 00000006 c013f96b 000022a5 c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cffd6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<e0894ea0>] [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022a6   ebx: 00000000   ecx: 00000006   edx: 00000001
esi: 000001d2   edi: 00000020   ebp: 000022a6   esp: cffd7dd0
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29736, stackpage=cffd7000)
Stack: 00000011 000001d2 00000020 00000006 c013f96b 000022a6 c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cffd6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<e081a56c>] [<c012a6d2>] [<c012409a>] [<c012410e>] [<c0125373>] [<c0122179>] 
   [<c012229a>] [<c0112b98>] [<c0112a38>] [<c0123454>] [<c0122553>] [<c0106e1c>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022bd   ebx: 00000000   ecx: 00000006   edx: 00000000
esi: 000001d2   edi: 00000020   ebp: 000022bd   esp: c765de04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29802, stackpage=c765d000)
Stack: 00000004 000001d2 00000020 00000006 c013f96b 000022bd c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       c765c000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 

Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013f8f3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f8f3>]    Not tainted
EFLAGS: 00010202
eax: cfa48ab8   ebx: c41b10a0   ecx: c41b10b8   edx: 00000000
esi: c41b12c0   edi: c41b1720   ebp: 00000001   esp: ccbddf40
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29826, stackpage=ccbdd000)
Stack: c41b1720 d5d2d85c d5d2d7e0 c41b1720 c41b1748 c41b1720 c013f946 c41b1720 
       c41b1720 c013947c c41b1720 cde9f2bc c01395f1 c41b1720 c41b1720 c41b1720 
       db117000 ccbddfa4 c013973f d5d2d7e0 c41b1720 ccbdc000 0808eae0 08061567 
Call Trace: [<c013f946>] [<c013947c>] [<c01395f1>] [<c013973f>] [<c0106d2b>] 

Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75 
 

------=_20030217233100_29119
Content-Type: text/plain; name="ksymoops.txt"
Content-Disposition: attachment; filename="ksymoops.txt"

ksymoops 2.4.5 on i686 2.4.18-686.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-686/ (default)
     -m /boot/System.map-2.4.18-686 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/ext2/ext2.o for module ext2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/jbd/jbd.o for module jbd has changed since load
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f608
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013f608>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: c01f35fc   ebx: d463ae58   ecx: cd81b020   edx: 00000000
esi: d49a83e0   edi: 00000000   ebp: 000026b2   esp: c1831f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1831000)
Stack: 0000000e 000001d0 00000015 00000005 c013f96b 000029bd c0129eb6 00000005 
       000001d0 00000005 000001d0 c01f2948 00000000 c01f2948 c0129f0f 00000015 
       c01f2948 00000001 c1830000 c0129fa3 c01f28a0 00000000 c1830249 0008e000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c0129fa3>] [<c0129ffe>] 
   [<c012a10d>] [<c0105688>] 
Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a8 08 74 27 24 f7 89 


>>EIP; c013f608 <prune_dcache+18/128>   <=====

>>eax; c01f35fc <dentry_unused+0/8>
>>ebx; d463ae58 <_end+143c544c/205975f4>
>>ecx; cd81b020 <_end+d5a5614/205975f4>
>>esi; d49a83e0 <_end+147329d4/205975f4>
>>ebp; 000026b2 Before first symbol
>>esp; c1831f60 <_end+15bc554/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c0129fa3 <kswapd_balance_pgdat+43/8c>
Trace; c0129ffe <kswapd_balance+12/28>
Trace; c012a10d <kswapd+99/bc>
Trace; c0105688 <kernel_thread+28/38>

Code;  c013f608 <prune_dcache+18/128>
00000000 <_EIP>:
Code;  c013f608 <prune_dcache+18/128>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c013f60a <prune_dcache+1a/128>
   2:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   4:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   7:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
   a:   8b 46 54                  mov    0x54(%esi),%eax
Code;  c013f615 <prune_dcache+25/128>
   d:   a8 08                     test   $0x8,%al
Code;  c013f617 <prune_dcache+27/128>
   f:   74 27                     je     38 <_EIP+0x38> c013f640 <prune_dcache+50/128>
Code;  c013f619 <prune_dcache+29/128>
  11:   24 f7                     and    $0xf7,%al
Code;  c013f61b <prune_dcache+2b/128>
  13:   89 00                     mov    %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 00002249   ebx: 00000000   ecx: 00000006   edx: 00000001
esi: 000001f0   edi: 00000020   ebp: 00002249   esp: d9fc3e50
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 29319, stackpage=d9fc3000)
Stack: 00000019 000001f0 00000020 00000006 c013f96b 00002249 c0129eb6 00000006 
       000001f0 00000006 000001f0 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       d9fc2000 00000120 00000000 c012a722 c01f2aa4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c012a9aa>] [<c013c027>] [<c019e8da>] [<c01834af>] [<c013c206>] 
   [<c013c64a>] [<c0106d2b>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 00002249 Before first symbol
>>ebp; 00002249 Before first symbol
>>esp; d9fc3e50 <_end+19d4e444/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c012a9aa <__get_free_pages+a/18>
Trace; c013c027 <__pollwait+33/8c>
Trace; c019e8da <tcp_poll+2e/154>
Trace; c01834af <sock_poll+23/28>
Trace; c013c206 <do_select+e2/1dc>
Trace; c013c64a <sys_select+322/464>
Trace; c0106d2b <system_call+33/38>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000224c   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001f0   edi: 00000020   ebp: 0000224c   esp: c857fe50
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 29389, stackpage=c857f000)
Stack: 00000019 000001f0 00000020 00000006 c013f96b 0000224c c0129eb6 00000006 
       000001f0 00000006 000001f0 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       c857e000 00000120 00000000 c012a722 c01f2aa4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c018540c>] 
   [<c012a942>] [<c012a6d2>] [<c012a9aa>] [<c013c027>] [<c019e8da>] [<c0183095>] 
   [<c01834af>] [<c013c206>] [<c013c64a>] [<c0106d2b>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 0000224c Before first symbol
>>ebp; 0000224c Before first symbol
>>esp; c857fe50 <_end+830a444/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c018540c <sock_alloc_send_pskb+70/1b8>
Trace; c012a942 <__alloc_pages+106/164>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c012a9aa <__get_free_pages+a/18>
Trace; c013c027 <__pollwait+33/8c>
Trace; c019e8da <tcp_poll+2e/154>
Trace; c0183095 <sock_sendmsg+69/88>
Trace; c01834af <sock_poll+23/28>
Trace; c013c206 <do_select+e2/1dc>
Trace; c013c64a <sys_select+322/464>
Trace; c0106d2b <system_call+33/38>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f8f3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f8f3>]    Not tainted
EFLAGS: 00010202
eax: d67c3cf8   ebx: dd46d8e0   ecx: dd46d8f8   edx: 00000000
esi: c24a0d80   edi: d008b9c0   ebp: 00000001   esp: cbefbf28
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 29591, stackpage=cbefb000)
Stack: dcdcb1c0 dcdcb1c0 e0824820 00000000 d008b9e8 dcdcb1c0 c013f946 dcdcb1c0 
       c187ec00 c0134268 dcdcb1c0 dfd613e0 c187ec00 cbefbf98 c0142866 c187ec00 
       dfd613e0 dcdcb1c0 cbefbf98 c4b9b000 c0137cff dfd613e0 00000000 c0142e5f 
Call Trace: [<e0824820>] [<c013f946>] [<c0134268>] [<c0142866>] [<c0137cff>] 
   [<c0142e5f>] [<c012331d>] [<c0142e78>] [<c0106d2b>] 
Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75 


>>EIP; c013f8f3 <select_parent+3f/7c>   <=====

>>eax; d67c3cf8 <_end+1654e2ec/205975f4>
>>ebx; dd46d8e0 <_end+1d1f7ed4/205975f4>
>>ecx; dd46d8f8 <_end+1d1f7eec/205975f4>
>>esi; c24a0d80 <_end+222b374/205975f4>
>>edi; d008b9c0 <_end+fe15fb4/205975f4>
>>esp; cbefbf28 <_end+bc8651c/205975f4>

Trace; e0824820 <[ext3]ext3_sops+0/44>
Trace; c013f946 <shrink_dcache_parent+16/20>
Trace; c0134268 <kill_super+54/d4>
Trace; c0142866 <__mntput+1e/24>
Trace; c0137cff <path_release+27/2c>
Trace; c0142e5f <sys_umount+a7/b4>
Trace; c012331d <sys_munmap+35/54>
Trace; c0142e78 <sys_oldumount+c/10>
Trace; c0106d2b <system_call+33/38>

Code;  c013f8f3 <select_parent+3f/7c>
00000000 <_EIP>:
Code;  c013f8f3 <select_parent+3f/7c>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c013f8f5 <select_parent+41/7c>
   2:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c013f8f8 <select_parent+44/7c>
   5:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c013f8fb <select_parent+47/7c>
   8:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c013f8fe <select_parent+4a/7c>
   b:   89 0a                     mov    %ecx,(%edx)
Code;  c013f900 <select_parent+4c/7c>
   d:   8d 43 28                  lea    0x28(%ebx),%eax
Code;  c013f903 <select_parent+4f/7c>
  10:   39 43 28                  cmp    %eax,0x28(%ebx)
Code;  c013f906 <select_parent+52/7c>
  13:   75 00                     jne    15 <_EIP+0x15> c013f908 <select_parent+54/7c>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000229e   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001d2   edi: 00000020   ebp: 0000229e   esp: cf7e7dd0
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29698, stackpage=cf7e7000)
Stack: 0000001a 000001d2 00000020 00000006 c013f96b 0000229e c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cf7e6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<e081a56c>] [<c012a6d2>] [<c012409a>] [<c012410e>] [<c0125373>] [<c0122179>] 
   [<c012229a>] [<c0112b98>] [<c0112a38>] [<c011c687>] [<c0123454>] [<c011946a>] 
   [<c0122553>] [<c0106e1c>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 0000229e Before first symbol
>>ebp; 0000229e Before first symbol
>>esp; cf7e7dd0 <_end+f5723c4/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; e081a56c <[ext3]ext3_get_block+0/60>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c012409a <page_cache_read+6e/bc>
Trace; c012410e <read_cluster_nonblocking+26/40>
Trace; c0125373 <filemap_nopage+10b/1f8>
Trace; c0122179 <do_no_page+4d/11c>
Trace; c012229a <handle_mm_fault+52/b4>
Trace; c0112b98 <do_page_fault+160/48c>
Trace; c0112a38 <do_page_fault+0/48c>
Trace; c011c687 <update_wall_time+b/34>
Trace; c0123454 <do_brk+118/1fc>
Trace; c011946a <do_softirq+5a/a4>
Trace; c0122553 <sys_brk+bb/e4>
Trace; c0106e1c <error_code+34/3c>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 0000229e   ebx: 00000000   ecx: 00000006   edx: 00000002
esi: 000001d2   edi: 00000020   ebp: 0000229e   esp: d0bf5e04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29708, stackpage=d0bf5000)
Stack: 0000000f 000001d2 00000020 00000006 c013f96b 0000229e c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       d0bf4000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<e0894ea0>] [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 0000229e Before first symbol
>>ebp; 0000229e Before first symbol
>>esp; d0bf5e04 <_end+109803f8/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c01220b8 <do_anonymous_page+30/a4>
Trace; c012215f <do_no_page+33/11c>
Trace; c012229a <handle_mm_fault+52/b4>
Trace; c0112b98 <do_page_fault+160/48c>
Trace; c0112a38 <do_page_fault+0/48c>
Trace; e0894ea0 <[smc-ultra]dev_ultra+0/4e0>
Trace; c011c687 <update_wall_time+b/34>
Trace; c0123454 <do_brk+118/1fc>
Trace; c011946a <do_softirq+5a/a4>
Trace; c0122553 <sys_brk+bb/e4>
Trace; c0106e1c <error_code+34/3c>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022a5   ebx: 00000000   ecx: 00000006   edx: 00000005
esi: 000001d2   edi: 00000020   ebp: 000022a5   esp: cffd7e04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29731, stackpage=cffd7000)
Stack: 00000011 000001d2 00000020 00000006 c013f96b 000022a5 c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cffd6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<e0894ea0>] [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 000022a5 Before first symbol
>>ebp; 000022a5 Before first symbol
>>esp; cffd7e04 <_end+fd623f8/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c01220b8 <do_anonymous_page+30/a4>
Trace; c012215f <do_no_page+33/11c>
Trace; c012229a <handle_mm_fault+52/b4>
Trace; c0112b98 <do_page_fault+160/48c>
Trace; c0112a38 <do_page_fault+0/48c>
Trace; e0894ea0 <[smc-ultra]dev_ultra+0/4e0>
Trace; c011c687 <update_wall_time+b/34>
Trace; c0123454 <do_brk+118/1fc>
Trace; c011946a <do_softirq+5a/a4>
Trace; c0122553 <sys_brk+bb/e4>
Trace; c0106e1c <error_code+34/3c>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022a6   ebx: 00000000   ecx: 00000006   edx: 00000001
esi: 000001d2   edi: 00000020   ebp: 000022a6   esp: cffd7dd0
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29736, stackpage=cffd7000)
Stack: 00000011 000001d2 00000020 00000006 c013f96b 000022a6 c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       cffd6000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<e081a56c>] [<c012a6d2>] [<c012409a>] [<c012410e>] [<c0125373>] [<c0122179>] 
   [<c012229a>] [<c0112b98>] [<c0112a38>] [<c0123454>] [<c0122553>] [<c0106e1c>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 000022a6 Before first symbol
>>ebp; 000022a6 Before first symbol
>>esp; cffd7dd0 <_end+fd623c4/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; e081a56c <[ext3]ext3_get_block+0/60>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c012409a <page_cache_read+6e/bc>
Trace; c012410e <read_cluster_nonblocking+26/40>
Trace; c0125373 <filemap_nopage+10b/1f8>
Trace; c0122179 <do_no_page+4d/11c>
Trace; c012229a <handle_mm_fault+52/b4>
Trace; c0112b98 <do_page_fault+160/48c>
Trace; c0112a38 <do_page_fault+0/48c>
Trace; c0123454 <do_brk+118/1fc>
Trace; c0122553 <sys_brk+bb/e4>
Trace; c0106e1c <error_code+34/3c>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f600
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f600>]    Not tainted
EFLAGS: 00010213
eax: 000022bd   ebx: 00000000   ecx: 00000006   edx: 00000000
esi: 000001d2   edi: 00000020   ebp: 000022bd   esp: c765de04
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29802, stackpage=c765d000)
Stack: 00000004 000001d2 00000020 00000006 c013f96b 000022bd c0129eb6 00000006 
       000001d2 00000006 000001d2 c01f2948 c01f2948 c01f2948 c0129f0f 00000020 
       c765c000 00000120 00000000 c012a722 c01f2ac4 00000120 00000010 00000000 
Call Trace: [<c013f96b>] [<c0129eb6>] [<c0129f0f>] [<c012a722>] [<c012a942>] 
   [<c012a6d2>] [<c01220b8>] [<c012215f>] [<c012229a>] [<c0112b98>] [<c0112a38>] 
   [<c011c687>] [<c0123454>] [<c011946a>] [<c0122553>] [<c0106e1c>] 
Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 


>>EIP; c013f600 <prune_dcache+10/128>   <=====

>>eax; 000022bd Before first symbol
>>ebp; 000022bd Before first symbol
>>esp; c765de04 <_end+73e83f8/205975f4>

Trace; c013f96b <shrink_dcache_memory+1b/34>
Trace; c0129eb6 <shrink_caches+66/88>
Trace; c0129f0f <try_to_free_pages+37/58>
Trace; c012a722 <balance_classzone+4e/168>
Trace; c012a942 <__alloc_pages+106/164>
Trace; c012a6d2 <_alloc_pages+16/18>
Trace; c01220b8 <do_anonymous_page+30/a4>
Trace; c012215f <do_no_page+33/11c>
Trace; c012229a <handle_mm_fault+52/b4>
Trace; c0112b98 <do_page_fault+160/48c>
Trace; c0112a38 <do_page_fault+0/48c>
Trace; c011c687 <update_wall_time+b/34>
Trace; c0123454 <do_brk+118/1fc>
Trace; c011946a <do_softirq+5a/a4>
Trace; c0122553 <sys_brk+bb/e4>
Trace; c0106e1c <error_code+34/3c>

Code;  c013f600 <prune_dcache+10/128>
00000000 <_EIP>:
Code;  c013f600 <prune_dcache+10/128>   <=====
   0:   8b 53 04                  mov    0x4(%ebx),%edx   <=====
Code;  c013f603 <prune_dcache+13/128>
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013f605 <prune_dcache+15/128>
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013f608 <prune_dcache+18/128>
   8:   89 02                     mov    %eax,(%edx)
Code;  c013f60a <prune_dcache+1a/128>
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  c013f60c <prune_dcache+1c/128>
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c013f60f <prune_dcache+1f/128>
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c013f612 <prune_dcache+22/128>
  12:   8b 46 00                  mov    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f8f3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f8f3>]    Not tainted
EFLAGS: 00010202
eax: cfa48ab8   ebx: c41b10a0   ecx: c41b10b8   edx: 00000000
esi: c41b12c0   edi: c41b1720   ebp: 00000001   esp: ccbddf40
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 29826, stackpage=ccbdd000)
Stack: c41b1720 d5d2d85c d5d2d7e0 c41b1720 c41b1748 c41b1720 c013f946 c41b1720 
       c41b1720 c013947c c41b1720 cde9f2bc c01395f1 c41b1720 c41b1720 c41b1720 
       db117000 ccbddfa4 c013973f d5d2d7e0 c41b1720 ccbdc000 0808eae0 08061567 
Call Trace: [<c013f946>] [<c013947c>] [<c01395f1>] [<c013973f>] [<c0106d2b>] 
Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75 


>>EIP; c013f8f3 <select_parent+3f/7c>   <=====

>>eax; cfa48ab8 <_end+f7d30ac/205975f4>
>>ebx; c41b10a0 <_end+3f3b694/205975f4>
>>ecx; c41b10b8 <_end+3f3b6ac/205975f4>
>>esi; c41b12c0 <_end+3f3b8b4/205975f4>
>>edi; c41b1720 <_end+3f3bd14/205975f4>
>>esp; ccbddf40 <_end+c968534/205975f4>

Trace; c013f946 <shrink_dcache_parent+16/20>
Trace; c013947c <d_unhash+20/48>
Trace; c01395f1 <vfs_rmdir+14d/1e0>
Trace; c013973f <sys_rmdir+bb/fc>
Trace; c0106d2b <system_call+33/38>

Code;  c013f8f3 <select_parent+3f/7c>
00000000 <_EIP>:
Code;  c013f8f3 <select_parent+3f/7c>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c013f8f5 <select_parent+41/7c>
   2:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c013f8f8 <select_parent+44/7c>
   5:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c013f8fb <select_parent+47/7c>
   8:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c013f8fe <select_parent+4a/7c>
   b:   89 0a                     mov    %ecx,(%edx)
Code;  c013f900 <select_parent+4c/7c>
   d:   8d 43 28                  lea    0x28(%ebx),%eax
Code;  c013f903 <select_parent+4f/7c>
  10:   39 43 28                  cmp    %eax,0x28(%ebx)
Code;  c013f906 <select_parent+52/7c>
  13:   75 00                     jne    15 <_EIP+0x15> c013f908 <select_parent+54/7c>


7 warnings issued.  Results may not be reliable.


------=_20030217233100_29119--

