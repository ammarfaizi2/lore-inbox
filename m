Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJ1PCs>; Mon, 28 Oct 2002 10:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJ1PCs>; Mon, 28 Oct 2002 10:02:48 -0500
Received: from [216.118.93.42] ([216.118.93.42]:18816 "EHLO kelda.dhs.org")
	by vger.kernel.org with ESMTP id <S261292AbSJ1PCo>;
	Mon, 28 Oct 2002 10:02:44 -0500
Date: Mon, 28 Oct 2002 10:09:06 -0500
From: Conrad Lloyd-Knight <clloydknight@rudolphtech.com>
To: linux-kernel@vger.kernel.org
Subject: Oops when restarting PCMCIA network card
Message-ID: <20021028150906.GA587@kelda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has happened twice now, so I thought I'd try posting to see if
there are any suggestions for what might be causing it.

Here's the setup: Thinkpad laptop with a PCMCIA network card (a
3c574). I take it home weekends and plug it into my network there,
then on Monday do an "ifconfig eth0 down" and bring it into work and
run the following script (/usr/local/bin/neton in the logs below):

/sbin/cardctl eject 1
/sbin/cardctl insert 1
sleep 3
/sbin/dhcpcd -R

This normally works fine. However, last week and again today, I got a
kernel oops immediately after running this. I heard the double beeps
the laptop makes on the eject and insert and then got the oops message
on the screen. 

The only thing found in the logs is (three different log files):

Oct 28 08:39:02 kelda kernel: thinkpad: I have registered to handle major: 10 mi
nor: 170.
Oct 28 08:39:02 kelda kernel: smapi: 32-bit protected mode SMAPI BIOS found. :-)
Oct 28 08:39:02 kelda kernel: smapi: SMAPI BIOS return codes differ!
Oct 28 08:39:15 kelda last message repeated 17 times
Oct 28 08:39:23 kelda sudo:   conrad : TTY=tty1 ; PWD=/usr/local/home/conrad ; U
SER=root ; COMMAND=/usr/local/bin/neton
Oct 28 08:39:24 kelda kernel: smapi: SMAPI BIOS return codes differ!
Oct 28 08:39:24 kelda last message repeated 5 times
Oct 28 08:39:25 kelda kernel: eth0: Megahertz 574B at io 0x300, irq 3, hw_addr 0
0:01:03:81:5C:69.
Oct 28 08:39:25 kelda kernel:   ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect
 MII interface.
Oct 28 08:39:30 kelda kernel: eth0: found link beat
Oct 28 08:39:30 kelda kernel: eth0: link partner did not autonegotiate
--------------------
Oct 28 08:39:03 kelda cardmgr[67]: executing: './network resume eth0'
Oct 28 08:39:03 kelda apmd[124]: Now using Battery Power
Oct 28 08:39:03 kelda apmd[124]: Battery: * * * (92% 1:35)
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:06 kelda apmd[124]: Normal Resume after 01:13:32 (92% 1:35) Battery
 power
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:07 kelda apmd[124]: Normal Resume after 01:13:33 (92% 1:35) Battery
 power
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:16 kelda apmd[124]: Now using AC Power
Oct 28 08:39:16 kelda apmd[124]: Charge: * * * (92% 1:23)
Oct 28 08:39:23 kelda cardmgr[67]: executing: './network check eth0'
Oct 28 08:39:23 kelda cardmgr[67]: shutting down socket 1
Oct 28 08:39:23 kelda cardmgr[67]: executing: './network stop eth0'
Oct 28 08:39:24 kelda cardmgr[67]: executing: 'modprobe -r 3c574_cs'
Oct 28 08:39:24 kelda cardmgr[67]: initializing socket 1
Oct 28 08:39:24 kelda cardmgr[67]: socket 1: 3Com 572/574 Fast Ethernet
Oct 28 08:39:25 kelda cardmgr[67]: executing: 'modprobe 3c574_cs'
Oct 28 08:39:25 kelda cardmgr[67]: executing: './network start eth0'
--------------------
Oct 28 08:39:06 kelda kernel: snd: cs461x: hack for Thinkpad 600X/A20/T20 enable
d
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:06 kelda modprobe: modprobe: Can't locate module snd-card-3
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-1
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-2
Oct 28 08:39:07 kelda modprobe: modprobe: Can't locate module snd-card-3

And here is the actual oops (painstakingly copied onto paper and then
retyped, so it may not be 100% accurate):

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010 : [<cc8888d8>] Not tainted
EFLAGS: 00010246
eax: ffffffff   ebx: 00000030   ecx: 00000001   edx: ca68888c
esi: 00000000   edi: ca68888c   ebp: c020bedc   esp: c020beb4
ds: 0018   es: 0018   ss:0018
Process swapper (pid: 0, stackpage=c020b000)
Stack: 00000000 cc89e8b5 ca68888c c5d5bc08 c1333c60 00000000 c5d5bcac 00000300
       cc8cf3b0 00000001 c020bf3c cc888a52 ca68888c 00000046 c020bf0c 00000286
       00000000 c32c94a0 c32c94a0 c7ae6960 00000286 00000001 ca68888c 00000000
