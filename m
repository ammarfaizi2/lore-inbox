Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSK0JqQ>; Wed, 27 Nov 2002 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSK0JqQ>; Wed, 27 Nov 2002 04:46:16 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:7429 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261855AbSK0JqO>; Wed, 27 Nov 2002 04:46:14 -0500
Message-ID: <20021127095058.21318.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "sanket rathi" <sanket@linuxmail.org>
To: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Date: Wed, 27 Nov 2002 17:50:57 +0800
Subject: kernel bug
X-Originating-Ip: 202.54.40.36
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am a writing a device driver. I have written a pci based driver for kernel 2.2.14-5.0 
and that is working fine and now i have ported that to (with minimal changes) kernel 
2.4.18-14 now also it is working. in that i have to reserve memory in kernel (i send user 
buffer address and lock (reserve) thart memory in kernel). but whenevr i start any other 
appication simultaneously then i got some kernel messages like following  
 
 
 
 
Nov 27 14:36:11 saturn kernel: ------------[ cut here ]------------ 
Nov 27 14:36:11 saturn kernel: kernel BUG at rmap.c:267! 
Nov 27 14:36:11 saturn kernel: invalid operand: 0000 
Nov 27 14:36:11 saturn kernel: cs46xx ac97_codec soundcore ccp3k autofs 3c59x 
iptable_filter ip_tables moused 
Nov 27 14:36:11 saturn kernel: CPU:    0 
Nov 27 14:36:11 saturn kernel: EIP:    0010:[<c013d197>]    Not tainted 
Nov 27 14:36:11 saturn kernel: EFLAGS: 00010206 
Nov 27 14:36:11 saturn kernel: 
Nov 27 14:36:11 saturn kernel: EIP is at try_to_unmap [kernel] 0x47 (2.4.18-14) 
Nov 27 14:36:11 saturn kernel: eax: 00024099   ebx: c100bd84   ecx: c100bd68   edx: 
c1000030 
Nov 27 14:36:11 saturn kernel: esi: c100bd68   edi: 000001db   ebp: 00000000   esp: 
cb00ddf8 
Nov 27 14:36:11 saturn kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 14:36:11 saturn kernel: Process gnuchess (pid: 2869, stackpage=cb00d000) 
Nov 27 14:36:11 saturn kernel: Stack: 00000029 00002900 c100bd68 c0138617 c0305380 
00000000 c100bd84 c100bd14 
Nov 27 14:36:11 saturn kernel:        000001db c100bd68 c0136429 c100bd68 00000003 
c03053cc 000002a0 000002a0 
Nov 27 14:36:11 saturn kernel:        00000000 c0305380 00000000 000001d2 00000000 
c0136658 c0305380 000001d2 
Nov 27 14:36:11 saturn kernel: Call Trace: [<c0138617>] add_to_swap [kernel] 0x67 
(0xcb00de04)) 
Nov 27 14:36:11 saturn kernel: [<c0136429>] page_launder_zone [kernel] 0x419 
(0xcb00de20)) 
Nov 27 14:36:11 saturn kernel: [<c0136658>] page_launder [kernel] 0x68 (0xcb00de4c)) 
Nov 27 14:36:11 saturn kernel: [<c0136a11>] do_try_to_free_pages [kernel] 0x11 
(0xcb00de68)) 
Nov 27 14:36:11 saturn kernel: [<c0136f29>] try_to_free_pages [kernel] 0x59 (0xcb00de7c)) 
Nov 27 14:36:11 saturn kernel: [<c0137d1c>] __alloc_pages [kernel] 0x16c (0xcb00de8c)) 
Nov 27 14:36:11 saturn kernel: [<c0130018>] common_sendfile [kernel] 0xb8 (0xcb00dea4)) 
Nov 27 14:36:11 saturn kernel: [<c012bb99>] do_anonymous_page [kernel] 0x59 (0xcb00dec0)) 
Nov 27 14:36:11 saturn kernel: [<c012bee9>] handle_mm_fault [kernel] 0x89 (0xcb00dee0)) 
Nov 27 14:36:11 saturn kernel: [<c01169f8>] do_page_fault [kernel] 0x138 (0xcb00df0c)) 
Nov 27 14:36:11 saturn kernel: [<c014ebcd>] __kill_fasync [kernel] 0x4d (0xcb00df34)) 
Nov 27 14:36:11 saturn kernel: [<c019576d>] handle_kbd_event [kernel] 0x3d (0xcb00df64)) 
Nov 27 14:36:12 saturn kernel: [<c01957ff>] keyboard_interrupt [kernel] 0xf (0xcb00df7c)) 
Nov 27 14:36:12 saturn kernel: [<c010a685>] handle_IRQ_event [kernel] 0x45 (0xcb00df80)) 
Nov 27 14:36:12 saturn kernel: [<c0117ce5>] schedule [kernel] 0x175 (0xcb00df90)) 
Nov 27 14:36:12 saturn kernel: [<c01168c0>] do_page_fault [kernel] 0x0 (0xcb00dfb0)) 
Nov 27 14:36:12 saturn kernel: [<c0109200>] error_code [kernel] 0x34 (0xcb00dfb8)) 
Nov 27 14:36:12 saturn kernel: 
Nov 27 14:36:12 saturn kernel: 
Nov 27 14:36:12 saturn kernel: Code: 0f 0b 0b 01 27 9a 25 c0 8b 46 18 83 e0 01 75 08 0f 
0b 0d 01 
 
 
The above message i got maximum time 
 
 
but one time i got oops so i run ksymoops and that has given me the following result  
 
 
ksymoops 2.4.5 on i686 2.4.18-14.  Options used 
     -V (default) 
     -k /proc/ksyms (default) 
     -l /proc/modules (default) 
     -o /lib/modules/2.4.18-14/misc/ccp3k.o (specified) 
     -m /boot/System.map-2.4.18-14 (default) 
 
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3 
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd 
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx 
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod 
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod 
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  
Trace may not be reliable. 
Warning (map_ksym_to_module): cannot match loaded module jbd to a unique module object.  
Trace may not be reliable. 
Warning (map_ksym_to_module): cannot match loaded module aic7xxx to a unique module 
object.  Trace may not be reliable. 
Warning (map_ksym_to_module): cannot match loaded module sd_mod to a unique module 
object.  Trace may not be reliable. 
Warning (map_ksym_to_module): cannot match loaded module scsi_mod to a unique module 
object.  Trace may not be reliable. 
Nov 27 13:41:06 saturn kernel: Unable to handle kernel NULL pointer dereference at 
virtual address 00000070 
Nov 27 13:41:06 saturn kernel: c013d269 
Nov 27 13:41:06 saturn kernel: *pde = 00000000 
Nov 27 13:41:06 saturn kernel: Oops: 0000 
Nov 27 13:41:06 saturn kernel: CPU:    0 
Nov 27 13:41:06 saturn kernel: EIP:    0010:[<c013d269>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386 
Nov 27 13:41:06 saturn kernel: EFLAGS: 00010212 
Nov 27 13:41:06 saturn kernel: eax: 00033919   ebx: c1000030   ecx: c03609f8   edx: 
00000000 
Nov 27 13:41:06 saturn kernel: esi: c1012748   edi: 00000022   ebp: c0305380   esp: 
c138ffa4 
Nov 27 13:41:06 saturn kernel: ds: 0018   es: 0018   ss: 0018 
Nov 27 13:41:06 saturn kernel: Process kswapd (pid: 5, stackpage=c138f000) 
Nov 27 13:41:06 saturn kernel: Stack: c1012764 c0136841 c0305380 00000002 c03053c4 
c138e000 00000000 000002c3 
Nov 27 13:41:06 saturn kernel:        c138e000 c0305380 c138e245 0008e000 c0136c94 
c0305380 00000006 c1b00018 
Nov 27 13:41:06 saturn kernel:        00010f00 c1b07fb8 c0105000 c010744e 00000000 
c0136b60 00000000 
Nov 27 13:41:06 saturn kernel: Call Trace: [<c0136841>] refill_inactive_zone [kernel] 
0x141 (0xc138ffa8)) 
Nov 27 13:41:06 saturn kernel: [<c0136c94>] kswapd [kernel] 0x134 (0xc138ffd4)) 
Nov 27 13:41:06 saturn kernel: [<c0105000>] stext [kernel] 0x0 (0xc138ffec)) 
Nov 27 13:41:06 saturn kernel: [<c010744e>] kernel_thread [kernel] 0x2e (0xc138fff0)) 
Nov 27 13:41:06 saturn kernel: [<c0136b60>] kswapd [kernel] 0x0 (0xc138fff8)) 
Nov 27 13:41:06 saturn kernel: Code: 8b 42 70 85 c0 74 12 39 42 5c 76 0d 8b 09 85 c9 75 
d5 b8 01 
 
