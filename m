Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266620AbUBDWNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266624AbUBDWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:13:00 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:1979 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S266620AbUBDWMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:12:42 -0500
Date: Wed, 4 Feb 2004 14:12:33 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: oops w/ 2.4.23, possibly sk98lin related
Message-ID: <Pine.LNX.4.58.0402041351370.18120@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a set of machines running 2.4.23.  They are all single CPU
machines.  They each have one onboard eepro100 (using the eepro100 driver)
and one gig-e syskonnect 9844 (using the sk98lin driver).  Every few days,
the machines lock up.

I've connected via serial console to one of them and attempted to reboot
using the magic sysrq.  First, I tried to sync the disks, but it oopsed.
The decoded oops is below.

Are there any known problems with the sk98lin driver in stock 2.4.2[34]?
(I've duplicated the issue with 2.4.24.)


-Chris

Script started on Wed Feb  4 13:49:29 2004
cbs has logged on pts/0 from hashbrown.cts.ucla.edu
cbs@ancho:~ > ksymoops -m /boot/System.map-2.4.23 < oops


ksymoops 2.4.5 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (specified)

kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113f35>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: 00000000   ecx: cf4e8000   edx: 00000001
esi: cfbdc0c0   edi: c9976000   ebp: c9977ac8   esp: c9977a98
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 5812, stackpage=c9977000)
Stack: c027fd1e 00000002 cfbdc0c0 c9976000 c9977ac4 c011c12c c037d5c0 00000002
       cfbdc0c0 00000000 c9976000 c9977af0 c9977af0 c0137c38 cfbdc0c0 00000005
       cfd9a0e0 c9977ae0 00000000 c9976000 cfbdc10c cfbdc10c c9977b0c c0137e4a
Call Trace:    [<c011c12c>] [<c0137c38>] [<c0137e4a>] [<c0137e95>] [<c0137ee0>]
  [<c0138053>] [<c01b57da>] [<c01b5859>] [<c0116fe4>] [<c011a625>] [<c01077bc>]
  [<c010759e>] [<c010783e>] [<c022263b>] [<c01ada32>] [<c0107094>] [<d08aea85>]
  [<c022263b>] [<d08aea85>] [<d08aea8d>] [<d08aea85>] [<d08ae970>] [<c022fa4d>]
  [<c022658d>] [<c023b269>] [<c022f1e3>] [<c0239db5>] [<c023b1a4>] [<c023a15d>]
  [<c024a65c>] [<c024a704>] [<c02222f0>] [<c024b154>] [<c024bf2a>] [<c0241f85>]
  [<c0221873>] [<c025c1aa>] [<c021f3ec>] [<c021f903>] [<c0137909>] [<c013659e>]
  [<c0119f39>] [<c011a70e>] [<c011a904>] [<c0106fa3>]
Code: 0f 0b 34 02 16 fd 27 c0 83 c4 04 8b 4d f8 83 79 1c 00 7c 07


>>EIP; c0113f35 <schedule+4d/520>   <=====

>>ecx; cf4e8000 <_end+f15090c/1050990c>
>>esi; cfbdc0c0 <_end+f8449cc/1050990c>
>>edi; c9976000 <_end+95de90c/1050990c>
>>ebp; c9977ac8 <_end+95e03d4/1050990c>
>>esp; c9977a98 <_end+95e03a4/1050990c>

Trace; c011c12c <__run_task_queue+60/70>
Trace; c0137c38 <__wait_on_buffer+70/98>
Trace; c0137e4a <wait_for_buffers+6e/94>
Trace; c0137e95 <wait_for_locked_buffers+25/38>
Trace; c0137ee0 <sync_buffers+38/48>
Trace; c0138053 <fsync_dev+73/7c>
Trace; c01b57da <go_sync+12a/144>
Trace; c01b5859 <do_emergency_sync+65/fc>
Trace; c0116fe4 <panic+104/108>
Trace; c011a625 <do_exit+2d/2e4>
Trace; c01077bc <do_invalid_op+0/90>
Trace; c010759e <die+6a/6c>
Trace; c010783e <do_invalid_op+82/90>
Trace; c022263b <skb_over_panic+2b/3c>
Trace; c01ada32 <vt_console_print+2c6/2dc>
Trace; c0107094 <error_code+34/3c>
Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
Trace; c022263b <skb_over_panic+2b/3c>
Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
Trace; d08aea8d <[sk98lin]XmitFrame+bd/1e0>
Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
Trace; d08ae970 <[sk98lin]SkGeXmit+60/c0>
Trace; c022fa4d <qdisc_restart+6d/184>
Trace; c022658d <dev_queue_xmit+139/314>
Trace; c023b269 <ip_finish_output2+c5/124>
Trace; c022f1e3 <nf_hook_slow+103/180>
Trace; c0239db5 <ip_output+175/180>
Trace; c023b1a4 <ip_finish_output2+0/124>
Trace; c023a15d <ip_queue_xmit+39d/4ec>
Trace; c024a65c <tcp_transmit_skb+414/568>
Trace; c024a704 <tcp_transmit_skb+4bc/568>
Trace; c02222f0 <sock_def_readable+38/68>
Trace; c024b154 <tcp_write_xmit+174/2bc>
Trace; c024bf2a <tcp_send_fin+1a6/280>
Trace; c0241f85 <tcp_close+2c9/820>
Trace; c0221873 <sk_free+6f/78>
Trace; c025c1aa <inet_release+4a/58>
Trace; c021f3ec <sock_release+14/5c>
Trace; c021f903 <sock_close+27/3c>
Trace; c0137909 <fput+55/100>
Trace; c013659e <filp_close+a6/b4>
Trace; c0119f39 <put_files_struct+61/c8>
Trace; c011a70e <do_exit+116/2e4>
Trace; c011a904 <sys_wait4+0/3b8>
Trace; c0106fa3 <system_call+33/38>

Code;  c0113f35 <schedule+4d/520>
00000000 <_EIP>:
Code;  c0113f35 <schedule+4d/520>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113f37 <schedule+4f/520>
   2:   34 02                     xor    $0x2,%al
Code;  c0113f39 <schedule+51/520>
   4:   16                        push   %ss
Code;  c0113f3a <schedule+52/520>
   5:   fd                        std
Code;  c0113f3b <schedule+53/520>
   6:   27                        daa
Code;  c0113f3c <schedule+54/520>
   7:   c0 83 c4 04 8b 4d f8      rolb   $0xf8,0x4d8b04c4(%ebx)
Code;  c0113f43 <schedule+5b/520>
   e:   83 79 1c 00               cmpl   $0x0,0x1c(%ecx)
Code;  c0113f47 <schedule+5f/520>
  12:   7c 07                     jl     1b <_EIP+0x1b> c0113f50 <schedule+68/520>

 <0>Kernel panic: Aiee, killing interrupt handler!
cbs@ancho:~ > exit
Script done on Wed Feb  4 13:49:34 2004
