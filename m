Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSL2LD5>; Sun, 29 Dec 2002 06:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbSL2LD5>; Sun, 29 Dec 2002 06:03:57 -0500
Received: from tag.witbe.net ([81.88.96.48]:55047 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266512AbSL2LDz>;
	Sun, 29 Dec 2002 06:03:55 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.5.53 - Oops] CPU Frequency scaling
Date: Sun, 29 Dec 2002 12:12:15 +0100
Message-ID: <009d01c2af2b$24ecabe0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm playing around with 2.5.53 on my machine, and activating :
CPU Frequency scaling
  Intel Pentium 4 clock modulation

results in a oops at boot time.

Details :
 - Motherboard is P4S8X, 512 MB Ram, P4 2.4 Ghz
   (if you need more details, please ask)
 - Kernel : plain 2.5.53, no patch.
   Do you need a copy of the .config ?

Oops, from a serial console on the machine :

cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
divide error: 0000
CPU:    0
EIP:    0060:[<c0114879>]    Not tainted
EFLAGS: 00010246
eax: 0024f9b6   ebx: 0024f9b6   ecx: 00005ea8   edx: 00000000
esi: 51eb851f   edi: 00000000   ebp: dff8ff2c   esp: dff8fec4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=dff8e000 task=dff8c080)
Stack: 00000000 00000001 c04b9774 dff8ff2c 00000000 0000019a c01252b3
c04b9774 
       00000000 dff8ff2c 00000000 dff8ff2c 00000000 c012cbdb c0559474
00000000 
       dff8ff2c 00000000 00000008 00000000 0000019a c0114331 dff8ff2c
00000000 
Call Trace: [<c01252b3>]  [<c012cbdb>]  [<c0114331>]  [<c01144a5>]
[<c012cabc>]
  [<c012cd26>]  [<c0105058>]  [<c010502e>]  [<c0108b9d>] 
Code: f7 f7 0f af d1 89 c3 89 54 24 04 89 d0 0f af d9 31 d2 8b 0d 
 <0>Kernel panic: Attempted to kill init!


ksymoops decoding, after reboot in a 2.4.20 :

4 [12:07] rol@donald:~> more oops-cpufreq.decode 
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -v /kernels/linux-2.5.53/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.5.53 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0060:[<c0114879>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0024f9b6   ebx: 0024f9b6   ecx: 00005ea8   edx: 00000000
esi: 51eb851f   edi: 00000000   ebp: dff8ff2c   esp: dff8fec4
ds: 0068   es: 0068   ss: 0068
Stack: 00000000 00000001 c04b9774 dff8ff2c 00000000 0000019a c01252b3
c04b9774 
       00000000 dff8ff2c 00000000 dff8ff2c 00000000 c012cbdb c0559474
00000000 
       dff8ff2c 00000000 00000008 00000000 0000019a c0114331 dff8ff2c
00000000 
Call Trace: [<c01252b3>]  [<c012cbdb>]  [<c0114331>]  [<c01144a5>]
[<c012cabc>]
  [<c012cd26>]  [<c0105058>]  [<c010502e>]  [<c0108b9d>] 
Code: f7 f7 0f af d1 89 c3 89 54 24 04 89 d0 0f af d9 31 d2 8b 0d 


>>EIP; c0114879 <time_cpufreq_notifier+14f/208>   <=====

Trace; c01252b3 <notifier_call_chain+27/3e>
Trace; c012cbdb <cpufreq_notify_transition+d9/12e>
Trace; c0114331 <cpufreq_p4_setdc+a1/1a0>
Trace; c01144a5 <cpufreq_p4_setpolicy+75/c6>
Trace; c012cabc <cpufreq_set_policy+178/1be>
Trace; c012cd26 <cpufreq_register+f6/14a>
Trace; c0105058 <init+2a/142>
Trace; c010502e <init+0/142>
Trace; c0108b9d <kernel_thread_helper+5/c>

Code;  c0114879 <time_cpufreq_notifier+14f/208>
00000000 <_EIP>:
Code;  c0114879 <time_cpufreq_notifier+14f/208>   <=====
   0:   f7 f7                     div    %edi   <=====
Code;  c011487b <time_cpufreq_notifier+151/208>
   2:   0f af d1                  imul   %ecx,%edx
Code;  c011487e <time_cpufreq_notifier+154/208>
   5:   89 c3                     mov    %eax,%ebx
Code;  c0114880 <time_cpufreq_notifier+156/208>
   7:   89 54 24 04               mov    %edx,0x4(%esp,1)
Code;  c0114884 <time_cpufreq_notifier+15a/208>
   b:   89 d0                     mov    %edx,%eax
Code;  c0114886 <time_cpufreq_notifier+15c/208>
   d:   0f af d9                  imul   %ecx,%ebx
Code;  c0114889 <time_cpufreq_notifier+15f/208>
  10:   31 d2                     xor    %edx,%edx
Code;  c011488b <time_cpufreq_notifier+161/208>
  12:   8b 0d 00 00 00 00         mov    0x0,%ecx

 <0>Kernel panic: Attempted to kill init!

If you need more info, if there is a standard bug report form,
please tell !

Paul Rolland, rol@as2917.net

