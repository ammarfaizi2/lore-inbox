Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286990AbRL1T0m>; Fri, 28 Dec 2001 14:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286987AbRL1T0d>; Fri, 28 Dec 2001 14:26:33 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:50322 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S286992AbRL1T0V>; Fri, 28 Dec 2001 14:26:21 -0500
Date: Fri, 28 Dec 2001 14:29:40 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011228142940.B15896@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228153022.D1248@suse.de>; from axboe@suse.de on Fri, Dec 28, 2001 at 03:30:22PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 03:30:22PM +0100, Jens Axboe wrote:
> keep looking, though. Could you do sysrq-t for a livelocked system?
> -- 
> Jens Axboe

Using a tip from Russell King:

This is while running dbench 32 on an ext2 filesystem.

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C177FF24  4608     1      0    43       3       (NOTLB)
Call Trace: [<c011159a>] [<c01114dc>] [<c01398d4>] [<c0139c82>] [<c01337d6>]
   [<c01085b3>]
keventd       S 00010000  6596     2      1             7       (L-TLB)
Call Trace: [<c011e245>] [<c0106efc>]
ksoftirqd_CPU S C1770000  6412     3      0             4     1 (L-TLB)
Call Trace: [<c01179b2>] [<c0106efc>]
kswapd        S C176E000  6652     4      0             5     3 (L-TLB)
Call Trace: [<c01282c6>] [<c0106efc>]
bdflush       S 00000286  6568     5      0             6     4 (L-TLB)
Call Trace: [<c0111b29>] [<c0130b53>] [<c0106efc>]
kupdated      D 00000048  5860     6      0                   5 (L-TLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012f265>] [<c015bd08>] [<c015bd95>]
   [<c013dd35>] [<c01309bd>] [<c0130c45>] [<c0106efc>]
kreiserfsd    S D7D1BFB4  6148     7      1            25     2 (L-TLB)
Call Trace: [<c011159a>] [<c01114dc>] [<c0111b7e>] [<c0177257>] [<c0106efc>]
syslogd       D 00000048  4788    25      1            27     7 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c01665b8>]
   [<c0124c35>] [<c012db02>] [<c012479c>] [<c012dc0f>] [<c01085b3>]
klogd         S 7FFFFFFF  2656    27      1            32    25 (NOTLB)
Call Trace: [<c011153f>] [<c01dd4ad>] [<c01ddd37>] [<c01aed94>] [<c01aef9f>]
   [<c012d91a>] [<c01085b3>]
eth0          S D7945F98  2656    32      1            41    27 (L-TLB)
Call Trace: [<c011159a>] [<c01114dc>] [<c0111b7e>] [<c01a0d7e>] [<c0106efc>]
sshd          S 7FFFFFFF  4788    41      1    52      42    32 (NOTLB)
Call Trace: [<c011153f>] [<c01af15d>] [<c01398d4>] [<c0139c82>] [<c01085b3>]
agetty        S 7FFFFFFF  4364    42      1            43    41 (NOTLB)
Call Trace: [<c011153f>] [<c018350d>] [<c017f786>] [<c012d855>] [<c01085b3>]
agetty        S 7FFFFFFF     0    43      1                  42 (NOTLB)
Call Trace: [<c011153f>] [<c018350d>] [<c017f786>] [<c012d855>] [<c01085b3>]
sshd          S 7FFFFFFF  5484    45     41    46      52       (NOTLB)
Call Trace: [<c011153f>] [<c01398d4>] [<c0139c82>] [<c01085b3>]
bash          S 00000000  4580    46     45    59               (NOTLB)
Call Trace: [<c01169ee>] [<c01085b3>]
sshd          S 7FFFFFFF  1568    52     41    53            45 (NOTLB)
Call Trace: [<c0183b6f>] [<c011153f>] [<c01398d4>] [<c0139c82>] [<c01085b3>]
bash          S 00000000  2656    53     52    58               (NOTLB)
Call Trace: [<c01169ee>] [<c01085b3>]
vmstat        S D72B5F8C   644    58     53                     (NOTLB)
Call Trace: [<c011159a>] [<c01114dc>] [<c011a959>] [<c01085b3>]
chk           S 00000000  5284    59     46    60               (NOTLB)
Call Trace: [<c01169ee>] [<c01085b3>]
dbench        S 00000000  5208    60     59    93               (NOTLB)
Call Trace: [<c01169ee>] [<c01085b3>]
dbench        D 00000048  5692    62     60            63       (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5532    63     60            64    62 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e3473>] [<c0124c35>] [<c0124c8d>]
   [<c015a7de>] [<c0159e43>] [<c012e304>] [<c012d48b>] [<c012d4d7>] [<c01085b3>]
dbench        D 00000048  5684    64     60            65    63 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5624    65     60            66    64 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5700    66     60            67    65 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5660    67     60            68    66 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e34b9>] [<c0159886>] [<c015c03c>]
   [<c013655d>] [<c01366ca>] [<c012d07a>] [<c012d3b7>] [<c01085b3>]
dbench        D 00000048  5688    68     60            69    67 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5532    69     60            70    68 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e3473>] [<c0124c35>] [<c0124c8d>]
   [<c015a7de>] [<c0159e43>] [<c012e304>] [<c012d48b>] [<c012d4d7>] [<c01085b3>]
dbench        D 00000048  5780    70     60            71    69 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5756    71     60            72    70 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5692    72     60            73    71 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5692    73     60            74    72 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e3473>] [<c0124c35>] [<c0124c8d>]
   [<c015a7de>] [<c0159e43>] [<c012e304>] [<c012d48b>] [<c012d4d7>] [<c01085b3>]
