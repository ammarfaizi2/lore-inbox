Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTIPRbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIPRbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:31:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:41399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262063AbTIPRbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:31:20 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Date: Tue, 16 Sep 2003 19:31:24 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: oops in 2.4.23pre1, Promise-ide, samba
Message-ID: <3F67650C.29909.5081AF1@localhost>
In-reply-to: <Pine.LNX.4.44.0309161101150.1636-100000@logos.cnet>
References: <3F644006.22303.31C480A@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2003 at 11:04, Marcelo Tosatti wrote:

> 
> 
> Does the oops (panic) backtrace look the same on other kernels?
> 

In every trace the symbol skb_drop_fraglist is found, but I don't 
know its meaning. At the end of the mail I pasted 3 logs from kernel 
2.4.20 (with samba 2.2.7a and 2.2.8a with and without LVM/RAID).

Another user reported me of very similar problems. I quote: 
-----start of quotation-------------------------------
"I have been experiencing the exact same problems as you. My system 
is very similar to yours - P3 550/256MB/440BX based motherboard. I 
have been using RH9 with their kernel (2.4.20-20) and a stock 2.4.22. 
Nothing in the samba logs or /var/log/messages.  

I had been using a pair of Promise PDC20268 cards with (4 x 80GB SW-
RAID 5). After talking to the linux-IDE guys, they said that the 
cards were garbage. I swapped it with a 3ware card (configured as 
JBOD) and am still using SW RAID 5.  

When I copy large file sets (2-3Gig with CD images) my samba server 
just reboots with no messages or warnings. Small text files are fine. 
Its been very frustrating. The system was fine as a Win2k server with 
Promise. I haven't tried the 3ware card but I would assume that it 
would be fine.  

Kernel - 2.4.22 & Kernel 2.4.20-20.9 (RH 9)
Samba - 2.2.7a-8.9.0 (RH 9)"
-----end of quotation---------------------------------

An oops in kernel 2.4.20 with samba 2.2.7a (with LVM and RAID):

Oops: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003
CPU:    0
EIP:    0010:[<c022b217>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c522e6e0   ebx: 00200000   ecx: c522e6e0   edx: 00200000
esi: c3eee5c0   edi: c3eee61c   ebp: 00000784   esp: c031be08
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c031b000)
Stack: c3eee5c0 c022b2ce c3eee5c0 c3eee5c0 c6ca3140 c022b2eb c3eee5c0 
c6ca3264 
       c022b43b c3eee5c0 00000004 c025023e c3eee5c0 c6ca3198 00000000 
00029857 
       00000005 c6ca3264 00000005 00000002 c02507ec c6ca3140 fb179769 
c6ca3140 
Call Trace:    [<c022b2ce>] [<c022b2eb>] [<c022b43b>] [<c025023e>] 
[<c02507ec>]
  [<c0252f85>] [<c010e2e6>] [<c010a19e>] [<c025a8cf>] [<c025aed5>] 
[<c024284b>]
  [<c0242c20>] [<c022f8ff>] [<c022f9b6>] [<c022fb02>] [<c0122b1f>] 
[<c010a34c>]
  [<c0106f90>] [<c010c5f8>] [<c0106f90>] [<c0106fb4>] [<c0107012>] 
[<c0105000>]
Code: 8b 1b 8b 42 70 48 74 0a ff 4a 70 0f 94 c0 84 c0 74 07 52 e8 


>>EIP; c022b217 <skb_drop_fraglist+17/40>   <=====

>>eax; c522e6e0 <[raid1]raid1_retry_tail+132b454/257cdd4>
>>ecx; c522e6e0 <[raid1]raid1_retry_tail+132b454/257cdd4>
>>esi; c3eee5c0 <[lvm-mod]lvm_mp_failqueue_lock+8e63c/a00dc>
>>edi; c3eee61c <[lvm-mod]lvm_mp_failqueue_lock+8e698/a00dc>
>>esp; c031be08 <init_task_union+1e08/2000>

