Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288526AbSADHmw>; Fri, 4 Jan 2002 02:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288527AbSADHmn>; Fri, 4 Jan 2002 02:42:43 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:6857 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288526AbSADHmc>; Fri, 4 Jan 2002 02:42:32 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Date: Fri, 4 Jan 2002 08:42:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020104074233Z288526-13996+840@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the loop.c fix (nfs.o and sunrpc.o waiting) I got it running here, too.

2.4.17
sched-O1-2.4.17-A0.patch
00_nanosleep-5		(Andrea)
bootmem-2.4.17-pre6	(at all IBM)
elevator-fix		(Andrew, worth it for 2.4.18)

plus ReiserFS fixes
linux-2.4.17rc2-KLMN+exp_trunc+3fixes.patch
corrupt_items_checks.diff
kmalloc_cleanup.diff
O-inode-attrs.patch

To much trouble during 10_vm-21 (VM taken from 2.4.17rc2aa2) merge. So I 
skipped it this time. Much wanted for 2.4.18 (best I ever had).

All the above (with preempt and 10_vm-21 AA except sched-O1-2.4.17-A0.patch) 
didn't crashed before.

One system crash during the first X start up (kdeinit).

ksymoops 2.4.3 on i686 2.4.17-O1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-O1/ (default)
     -m /boot/System.map (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01194ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1a7ca40   ecx: c028e658   edx: dea3002c
esi: dea30000   edi: 00000000   ebp: bffff19c   esp: dea31fac
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 961, stackpage=dea31000)
Stack: dea30000 40e1ed40 00000000 c01194ee 00000000 c0106d0b 00000000 
00000001 
       40e208c4 40e1ed40 00000000 bffff19c 00000001 0000002b 0000002b 
00000001 
       40da84dd 00000023 00000287 bffff170 0000002b 
Call Trace: [<c01194ee>] [<c0106d0b>] 
Code: 0f 0b e9 74 fe ff ff 8d 74 26 00 8d bc 27 00 00 00 00 8b 44 

>>EIP; c01194ae <do_exit+1ee/200>   <=====
Trace; c01194ee <sys_exit+e/10>
Trace; c0106d0a <system_call+32/38>
Code;  c01194ae <do_exit+1ee/200>
00000000 <_EIP>:
Code;  c01194ae <do_exit+1ee/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01194b0 <do_exit+1f0/200>
   2:   e9 74 fe ff ff            jmp    fffffe7b <_EIP+0xfffffe7b> c0119328 
<do_exit+68/200>
Code;  c01194b4 <do_exit+1f4/200>
   7:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01194b8 <do_exit+1f8/200>
   b:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  c01194c0 <complete_and_exit+0/20>
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

System runs relatively smooth but is under full system load.

  7:57am  up  1:36,  1 user,  load average: 0.18, 0.18, 0.26
91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.7% user, 99.2% system,  0.0% nice,  0.0% idle
Mem:   643064K av,  464212K used,  178852K free,       0K shrd,   89964K buff
Swap: 1028120K av,    3560K used, 1024560K free                  179928K 
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1263 root      52   0  138M  42M  1728 S    33.0  6.7  16:46 X
 1669 nuetzel   62   0  7544 7544  4412 S    16.6  1.1  11:57 artsd
10891 nuetzel   46   0  113M  17M 12600 S    12.0  2.7   2:35 kmail
 1756 nuetzel   46   0  105M 9.9M  7288 S    10.8  1.5   7:45 kmix
 1455 nuetzel   45   0  109M  12M 10508 S     7.9  2.0   1:55 kdeinit
 1467 nuetzel   45   0  107M  10M  8456 S     5.5  1.7   0:55 kdeinit
 1414 nuetzel   45   0  105M 8916  7536 S     3.9  1.3   1:59 kdeinit
  814 squid     45   0  6856 6848  1280 S     2.3  1.0   0:52 squid
    6 root      45   0     0    0     0 SW    2.1  0.0   0:42 kupdated
 1458 nuetzel   45   0  109M  13M  9856 S     1.3  2.0   0:44 kdeinit
11099 nuetzel   47   0  1000 1000   776 R     1.3  0.1   0:00 top
  556 root      45   0  1136 1136   848 S     1.1  0.1   0:14 smpppd
 1678 nuetzel   45   0  7544 7544  4412 S     0.7  1.1   0:12 artsd
  494 root      45   0  3072 3072  1776 S     0.3  0.4   0:18 named
 1451 root      45   0  6860 6852  1416 S     0.1  1.0   0:14 xperfmon++
10871 nuetzel   45   0  111M  14M 11680 S     0.1  2.3   0:14 kdeinit
    1 root      46   0   212  212   176 S     0.0  0.0   0:06 init

/home/nuetzel> procinfo
Linux 2.4.17-O1 (root@SunWave1) (gcc 2.95.3 20010315 ) #1 1CPU [SunWave1.]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        643064      452988      190076           0      100096      183148
Swap:      1028120        3560     1024560

Bootup: Fri Jan  4 06:21:02 2002    Load average: 0.14 0.32 0.31 
1894046082/90 11460

user  :       0:16:59.19  14.9%  page in :   404106  disk 1:    31792r   
70750w
nice  :       0:00:00.00   0.0%  page out:  2580336  disk 2:      137r     
225w
system:       1:19:41.05  70.0%  swap in :        2  disk 3:        1r       
0w
idle  :       0:17:11.67  15.1%  swap out:      695  disk 4:     1009r       
0w
uptime:       1:53:51.90         context :  2427806

irq  0:    683191 timer                 irq  8:    154583 rtc
irq  1:     12567 keyboard              irq  9:         0 acpi, usb-ohci
irq  2:         0 cascade [4]           irq 10:    103402 aic7xxx
irq  5:      9333 eth1                  irq 11:    310704 eth0, EMU10K1
irq  7:       115 parport0 [3]          irq 12:    136392 PS/2 Mouse

More processes die during second and third boot...
I have some more crash logs if needed.

Preempt plus lock-break is better for now.
latencytest0.42-png crash the system.

What next?
Maybe a combination of O(1) and preempt?

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

