Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbTCQMD2>; Mon, 17 Mar 2003 07:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbTCQMD2>; Mon, 17 Mar 2003 07:03:28 -0500
Received: from new-tonge.zetnet.co.uk ([194.247.47.231]:5826 "EHLO
	mailout.zetnet.co.uk") by vger.kernel.org with ESMTP
	id <S261627AbTCQMD0>; Mon, 17 Mar 2003 07:03:26 -0500
Message-ID: <005901c2ec7f$245ea7a0$0800000a@wormhole>
From: "Dan Searle" <dan@intrago.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: (kern.log) kernel BUG at shmem.c:486!
Date: Mon, 17 Mar 2003 12:17:12 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Total system lockup due to 2.4.19 kernel crashing after: (kern.log)
kernel BUG at shmem.c:486!

Description: One of our customers Linux gateway/firewall/proxy servers keeps
failing, sometimes the kern.log shows the following just prior to the kernel
locking up (from kern.log)...

Mar  7 16:13:16 censornet-halewood kernel: Neighbour table overflow.
Mar  7 16:13:21 censornet-halewood kernel: NET: 445 messages suppressed.
Mar  7 16:13:21 censornet-halewood kernel: Neighbour table overflow.

Which is funny, because the linux box is sitting on a LAN with no more than
500 (definatly no more than 1000) machines on it, the other end is plugged
into a private WAN, and connections are made only with the one upstream
gateway/proxy machine on the WAN.

After a while the system crashes out, and sometimes the kern.log shows the
following stack trace etc...

Mar  7 18:44:48 censornet-halewood kernel: kernel BUG at shmem.c:486!
Mar  7 18:44:48 censornet-halewood kernel: invalid operand: 0000
Mar  7 18:44:48 censornet-halewood kernel: CPU:    0
Mar  7 18:44:48 censornet-halewood kernel:
EIP:0010:[shmem_writepage+177/296]    Not tainted
Mar  7 18:44:48 censornet-halewood kernel: EFLAGS: 00010206
Mar  7 18:44:48 censornet-halewood kernel: eax: cb7eb510   ebx: c1273ca8ecx:
cbb75000   edx: 00000001
Mar  7 18:44:48 censornet-halewood kernel: esi: c8f4109c   edi: cb7eb580ebp:
00760d00   esp: c12ebf2c
Mar  7 18:44:48 censornet-halewood kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:44:48 censornet-halewood kernel: Process kswapd (pid:
5,stackpage=c12eb000)
Mar  7 18:44:48 censornet-halewood kernel: Stack: 00000000 c1273ca8
00000002000024a3 cb7eb460 00000437 cb7eb510 00760d00
Mar  7 18:44:48 censornet-halewood kernel:        c0130b79 c1273ca8
00000020000001d0 00000020 00000006 c12ea000 c12ea000
Mar  7 18:44:48 censornet-halewood kernel:        00000200 000001d0
c0334174c0130e90 00000006 00000000 00000006 000001d0
Mar  7 18:44:48 censornet-halewood kernel: Call Trace:
[shrink_cache+517/972] [shrink_caches+92/132] [try_to_free_pages+52/84]
[kswapd_balance_pgdat+71/144] [kswapd_balance+22/44]
Mar  7 18:44:48 censornet-halewood kernel:
[kswapd+155/182][kernel_thread+40/56]
Mar  7 18:44:48 censornet-halewood kernel:
Mar  7 18:44:48 censornet-halewood kernel: Code: 0f 0b e6 01 00 5e 2c c0 53
e8 75 45 ff ff 31 d2 89 d8 e8 a4

This occurs on average once every 2 days (there is some pattern in the
failure, generally in the evening, but no explanation for this). We have the
exact same kernel and very similar network setup working fine at about 12
other sites, so this one is a bit of a rogue mistery.

Keywords: shmem.c neighbor table overflow kernel bug

/proc/version: Linux version 2.4.19 (root@censornet-halewood) (gcc version
2.95.4 20011002 (Debian prerelease)) #77 SMP Thu Mar 27 09:32:36 GMT 2003

Environment: Linux box running as a squid/filtering proxy/firewall/gateway
(iptables) with 2 ethernet NICS (public and private).

Software: squid 2.5, DansGuardain 2.4 (customised), PostgreSQL, mrtg,
apache, dnrd, apcupsd, (ext3 FS) + all the usual suspects like cron etc....
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         3c59x

Processor information:
processor : 0
vendor_id : AuthenticAMD
cpu family : 6
model  : 4
model name : AMD Athlon(tm) Processor
stepping : 4
cpu MHz  : 1400.091
cache size : 256 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips : 2791.83

All other info: N/A

Any suggestions?

Dan...

--

Dan Searle
Intrago Ltd
e: dan@intrago.co.uk <mailto:dan@intrago.co.uk>
t: +44 (0) 1454 227309 / f: +44 (0) 1454 228820
s: PO BOX 2000, Yate, Bristol, BS37 1DS.
http://www.intrago.co.uk