Trace; c022b2ce <skb_release_data+6e/80>
Trace; c022b2eb <kfree_skbmem+b/70>
Trace; c022b43b <__kfree_skb+eb/140>
Trace; c025023e <tcp_clean_rtx_queue+10e/370>
Trace; c02507ec <tcp_ack+bc/3a0>
Trace; c0252f85 <tcp_rcv_established+495/830>
Trace; c010e2e6 <timer_interrupt+126/180>
Trace; c010a19e <handle_IRQ_event+4e/80>
Trace; c025a8cf <tcp_v4_do_rcv+12f/170>
Trace; c025aed5 <tcp_v4_rcv+5c5/660>
Trace; c024284b <ip_local_deliver+19b/1c0>
Trace; c0242c20 <ip_rcv+3b0/3c0>
Trace; c022f8ff <netif_receive_skb+16f/1a0>
Trace; c022f9b6 <process_backlog+86/130>
Trace; c022fb02 <net_rx_action+a2/110>
Trace; c0122b1f <do_softirq+5f/b0>
Trace; c010a34c <do_IRQ+9c/b0>
Trace; c0106f90 <default_idle+0/30>
Trace; c010c5f8 <call_do_IRQ+5/d>
Trace; c0106f90 <default_idle+0/30>
Trace; c0106fb4 <default_idle+24/30>
Trace; c0107012 <cpu_idle+32/60>
Trace; c0105000 <_stext+0/0>

Code;  c022b217 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c022b217 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c022b219 <skb_drop_fraglist+19/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c022b21c <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c022b21d <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c022b21f <skb_drop_fraglist+1f/40>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  c022b222 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c022b225 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c022b227 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c022b229 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c022b22a <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!


An oops in kernel 2.4.20 with samba 2.2.8a (again with LVM + RAID):

Oops: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003
CPU:    0
EIP:    0010:[<c022b217>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c51f2ee0   ebx: 00200000   ecx: c51f2ee0   edx: 00200000
esi: c6a99a60   edi: c6a99abc   ebp: 00000046   esp: c031bf38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c031b000)
Stack: c6a99a60 c022b2ce c6a99a60 c6a99a60 c6a99a60 c022b2eb c6a99a60 
c6a9f380
       c022b43b c6a99a60 fffffffd c022f776 c6a99a60 00000001 c0346f48 
c0122b1f
       c0346f48 00000002 0000000e d3dcdfa0 c031bfa4 c010a34c c0106f90 
c031a000
Call Trace:    [<c022b2ce>] [<c022b2eb>] [<c022b43b>] [<c022f776>] 
[<c0122b1f>]
  [<c010a34c>] [<c0106f90>] [<c010c5f8>] [<c0106f90>] [<c0106fb4>] 
[<c0107012>]
  [<c0105000>]
Code: 8b 1b 8b 42 70 48 74 0a ff 4a 70 0f 94 c0 84 c0 74 07 52 e8


>>EIP; c022b217 <skb_drop_fraglist+17/40>   <=====

>>eax; c51f2ee0 <[nfsd].data.end+f20fe1/fee161>
>>ecx; c51f2ee0 <[nfsd].data.end+f20fe1/fee161>
>>esp; c031bf38 <init_task_union+1f38/2000>

Trace; c022b2ce <skb_release_data+6e/80>
Trace; c022b2eb <kfree_skbmem+b/70>
Trace; c022b43b <__kfree_skb+eb/140>
Trace; c022f776 <net_tx_action+86/a0>
Trace; c0122b1f <do_softirq+5f/b0>
Trace; c010a34c <do_IRQ+9c/b0>
Trace; c0106f90 <default_idle+0/30>
Trace; c010c5f8 <call_do_IRQ+5/d>
Trace; c0106f90 <default_idle+0/30>
Trace; c0106fb4 <default_idle+24/30>
Trace; c0107012 <cpu_idle+32/60>
Trace; c0105000 <_stext+0/0>

Code;  c022b217 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c022b217 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c022b219 <skb_drop_fraglist+19/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c022b21c <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c022b21d <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c022b21f <skb_drop_fraglist+1f/40>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  c022b222 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c022b225 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c022b227 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c022b229 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c022b22a <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!


And last an oops in 2.4.20 with samba 2.2.8a without LVM and without 
RAID:

