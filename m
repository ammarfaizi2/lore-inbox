Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbQLJS0Q>; Sun, 10 Dec 2000 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131703AbQLJS0G>; Sun, 10 Dec 2000 13:26:06 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:32785 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131576AbQLJSZ5>;
	Sun, 10 Dec 2000 13:25:57 -0500
Date: Sun, 10 Dec 2000 18:55:28 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012101755.SAA24734@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.0-test12-pre7
Cc: xburge01@stud.fee.vutbr.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

For a long time, I experienced Oops with 2.4.0-testxx-prexx. I've reported
several Oops. With every patch, the system crashes with a Oops and is frozen.
The attached Oops was recorded by hand. Even the 'magic keys' are not working.
After booting the sytem, the filesystem is corrupted with lot of stuff in the
/lost+found. The system is stable with 2.2.18prexx.

I've attached :
 - the raw Oops
 - the Oops processed by ksymoops
 - data about my configuration
 - reflexions about the suspected program

1 - raw Oops
============

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01149f4
*pde= 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01149f4>]
EFLAGS: 00010082
eax: c31e0f54	ebc: 00000000	ecx: c31e0f54	edx: 00000000
esi: fffffff8	edi: c02166dc	ebp: c01e5f3c	esp: c01e5f14
ds: 0018	es: 0018	ss: 0018
Process swapper (pid: 0, stackpage= c01e5000)
Stack: c31e0f50	c32ff040 c02166dc 00000000 c31e0f54 00000246 00000000 00000001
       00000001 00000001 c01e5fa4 c017cc2f c32ff040 c3e3c080 c017c50f c32ff040
       00000000 c017d0a3 c3e3c080 00000000 c02166dc c017ec53 c3r3c080 00000001
Call Trace: [<c017cc2f>] [<c017c50f>] [<c017d0a3>] [<c017ec53>] [<c011a3a0>] [<c010111>] [<c0107120>]
	    [<ffffe000>] [<c0108e50>] [<c0107120>] [<ffffe000>] [<c0107143>] [<c01071a7>] [<c0105000>] [<c0100191>]
Code: 8b 21 89 55 e4 8b 5e 04 8b 03 85 45 fc 74 e0 83 7d f4 00 74
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing!

2 - Oops processed by ksymoops
==============================

ksymoops 2.3.5 on i586 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01149f4
Oops: 0000
CPU: 0
EIP: 0010:[<c01149f4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c31e0f54   ebc: 00000000     ecx: c31e0f54       edx: 00000000
esi: fffffff8   edi: c02166dc     ebp: c01e5f3c       esp: c01e5f14
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage= c01e5000)
Stack: c31e0f50 c32ff040 c02166dc 00000000 c31e0f54 00000246 00000000 00000001
       00000001 00000001 c01e5fa4 c017cc2f c32ff040 c3e3c080 c017c50f c32ff040
       00000000 c017d0a3 c3e3c080 00000000 c02166dc c017ec53 c3r3c080 00000001
Call Trace: [<c017cc2f>] [<c017c50f>] [<c017d0a3>] [<c017ec53>] [<c011a3a0>] [<c010111>] [<c0107120>]
            [<ffffe000>] [<c0108e50>] [<c0107120>] [<ffffe000>] [<c0107143>] [<c01071a7>] [<c0105000>] [<c0100191>]
Code: 8b 21 89 55 e4 8b 5e 04 8b 03 85 45 fc 74 e0 83 7d f4 00 74

>>EIP; c01149f4 <__wake_up+a4/12c>   <=====
Trace; c017cc2f <sock_def_write_space+33/78>
Trace; c017c50f <sock_wfree+17/30>
Trace; c017d0a3 <__kfree_skb+7f/114>
Trace; c017ec53 <net_tx_action+4f/b0>
Trace; c011a3a0 <do_softirq+40/64>
Trace; 0c010111 Before first symbol
Trace; c0107120 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+3b79e8e1/????>
Trace; c0108e50 <ret_from_intr+0/20>
Trace; c0107120 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+3b79e8e1/????>
Trace; c0107143 <default_idle+23/28>
Trace; c01071a7 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c01149f4 <__wake_up+a4/12c>
00000000 <_EIP>:
Code;  c01149f4 <__wake_up+a4/12c>   <=====
   0:   8b 21                     mov    (%ecx),%esp   <=====
Code;  c01149f6 <__wake_up+a6/12c>
   2:   89 55 e4                  mov    %edx,0xffffffe4(%ebp)
Code;  c01149f9 <__wake_up+a9/12c>
   5:   8b 5e 04                  mov    0x4(%esi),%ebx
Code;  c01149fc <__wake_up+ac/12c>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c01149fe <__wake_up+ae/12c>
   a:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0114a01 <__wake_up+b1/12c>
   d:   74 e0                     je     ffffffef <_EIP+0xffffffef> c01149e3 <__wake_up+93/12c>
Code;  c0114a03 <__wake_up+b3/12c>
   f:   83 7d f4 00               cmpl   $0x0,0xfffffff4(%ebp)
Code;  c0114a07 <__wake_up+b7/12c>
  13:   74 00                     je     15 <_EIP+0x15> c0114a09 <__wake_up+b9/12c>

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

3 - configuration 
=================

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.18 #1 dim déc 10 11:32:45 CET 2000 i586 unknown
Kernel modules         2.3.22
Gnu C                  2.95.2
Binutils               2.9.5.0.41
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         af_packet scc ax25 parport_pc lp parport mousedev usb-uhci hid usbcore input autofs lockd sunrpc serial unix

The computer is a Pentium 200MMx with 32Mb SDRAM. 

4 - suspected program 
---------------------
I'm an hamradio. So I use ax25 and hamradio stuff. I run several programs ,
daemons and drivers related to this activity.
I use a so called 'terminal program' called TNT. And there is a daemon called
'ulistd' which monitor the radio channel which extract data from incoming
frames from a local BBS.
When I start TNT alone with the required drivers, I have not the Oops or only
after several hours up. If I start TNT and, in the same script 'ulistd' (like
with 2.2.18pre), I get the Oops as soon as the daemon is started. 

I've found some informations (very few in the system log) : 
When I start TNT, I've the message : 
kernel: tnt uses obsolete (PF_INET,SOCK_PACKET)

When I start ulistd (ONLY with 2.4.0.testxx-prexx), I've the following message :
ax25_sendmsg(): ulistd uses obsolete socket structure

ulistd is part of a package called 'linpac', ulistd is part of ax25mail-utils,
it can be found at : http://www.stud.fee.vutbr.cz/~xburge01/linpac. The author
is Radek Burget.

Remark : even if the problem is with ulistd, I think it is not very polite for
a well educated operating system to suicide when there is a problem.  ;-)

------------

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