>>EIP; c013d269 <page_over_rsslimit+29/50>   <===== 
 
>>eax; 00033919 Before first symbol 
>>ebx; c1000030 <_end+c2e4b0/104564e0> 
>>ecx; c03609f8 <isapnp_setup_reserve_irq+18/40> 
>>esi; c1012748 <_end+c40bc8/104564e0> 
>>ebp; c0305380 <contig_page_data+0/440> 
>>esp; c138ffa4 <_end+fbe424/104564e0> 
 
Trace; c0136841 <refill_inactive_zone+141/1f0> 
Trace; c0136c94 <kswapd+134/190> 
Trace; c0105000 <_stext+0/0> 
Trace; c010744e <kernel_thread+2e/40> 
Trace; c0136b60 <kswapd+0/190> 
 
Code;  c013d269 <page_over_rsslimit+29/50> 
00000000 <_EIP>: 
Code;  c013d269 <page_over_rsslimit+29/50>   <===== 
   0:   8b 42 70                  mov    0x70(%edx),%eax   <===== 
Code;  c013d26c <page_over_rsslimit+2c/50> 
   3:   85 c0                     test   %eax,%eax 
Code;  c013d26e <page_over_rsslimit+2e/50> 
   5:   74 12                     je     19 <_EIP+0x19> 
Code;  c013d270 <page_over_rsslimit+30/50> 
   7:   39 42 5c                  cmp    %eax,0x5c(%edx) 
Code;  c013d273 <page_over_rsslimit+33/50> 
   a:   76 0d                     jbe    19 <_EIP+0x19> 
Code;  c013d275 <page_over_rsslimit+35/50> 
   c:   8b 09                     mov    (%ecx),%ecx 
Code;  c013d277 <page_over_rsslimit+37/50> 
   e:   85 c9                     test   %ecx,%ecx 
Code;  c013d279 <page_over_rsslimit+39/50> 
  10:   75 d5                     jne    ffffffe7 <_EIP+0xffffffe7> 
Code;  c013d27b <page_over_rsslimit+3b/50> 
  12:   b8 01 00 00 00            mov    $0x1,%eax 
 
 
Can anybody knows something about it 
 
Thanks in advance 
 
 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