Oops: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003
CPU:    0
EIP:    0010:[<c022b217>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c428e6e0   ebx: 00200000   ecx: c428e6e0   edx: 00200000
esi: c940ee60   edi: c940eebc   ebp: 00000046   esp: cb4d9cb8
ds: 0018   es: 0018   ss: 0018
Process tail (pid: 1780, stackpage=cb4d9000)
Stack: c940ee60 c022b2ce c940ee60 c940ee60 c940ee60 c022b2eb c940ee60 
c2d09c00
       c022b43b c940ee60 fffffff9 c022f776 c940ee60 00000003 c0346f48 
c0122b1f
       c0346f48 00000006 0000000e d3dcdfa0 cb4d9d24 c010a34c c464421e 
d488f350
Call Trace:    [<c022b2ce>] [<c022b2eb>] [<c022b43b>] [<c022f776>] 
[<c0122b1f>]
  [<c010a34c>] [<c010c5f8>] [<c021b096>] [<c0215ac7>] [<c0216558>] 
[<c0216db8>]
  [<c01c19c5>] [<c01c34c0>] [<c01c48af>] [<c01c57e2>] [<c01c6443>] 
[<c01b7dbc>]
  [<c01b95be>] [<c0159c01>] [<c01b5737>] [<c01b9450>] [<c0144b08>] 
[<c0108c33>]
Code: 8b 1b 8b 42 70 48 74 0a ff 4a 70 0f 94 c0 84 c0 74 07 52 e8


>>EIP; c022b217 <skb_drop_fraglist+17/40>   <=====

>>eax; c428e6e0 <[ipv6]ip6_fl_gc_timer+ad980/c87300>
>>ecx; c428e6e0 <[ipv6]ip6_fl_gc_timer+ad980/c87300>

Trace; c022b2ce <skb_release_data+6e/80>
Trace; c022b2eb <kfree_skbmem+b/70>
Trace; c022b43b <__kfree_skb+eb/140>
Trace; c022f776 <net_tx_action+86/a0>
Trace; c0122b1f <do_softirq+5f/b0>
Trace; c010a34c <do_IRQ+9c/b0>
Trace; c010c5f8 <call_do_IRQ+5/d>
Trace; c021b096 <fbcon_cfb16_putcs+326/3e0>
Trace; c0215ac7 <fbcon_putcs_tl+57/130>
Trace; c0216558 <fbcon_redraw+1e8/340>
Trace; c0216db8 <fbcon_scroll+508/c60>
Trace; c01c19c5 <scrup+1e5/200>
Trace; c01c34c0 <lf+60/70>
Trace; c01c48af <do_con_trol+bf/cd0>
Trace; c01c57e2 <do_con_write+322/930>
Trace; c01c6443 <con_put_char+33/40>
Trace; c01b7dbc <opost+ac/190>
Trace; c01b95be <write_chan+16e/200>
Trace; c0159c01 <update_atime+51/60>
Trace; c01b5737 <tty_write+157/230>
Trace; c01b9450 <write_chan+0/200>
Trace; c0144b08 <sys_write+78/100>
Trace; c0108c33 <system_call+33/40>

Code;  c022b217 <skb_drop_fraglist+17/40>
00000000 <_EIP>:
Code;  c022b217 <skb_drop_fraglist+17/40>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c022b219 <skb_drop_fraglist+19/40>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c022b21c <skb_drop_fraglist+1c/40>
   5:   48                        dec    %eax
Code;  c022b21d <skb_drop_fraglist+1d/40>
   6:   74 0a                     je     12 <_EIP+0x12>
Code;  c022b21f <skb_drop_fraglist+1f/40>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  c022b222 <skb_drop_fraglist+22/40>
   b:   0f 94 c0                  sete   %al
Code;  c022b225 <skb_drop_fraglist+25/40>
   e:   84 c0                     test   %al,%al
Code;  c022b227 <skb_drop_fraglist+27/40>
  10:   74 07                     je     19 <_EIP+0x19>
Code;  c022b229 <skb_drop_fraglist+29/40>
  12:   52                        push   %edx
Code;  c022b22a <skb_drop_fraglist+2a/40>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!



Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