Call Trace: [<cc89e8b5>] [<cc8cf3b0>] [<cc888a52>] [<c0197e7d>] [<c0117fda>]
[<c0107e92>] [<c0105150>] [<c0105150>] [<c0109cd8>] [<c0105150>] [<c0105150>]
[<c0105173>] [<c01051d9>] [<c0105000>] [<c0105027>]
Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 05
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

The readme says to look up that EIP line in /usr/src/linux/vmlinux, but
the addresses there don't go anywhere near that high.

Finally, here is the result of running ksymoops on this:

ksymoops 2.4.7 on i686 2.4.17.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010 : [<cc8888d8>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: ffffffff   ebx: 00000030   ecx: 00000001   edx: ca68888c
esi: 00000000   edi: ca68888c   ebp: c020bedc   esp: c020beb4
ds: 0018   es: 0018   ss:0018
Process swapper (pid: 0, stackpage=c020b000)
Stack: 00000000 cc89e8b5 ca68888c c5d5bc08 c1333c60 00000000 c5d5bcac 00000300
       cc8cf3b0 00000001 c020bf3c cc888a52 ca68888c 00000046 c020bf0c 00000286
       00000000 c32c94a0 c32c94a0 c7ae6960 00000286 00000001 ca68888c 00000000
Call Trace: [<cc89e8b5>] [<cc8cf3b0>] [<cc888a52>] [<c0197e7d>] [<c0117fda>]
[<c0107e92>] [<c0105150>] [<c0105150>] [<c0109cd8>] [<c0105150>] [<c0105150>]
[<c0105173>] [<c01051d9>] [<c0105000>] [<c0105027>]
Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 05


>>EIP; cc8888d8 <END_OF_CODE+232f9/????>   <=====

>>edx; ca68888c <_end+a421694/c5ade08>
>>edi; ca68888c <_end+a421694/c5ade08>
>>ebp; c020bedc <init_task_union+1edc/2000>
>>esp; c020beb4 <init_task_union+1eb4/2000>

Trace; cc89e8b5 <END_OF_CODE+392d6/????>
Trace; cc8cf3b0 <END_OF_CODE+69dd1/????>
Trace; cc888a52 <END_OF_CODE+23473/????>
Trace; c0197e7d <net_rx_action+139/214>
Trace; c0117fda <do_softirq+5a/ac>
Trace; c0107e92 <do_IRQ+96/a8>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0109cd8 <call_do_IRQ+5/d>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105173 <default_idle+23/28>
Trace; c01051d9 <cpu_idle+41/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  cc8888d8 <END_OF_CODE+232f9/????>
00000000 <_EIP>:
Code;  cc8888d8 <END_OF_CODE+232f9/????>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  cc8888d9 <END_OF_CODE+232fa/????>
   1:   ae                        scas   %es:(%edi),%al
Code;  cc8888da <END_OF_CODE+232fb/????>
   2:   75 08                     jne    c <_EIP+0xc> cc8888e4 <END_OF_CODE+23305/????>
Code;  cc8888dc <END_OF_CODE+232fd/????>
   4:   84 c0                     test   %al,%al
Code;  cc8888de <END_OF_CODE+232ff/????>
   6:   75 f8                     jne    0 <_EIP>
Code;  cc8888e0 <END_OF_CODE+23301/????>
   8:   31 c0                     xor    %eax,%eax
Code;  cc8888e2 <END_OF_CODE+23303/????>
   a:   eb 04                     jmp    10 <_EIP+0x10> cc8888e8 <END_OF_CODE+23309/????>
Code;  cc8888e4 <END_OF_CODE+23305/????>
   c:   19 c0                     sbb    %eax,%eax
Code;  cc8888e6 <END_OF_CODE+23307/????>
   e:   0c 01                     or     $0x1,%al
Code;  cc8888e8 <END_OF_CODE+23309/????>
  10:   85 c0                     test   %eax,%eax
Code;  cc8888ea <END_OF_CODE+2330b/????>
  12:   75 05                     jne    19 <_EIP+0x19> cc8888f1 <END_OF_CODE+23312/????>

<0> Kernel panic: Aiee, killing interrupt handler!

So, does anyone know what might be causing this? Or if the oops even
makes much sense? Any suggestions greatly appreciated! 

-Conrad.
(PS: please Cc me... I tried subscribing once but my mailbox collapsed
under the volume :)


-------------------------------------------------------------
Dr. Conrad Lloyd-Knight
Technical Trainer
Rudolph Technologies, Inc.
One Rudolph Road
Flanders, NJ 07836
(973)4484330
