Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287143AbRL2Gjs>; Sat, 29 Dec 2001 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287142AbRL2Gjk>; Sat, 29 Dec 2001 01:39:40 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:62955 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S287145AbRL2Gj2>; Sat, 29 Dec 2001 01:39:28 -0500
Date: Sat, 29 Dec 2001 01:42:48 -0500
To: Jens Axboe <axboe@suse.de>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011229014248.A17257@earthlink.net>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net> <20011228153022.D1248@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228153022.D1248@suse.de>; from axboe@suse.de on Fri, Dec 28, 2001 at 03:30:22PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kernel panic: Out of memory and no killable processes...
> 
> Someone else did report a similar case. Very strange, doesn't look bio

Al Viro posted a fix:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100959128922157&w=2

I used Al's patch and 2.5.2-pre3 boots with reiserfs root_fs
and no panic.

Below is the trace on 2.5.2-pre3 after dbench 32 livelocked.

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C177FF24  4592     1      0    45       3       (NOTLB)
Call Trace: [<c01115d9>] [<c0111500>] [<c0139d54>] [<c013a102>] [<c0133c46>]
   [<c01085b3>]
keventd       S 00010000  6580     2      1             7       (L-TLB)
Call Trace: [<c011e3f5>] [<c0106ef0>]
ksoftirqd_CPU S C1770000  6396     3      0             4     1 (L-TLB)
Call Trace: [<c0117b12>] [<c0106ef0>]
kswapd        S C176E000  6636     4      0             5     3 (L-TLB)
Call Trace: [<c0128716>] [<c0106ef0>]
bdflush       S 00000286  6552     5      0             6     4 (L-TLB)
Call Trace: [<c0111c69>] [<c0130fb3>] [<c0106ef0>]
kupdated      D C176BFAC  5864     6      0                   5 (L-TLB)
Call Trace: [<c012e96a>] [<c012eb2b>] [<c0131023>] [<c0106ef0>]
kreiserfsd    S D68E9FB4  6156     7      1            25     2 (L-TLB)
Call Trace: [<c01115d9>] [<c0111500>] [<c0111cbe>] [<c0177717>] [<c0106ef0>]
syslogd       D 00000048  4772    25      1            27     7 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0166aa8>]
   [<c0125085>] [<c012df62>] [<c0124bec>] [<c012e06f>] [<c01085b3>]
klogd         S 7FFFFFFF  4772    27      1            32    25 (NOTLB)
Call Trace: [<c011157b>] [<c01e6c4d>] [<c01e74e7>] [<c01b0d77>] [<c01b0f87>]
   [<c012dd7a>] [<c01085b3>]
eth0          S D646FF98     0    32      1            37    27 (L-TLB)
Call Trace: [<c01115d9>] [<c0111500>] [<c0111cbe>] [<c01a125e>] [<c0106ef0>]
iplog         S 7FFFFFFF  5304    37      1    38      43    32 (NOTLB)
Call Trace: [<c011157b>] [<c0139bd1>] [<c0139d54>] [<c013a102>] [<c01085b3>]
iplog         S D616DF28   188    38     37    41               (NOTLB)
Call Trace: [<c01115d9>] [<c0111500>] [<c013a37c>] [<c013a57d>] [<c011191c>]
   [<c01085b3>]
iplog         S D6169FB0  5684    39     38            40       (NOTLB)
Call Trace: [<c0107767>] [<c01085b3>]
iplog         S D6165F24  6280    40     38            41    39 (NOTLB)
Call Trace: [<c01115d9>] [<c0111500>] [<c0139d54>] [<c013a102>] [<c01085b3>]
iplog         S 7FFFFFFF  5656    41     38                  40 (NOTLB)
Call Trace: [<c011157b>] [<c01bed35>] [<c01b51e2>] [<c01b52fe>] [<c01e960f>]
   [<c01b0dd5>] [<c01b1b47>] [<c011b314>] [<c011b550>] [<c011bc78>] [<c01b6c4b>]
   [<c01b2267>] [<c01085b3>]
sshd          S 7FFFFFFF  4772    43      1    55      44    37 (NOTLB)
Call Trace: [<c011157b>] [<c01b113d>] [<c0139d54>] [<c013a102>] [<c01085b3>]
agetty        S 7FFFFFFF  4468    44      1            45    43 (NOTLB)
Call Trace: [<c011157b>] [<c0183a0d>] [<c017fc76>] [<c012dcb5>] [<c01085b3>]
agetty        S 7FFFFFFF     0    45      1                  44 (NOTLB)
Call Trace: [<c011157b>] [<c0183a0d>] [<c017fc76>] [<c012dcb5>] [<c01085b3>]
sshd          S 7FFFFFFF   548    47     43    48      55       (NOTLB)
Call Trace: [<c011157b>] [<c0139d54>] [<c013a102>] [<c01085b3>]
bash          S 00000000  4564    48     47    62               (NOTLB)
Call Trace: [<c0116b4e>] [<c01085b3>]
sshd          S 7FFFFFFF     0    55     43    56            47 (NOTLB)
Call Trace: [<c011157b>] [<c0139d54>] [<c013a102>] [<c01085b3>]
bash          S 7FFFFFFF  2640    56     55                     (NOTLB)
Call Trace: [<c011157b>] [<c0183a0d>] [<c017fc76>] [<c012dcb5>] [<c01085b3>]
chk           S 00000000     0    62     48    63               (NOTLB)
Call Trace: [<c0116b4e>] [<c01085b3>]
dbench        S 00000000  5192    63     62    96               (NOTLB)
Call Trace: [<c0116b4e>] [<c01085b3>]
dbench        D 00000048  5372    65     63            66       (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5620    66     63            67    65 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c015974b>]
   [<c015a1fd>] [<c015c847>] [<c0137224>] [<c01372e5>] [<c01085b3>]