dbench        D D7744244  5612    74     60            75    73 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e3473>] [<c0124c35>] [<c0124c8d>]
   [<c015a7de>] [<c0159e43>] [<c012e304>] [<c012d48b>] [<c012d4d7>] [<c01085b3>]
dbench        D 00000048  5740    75     60            76    74 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5600    76     60            77    75 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5448    77     60            78    76 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5692    78     60            79    77 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5640    79     60            80    78 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012f265>] [<c0159085>] [<c015a85c>]
   [<c015aa70>] [<c015ae09>] [<c012f8f2>] [<c012fee1>] [<c015ac38>] [<c015aff6>]
   [<c015ac38>] [<c0124bed>] [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5692    80     60            81    79 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5468    81     60            82    80 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5412    82     60            83    81 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5400    83     60            84    82 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5700    84     60            85    83 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5692    85     60            86    84 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5336    86     60            87    85 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5628    87     60            88    86 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e34b9>] [<c0159886>] [<c015c35d>]
   [<c0136da4>] [<c0136e65>] [<c01085b3>]
dbench        D 00000048  5484    88     60            89    87 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D D7744244  5740    89     60            90    88 (NOTLB)
Call Trace: [<c01073ed>] [<c0107538>] [<c01e3473>] [<c0124c35>] [<c0124c8d>]
   [<c015a7de>] [<c0159e43>] [<c012e304>] [<c012d48b>] [<c012d4d7>] [<c01085b3>]
dbench        D 00000048  5420    90     60            91    89 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5652    91     60            92    90 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5660    92     60            93    91 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]
dbench        D 00000048  5592    93     60                  92 (NOTLB)
Call Trace: [<c019656d>] [<c0196baf>] [<c0196e70>] [<c0196f04>] [<c0196fa7>]
   [<c012e575>] [<c012e5fe>] [<c012f1ef>] [<c012faff>] [<c012ff4b>] [<c0124c35>]
   [<c012d91a>] [<c01085b3>]


  PID CMD              WCHAN
    1 init             do_select
    2 [keventd]        context_thread
    3 [ksoftirqd_CPU0] ksoftirqd
    4 [kswapd]         kswapd
    5 [bdflush]        bdflush
    6 [kupdated]       get_request_wait
    7 [kreiserfsd]     reiserfs_journal_commit_thread
   25 /usr/sbin/syslog get_request_wait
   27 /usr/sbin/klogd  unix_wait_for_peer
   32 [eth0]           rtl8139_thread
   41 /usr/sbin/sshd   do_select
   42 /sbin/agetty tty read_chan
   43 /sbin/agetty -h  read_chan
   45 /usr/sbin/sshd   do_select
   46 -bash            wait4
   52 /usr/sbin/sshd   do_select
   53 -bash            wait4
   59 /bin/bash ./chk  wait4
   60 ./dbench 32      wait4
   62 ./dbench 32      get_request_wait
   63 ./dbench 32      down
   64 ./dbench 32      get_request_wait
   65 ./dbench 32      get_request_wait
   66 ./dbench 32      get_request_wait
   67 ./dbench 32      down
   68 ./dbench 32      get_request_wait
   69 ./dbench 32      down
   70 ./dbench 32      get_request_wait
   71 ./dbench 32      get_request_wait
   72 ./dbench 32      get_request_wait
   73 ./dbench 32      down
   74 ./dbench 32      down
   75 ./dbench 32      get_request_wait
   76 ./dbench 32      get_request_wait
   77 ./dbench 32      get_request_wait
   78 ./dbench 32      get_request_wait
   79 ./dbench 32      get_request_wait
   80 ./dbench 32      get_request_wait
   81 ./dbench 32      get_request_wait
   82 ./dbench 32      get_request_wait
   83 ./dbench 32      get_request_wait
   84 ./dbench 32      get_request_wait
   85 ./dbench 32      get_request_wait
   86 ./dbench 32      get_request_wait
   87 ./dbench 32      down
   88 ./dbench 32      get_request_wait
   89 ./dbench 32      down
   90 ./dbench 32      get_request_wait
   91 ./dbench 32      get_request_wait
   92 ./dbench 32      get_request_wait
   93 ./dbench 32      get_request_wait
   97 ps -eo pid,cmd,w -


SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0010:[<c0106c03>] CPU: 0 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c0220000 ECX: d7d1a270 EDX: d7d1a270
ESI: c0106be0 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 080cc00c CR3: 17d02000 CR4: 00000090
Call Trace: [<c0106c67>] [<c0105000>] [<c0105027>]

SysRq : Show Memory
Mem-info:
Free pages:       83640kB (     0kB HighMem)
Zone:DMA freepages: 14632kB min:   128kB low:   256kB high:   384kB
Zone:Normal freepages: 69008kB min:  1020kB low:  2040kB high:  3060kB
Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB
( Active: 1576, inactive: 69884, free: 20910 )
4*4kB 3*8kB 2*16kB 3*32kB 4*64kB 3*128kB 2*256kB 0*512kB 1*1024kB 6*2048kB = 14632kB)
10*4kB 3*8kB 1*16kB 2*32kB 0*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 33*2048kB = 69008kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       136512kB
98304 pages of RAM
0 pages of HIGHMEM
1980 reserved pages
75748 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:     4252kB


-- 
Randy Hron

