Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270261AbRHHB2i>; Tue, 7 Aug 2001 21:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRHHB23>; Tue, 7 Aug 2001 21:28:29 -0400
Received: from defout.telus.net ([199.185.220.240]:1791 "EHLO
	priv-edtnes27-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S270261AbRHHB20>; Tue, 7 Aug 2001 21:28:26 -0400
Date: Tue, 7 Aug 2001 18:11:59 -0700 (PDT)
From: winterlion <winterlion@fsj.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: AMD Duron + Via motherboard oops - will this help?
Message-ID: <Pine.LNX.4.30.0108071753040.6705-100000@sigil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please CC any responses to me - I am not subscribed to linux-kernel

There's an ISP I maintain (long distance) who has had occasional system halts
due to "interrupt missed, system halted" (IIRC) from the entire 2.4.x kernel
line.  Now in 2.4.7 the first "oops" has appeared.  I have a whole collection
of the logs and (afaik) the system is still up - 'sync' repaired the problem
for now.

last was called with no arguments; ran for a while and then segmentation fault
This is the kernel log from -that- oops:

Aug  7 17:05:12 pd1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Aug  7 17:05:12 pd1 kernel:  printing eip:
Aug  7 17:05:12 pd1 kernel: c0141010
Aug  7 17:05:12 pd1 kernel: *pde = 00000000
Aug  7 17:05:12 pd1 kernel: Oops: 0000
Aug  7 17:05:12 pd1 kernel: CPU:    0
Aug  7 17:05:12 pd1 kernel: EIP:    0010:[prune_dcache+16/328]
Aug  7 17:05:12 pd1 kernel: EFLAGS: 00010213
Aug  7 17:05:12 pd1 kernel: eax: 00001a38   ebx: 00000000   ecx: 00000006   edx: 00000004
Aug  7 17:05:12 pd1 kernel: esi: 000007c2   edi: 00000001   ebp: 00001a38   esp: c17e1e90
Aug  7 17:05:12 pd1 kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 17:05:12 pd1 kernel: Process last (pid: 19133, stackpage=c17e1000)
Aug  7 17:05:12 pd1 kernel: Stack: 000000d2 000007c2 00000001 00000010 c01413a1 00001a38 c01296f3 00000006
Aug  7 17:05:12 pd1 kernel:        000000d2 000000d2 00000001 c17e0000 c02ddac8 00000000 c012984e 000000d2
Aug  7 17:05:12 pd1 kernel:        00000001 c17e0000 c012a430 000000d2 000000d2 cfb9e124 0000045d cff6bda8
Aug  7 17:05:12 pd1 kernel: Call Trace: [shrink_dcache_memory+33/48] [do_try_to_free_pages+39/88] [try_to_free_pages+34/44] [__alloc_pages+460/632] [_alloc_pages+22/24] [generic_file_readahead+468/636] [do_generic_file_read+842/1232]
Aug  7 17:05:12 pd1 kernel:        [generic_file_read+89/116] [file_read_actor+0/224] [sys_read+149/204] [system_call+51/64]
Aug  7 17:05:12 pd1 kernel:
Aug  7 17:05:12 pd1 kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46

After this I called "sync" and last worked to completion - as did perl (which
also triggered oopses earlier same day)

uname -a:
Linux pd1.fsj.net 2.4.7 #18 Sun Jul 22 23:19:39 MST 2001 i686 unknown

uptime:
  5:18pm  up 5 days,  2:16, 18 users,  load average: 0.09, 0.07, 0.01

I don't know what else you need - it's an AMD Duron 600 processor on a VIA
Apollo PRO133x chipset motherboard.  Additional hardware includes a Cyclom Y
multiport serial, 3c509b 100BaseTX Cyclone (rev36) network card, and an ATI 3D
Rage Pro videocard.  256MB ram; 384MB swap.

I've heard of problems with AMD + Via chipset problems so I posted this.
I have more log information, more oops references, and several of the
/proc files recorded from the same time period.  Looks to me like the
swap memory management system is having some kind of problem.  If this
system was not an active ISP I'd probably attempt to debug this.  My own
system (same motherboard chipset but with Celeron 733 processor) has had
no oopses whatsoever in many months.  I'm an experienced C programmer,
and fairly familiar with kernel internals.  Been a happy linux user since
december 1992 :)

G'day, eh? :)
	- Teunis Peters