dbench        D 00000000  5620    67     63            68    66 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5728    68     63            69    67 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5608    69     63            70    68 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5948    70     63            71    69 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5572    71     63            72    70 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5264    72     63            73    71 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5464    73     63            74    72 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5728    74     63            75    73 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012f6e5>] [<c015b32a>] [<c012f974>]
   [<c012fb2d>] [<c012fd51>] [<c0130341>] [<c015b0d8>] [<c015b496>] [<c015b0d8>]
   [<c012503d>] [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5528    75     63            76    74 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5676    76     63            77    75 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5332    77     63            78    76 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5584    78     63            79    77 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5644    79     63            80    78 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea8e>] [<c012f974>] [<c012fb73>] [<c012fd6e>] [<c012f745>]
   [<c012f629>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>] [<c012dd7a>]
   [<c01085b3>]
dbench        D 00000048  5620    80     63            81    79 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5600    81     63            82    80 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5620    82     63            83    81 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5604    83     63            84    82 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5620    84     63            85    83 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5632    85     63            86    84 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5676    86     63            87    85 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5676    87     63            88    86 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5620    88     63            89    87 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5620    89     63            90    88 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012f6e5>] [<c015b32a>] [<c012f974>]
   [<c012fb2d>] [<c012fd51>] [<c0130341>] [<c015b0d8>] [<c015b496>] [<c015b0d8>]
   [<c012503d>] [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5728    90     63            91    89 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5628    91     63            92    90 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5676    92     63            93    91 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
dbench        D 00000000  5948    93     63            94    92 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5692    94     63            95    93 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000000  5488    95     63            96    94 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]
dbench        D 00000048  5372    96     63                  95 (NOTLB)
Call Trace: [<c0196a06>] [<c019708f>] [<c0197340>] [<c01973dc>] [<c019747f>]
   [<c012e9d5>] [<c012ea5e>] [<c012f66f>] [<c012ff5f>] [<c01303ab>] [<c0125085>]
   [<c012dd7a>] [<c01085b3>]

SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0010:[<c0106c03>] CPU: 0 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c022e000 ECX: d68e8280 EDX: d68e8280
ESI: c0106be0 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 40014000 CR3: 16177000 CR4: 00000090
Call Trace: [<c0106c59>] [<c0105000>] [<c0105027>]

SysRq : Show Memory
Mem-info:
Free pages:       95596kB (     0kB HighMem)
Zone:DMA freepages: 14572kB min:   128kB low:   256kB high:   384kB
Zone:Normal freepages: 81024kB min:  1020kB low:  2040kB high:  3060kB
Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB
( Active: 1427, inactive: 67074, free: 23899 )
3*4kB 2*8kB 1*16kB 2*32kB 2*64kB 4*128kB 2*256kB 0*512kB 1*1024kB 6*2048kB = 14572kB)
10*4kB 3*8kB 4*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 39*2048kB = 81024kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       136512kB
98304 pages of RAM
0 pages of HIGHMEM
1995 reserved pages
72913 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:    23796kB

mountain:~/dbench$ ps -eo pid,cmd,wchan
  PID CMD              WCHAN
    1 init             do_select
    2 [keventd]        context_thread
    3 [ksoftirqd_CPU0] ksoftirqd
    4 [kswapd]         kswapd
    5 [bdflush]        bdflush
    6 [kupdated]       wait_on_buffer
    7 [kreiserfsd]     reiserfs_journal_commit_thread
   25 /usr/sbin/syslog get_request_wait
   27 /usr/sbin/klogd  unix_wait_for_peer
   32 [eth0]           rtl8139_thread
   37 /usr/sbin/iplog  do_select
   38 /usr/sbin/iplog  do_poll
   39 /usr/sbin/iplog  rt_sigsuspend
   40 /usr/sbin/iplog  do_select
   41 /usr/sbin/iplog  wait_for_packet
   43 /usr/sbin/sshd   do_select
   44 /sbin/agetty tty read_chan
   45 /sbin/agetty -h  read_chan
   47 /usr/sbin/sshd   -
   48 -bash            wait4
   55 /usr/sbin/sshd   do_select
   56 -bash            read_chan
   65 ./dbench 32      get_request_wait
   66 ./dbench 32      get_request_wait
   67 ./dbench 32      get_request_wait
   68 ./dbench 32      get_request_wait
   69 ./dbench 32      get_request_wait
   70 ./dbench 32      get_request_wait
   71 ./dbench 32      get_request_wait
   72 ./dbench 32      get_request_wait
   73 ./dbench 32      get_request_wait
   74 ./dbench 32      get_request_wait
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
   87 ./dbench 32      get_request_wait
   88 ./dbench 32      get_request_wait
   89 ./dbench 32      get_request_wait
   90 ./dbench 32      get_request_wait
   91 ./dbench 32      get_request_wait
   92 ./dbench 32      get_request_wait
   93 ./dbench 32      get_request_wait
   94 ./dbench 32      get_request_wait
   95 ./dbench 32      get_request_wait
   96 ./dbench 32      get_request_wait
   97 ps -eo pid,cmd,w -

dbench was run on the ext2 filesystem.

mountain:~/dbench$ df -kT .
Filesystem    Type   1k-blocks      Used Available Use% Mounted on
/dev/hda6     ext2     4032092    249208   3578060   7% /home


-- 
Randy Hron

