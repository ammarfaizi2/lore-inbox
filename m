Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbTDBTTq>; Wed, 2 Apr 2003 14:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263132AbTDBTTp>; Wed, 2 Apr 2003 14:19:45 -0500
Received: from periwinkle.noc.ucla.edu ([169.232.47.11]:60684 "EHLO
	periwinkle.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S263130AbTDBTTh>; Wed, 2 Apr 2003 14:19:37 -0500
Date: Wed, 2 Apr 2003 11:31:01 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: shaggy@austin.ibm.com
Subject: oops with JFS 1.1.2 and 2.4.20
Message-ID: <Pine.LNX.4.53.0304021120460.16450@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A decoded oops report, the output from /proc/fs/jfs/*, and the ver_linux
output is included below.  The kernel is stock 2.4.20 with JFS 1.1.2 from
http://oss.software.ibm.com/jfs/


-Chris


ksymoops 2.4.5 on i686 2.4.20jfs.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.20jfs/ (specified)
     -m /boot/System.map-2.4.20jfs (specified)

kernel: XT_GETPAGE: xtree page corrupt<2>BUG at jfs_imap.c:2075 assert((le32_to_cpu(iagp->pmap[extno]) & mask) == 0)
kernel: kernel BUG at jfs_imap.c:2075!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[diAllocBit+275/624]    Not tainted
kernel: EFLAGS: 00010282
kernel: eax: 0000004f   ebx: f579e000   ecx: 00000002   edx: 00000001
kernel: esi: 00000029   edi: 000000a4   ebp: f3c85db8   esp: f3c85d78
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process pollDevices.pl (pid: 20137, stackpage=f3c85000)
kernel: Stack: c027e560 c027e555 0000081b c027e880 f768e000 00000029 ff9267ff f3c85db8
kernel:        c0181f17 f7306820 00000800 00000000 00000000 00000014 00000029 f3c85e1c
kernel:        f3c85e1c c0180998 f768e000 f579e000 00000534 f2c1ea00 f2ac2bbc 000081b4
kernel: Call Trace:    [diIAGRead+55/80] [diAlloc+1000/1660] [ialloc+136/492] [jfs_create+110/672] [link_path_walk+2144/2404]
kernel: Code: 0f 0b 1b 08 55 e5 27 c0 83 c4 10 8d b6 00 00 00 00 8b 55 0c
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f579e000 <_end+354543cc/385cd3cc>
>>ebp; f3c85db8 <_end+3393c184/385cd3cc>
>>esp; f3c85d78 <_end+3393c144/385cd3cc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   1b 08                     sbb    (%eax),%ecx
Code;  00000004 Before first symbol
   4:   55                        push   %ebp
Code;  00000005 Before first symbol
   5:   e5 27                     in     $0x27,%eax
Code;  00000007 Before first symbol
   7:   c0 83 c4 10 8d b6 00      rolb   $0x0,0xb68d10c4(%ebx)
Code;  0000000e Before first symbol
   e:   00 00                     add    %al,(%eax)
Code;  00000010 Before first symbol
  10:   00 8b 55 0c 00 00         add    %cl,0xc55(%ebx)





cbs@arugula:~ > foreach f ( /proc/fs/jfs/* )
foreach? echo $f && cat $f
foreach? end
/proc/fs/jfs/TxAnchor
JFS TxAnchor
============
freetid = 511
freewait = active
freelock = 3353
freelockwait = empty
lowlockwait = active
tlocksInUse = 3352
TlocksLow = 1
unlock_queue = 0xf8800a80
unlock_tail = 0xf880a560
/proc/fs/jfs/lmstats
JFS Logmgr stats
================
commits = 13064
writes submitted = 1358
writes completed = 1358
full pages submitted = 1168
partial pages submitted = 109
/proc/fs/jfs/loglevel
2
/proc/fs/jfs/mpstat
JFS Metapage statistics
=======================
page allocations = 164412
page frees = 164195
lock waits = 81
allocation waits = 0
/proc/fs/jfs/txstats
JFS TxStats
===========
calls to txBegin = 13103
txBegin blocked by sync barrier = 0
txBegin blocked by tlocks low = 36
txBegin blocked by no free tid = 2
calls to txBeginAnon = 2143
txBeginAnon blocked by sync barrier = 0
txBeginAnon blocked by tlocks low = 7
calls to txLockAlloc = 34640
tLockAlloc blocked by no free lock = 0
/proc/fs/jfs/xtstat
JFS Xtree statistics
====================
searches = 301550
fast searches = 240493
splits = 0





cbs@arugula:/usr/src/linux-2.4.20 > sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux arugula 2.4.20jfs #2 SMP Wed Apr 2 10:51:35 PST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.32
jfsutils               1.1.2
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         st bridge

