Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284491AbRLIVzT>; Sun, 9 Dec 2001 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284488AbRLIVzJ>; Sun, 9 Dec 2001 16:55:09 -0500
Received: from vt.cs.nstu.ru ([193.125.7.117]:57354 "EHLO vt.cs.nstu.ru")
	by vger.kernel.org with ESMTP id <S284497AbRLIVyu>;
	Sun, 9 Dec 2001 16:54:50 -0500
Message-Id: <200112092255.fB9Mtwg18442@vt.cs.nstu.ru>
Content-Type: text/plain;
  charset="koi8-r"
From: Petr Bavorovsky <petr@vt.cs.nstu.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: arcnet bugs in 2.4.x
Date: Mon, 10 Dec 2001 03:57:21 +0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,
there are two problems with arcnet drivers.

* Summary
1) arping utility cause kernel oops when used for arcnet NIC
2) "BUG: no buffers are available??" message

*System information
Linux version 2.4.16 (root@hostel.nstu.ru) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #2 óÂÔ äÅË 8 13:30:06 NOVT 2001
Bugs also persist on all earlier 2.4.x kernel I tested

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 697.652
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1392.64

# cat /proc/modules
3c59x                  24544   1
de4x5                  39952   2
com90xx                 5824   1
rfc1201                 5280   0 (unused)
arcnet                  9184   0 [com90xx rfc1201]
ipt_REDIRECT             704   1 (autoclean)
ipt_REJECT              2784   1 (autoclean)
iptable_filter          1648   0 (autoclean) (unused)
iptable_nat            13040   0 [ipt_REDIRECT]
ip_conntrack           13072   1 [ipt_REDIRECT iptable_nat]
ip_queue                5552   0 (unused)
ip_tables              10624   6 [ipt_REDIRECT ipt_REJECT iptable_filter 
iptable_nat]
rtc                     5632   0 (autoclean)

*Details
There is an arcnet interface in system
# ifconfig arc0
arc0      Link encap:ARCnet  HWaddr 03
          inet addr:193.125.1.254  Bcast:193.125.1.255  Mask:255.255.255.252
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:6548827 errors:7 dropped:3 overruns:0 frame:4
          TX packets:3498925 errors:16276 dropped:0 overruns:0 carrier:23344
          collisions:0 txqueuelen:30
          RX bytes:1953724850 (1863.2 Mb)  TX bytes:305177825 (291.0 Mb)
          Interrupt:3 Base address:0x300 Memory:d0000-d07ff

First problem:
# arping -D -I arc0 193.125.1.253
ARPING 193.125.1.88 from 0.0.0.0 arc0
Segmentation fault

arc0: arcnet_header: Yikes!  skb->len(0) != len(18)!
Unable to handle kernel NULL pointer dereference at virtual address 00000064
 printing eip:
d084285b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d084285b>]    Not tainted
EFLAGS: 00010282
eax: 000000ff   ebx: c2a3b9c0   ecx: 000000ff   edx: d084336c
esi: cf6ef000   edi: 00000000   ebp: 00000806   esp: c7c43de0
ds: 0018   es: 0018   ss: 0018
Process arping (pid: 18604, stackpage=c7c43000)
Stack: ffa3b9c0 c2a3b9c0 cf6ef000 cfd7f000 00000806 d083a63d c2a3b9c0 00000806
       000000ff c2a3b9c0 cfd7f000 c7c43ed0 00000012 c01d7227 c2a3b9c0 cfd7f000
       00000806 c7c43efc 00000000 00000012 c7c43efc 06080000 cf607500 ffffffea
Call Trace: [<d083a63d>] [<c01d7227>] [<c0122deb>] [<c019899b>] [<c0198500>]
   [<c01996ed>] [<c010fd9e>] [<c0166435>] [<c011bc02>] [<c0199e97>] 
[<c0106ceb>]

Code: 8b 77 64 83 ab 80 00 00 00 08 83 43 5c 08 8b 8b 80 00 00 00

Second problem:
There are lot of "kernel:   arc0: get_arcbuf: BUG: no buffers are 
available??" messages in logs.

Please ask if you are interested in more details which I might forget to 
write. If you have any comments/patches please send it as well.

	Petr Bavorovsky,
	Novosibirsk, Russian Federation.
