Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHQRre>; Sat, 17 Aug 2002 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSHQRre>; Sat, 17 Aug 2002 13:47:34 -0400
Received: from [216.167.37.170] ([216.167.37.170]:16394 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S318040AbSHQRra>;
	Sat, 17 Aug 2002 13:47:30 -0400
From: lists@corewars.org
Date: Sat, 17 Aug 2002 19:51:30 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 Oops' and crashes
Message-ID: <20020817195130.A10368@corewars.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I'm facing regular kernel crashes with 2.4.19 (stable) on my COMPAQ Armada 
M700 Laptop: PIII@750MHz/256Mb SDRAM/10GB IDE HDD with ext2. 

After running it for a while (upto 2 hours) make, top and some other
programs start segfaulting the moment I execute them, while some (ls, 
ping) still work. I've noticed a continuous increase in memory and
swap utilization (upto the point all 256M is nearly utilized), 
even if I'm not running anything memory-intensive.
When I try to restart, I get an oops on the console. This machine's been
running 2.2.16 for the past 6 months without any problems.

ksymoops 2.4.5 on i686 2.4.19-rc5.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-rc5 (specified)
     -m /boot/System.map-2.4.19-rc5 (specified)

Aug 17 14:06:58 solo kernel: Unable to handle kernel paging request at virtual address 00008600
Aug 17 14:06:58 solo kernel: Unable to handle kernel paging request at virtual address 00008600
Aug 17 14:06:58 solo kernel: 00008600
Aug 17 14:06:58 solo kernel: 00008600
Aug 17 14:06:58 solo kernel: *pde = 00000000
Aug 17 14:06:58 solo kernel: *pde = 00000000
Aug 17 14:06:58 solo kernel: Oops: 0000
Aug 17 14:06:58 solo kernel: Oops: 0000
Aug 17 14:06:58 solo kernel: CPU:    0
Aug 17 14:06:58 solo kernel: CPU:    0
Aug 17 14:06:58 solo kernel: EIP:    0010:[agp_frontend_cleanup+34304/-1072693248]    Not tainted
Aug 17 14:06:58 solo kernel: EIP:    0010:[agp_frontend_cleanup+34304/-1072693248]    Not tainted
Aug 17 14:06:58 solo kernel: EFLAGS: 00010202
Aug 17 14:06:58 solo kernel: EFLAGS: 00010202
Aug 17 14:06:58 solo kernel: eax: 00000001   ebx: c02e5220   ecx: 00000086   edx: d081c000
Aug 17 14:06:58 solo kernel: eax: 00000001   ebx: c02e5220   ecx: 00000086   edx: d081c000
Aug 17 14:06:58 solo kernel: esi: 00000086   edi: cdbe2404   ebp: cfe91e40   esp: cd7ade98
Aug 17 14:06:58 solo kernel: esi: 00000086   edi: cdbe2404   ebp: cfe91e40   esp: cd7ade98
Aug 17 14:06:58 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:58 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:58 solo kernel: Process xbanner (pid: 721, stackpage=cd7ad000)
Aug 17 14:06:58 solo kernel: Process xbanner (pid: 721, stackpage=cd7ad000)
Aug 17 14:06:58 solo kernel: Stack: c1252b74 c0121646 c02e5220 00000001 4010106c 00000000 cfe91e40 cd8b1c20 
Aug 17 14:06:58 solo kernel: Stack: c1252b74 c0121646 c02e5220 00000001 4010106c 00000000 cfe91e40 cd8b1c20 
Aug 17 14:06:58 solo kernel:        c012198b cfe91e40 cd8b1c20 4010106c cdbe2404 00008600 00000000 cd8408e0 
Aug 17 14:06:58 solo kernel:        c012198b cfe91e40 cd8b1c20 4010106c cdbe2404 00008600 00000000 cd8408e0 
Aug 17 14:06:58 solo kernel:        cd7adf54 00000020 00000040 cd7adf08 00000019 00000000 ce970000 cd7ac000 
Aug 17 14:06:58 solo kernel:        cd7adf54 00000020 00000040 cd7adf08 00000019 00000000 ce970000 cd7ac000 
Aug 17 14:06:58 solo kernel: Call Trace:    [do_swap_page+134/240] [handle_mm_fault+107/192] [do_page_fault+394/1227] [sock_read+134/144] [sys_read+227/240]
Aug 17 14:06:58 solo kernel: Call Trace:    [do_swap_page+134/240] [handle_mm_fault+107/192] [do_page_fault+394/1227] [sock_read+134/144] [sys_read+227/240]
Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>edi; cdbe2404 <_end+d8dc060/1055dc5c>
>>ebp; cfe91e40 <_end+fb8ba9c/1055dc5c>
>>esp; cd7ade98 <_end+d4a7af4/1055dc5c>
>>edi; cdbe2404 <_end+d8dc060/1055dc5c>
>>ebp; cfe91e40 <_end+fb8ba9c/1055dc5c>
>>esp; cd7ade98 <_end+d4a7af4/1055dc5c>

Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.

Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel paging request at virtual address 00006900
Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel paging request at virtual address 00006900
Aug 17 14:06:59 solo kernel: 00006900
Aug 17 14:06:59 solo kernel: 00006900
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+26880/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+26880/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EFLAGS: 00010207
Aug 17 14:06:59 solo kernel: EFLAGS: 00010207
Aug 17 14:06:59 solo kernel: eax: 00000000   ebx: c02e5220   ecx: 00000069   edx: d081c000
Aug 17 14:06:59 solo kernel: eax: 00000000   ebx: c02e5220   ecx: 00000069   edx: d081c000
Aug 17 14:06:59 solo kernel: esi: 00000069   edi: c12527d8   ebp: cdbdc168   esp: cd7adca0
Aug 17 14:06:59 solo kernel: esi: 00000069   edi: c12527d8   ebp: cdbdc168   esp: cd7adca0
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: Process xbanner (pid: 721, stackpage=cd7ad000)
Aug 17 14:06:59 solo kernel: Process xbanner (pid: 721, stackpage=cd7ad000)
Aug 17 14:06:59 solo kernel: Stack: c12527d8 c012b252 c02e5220 c02e5220 c02e5220 c012b8ef c12527d8 00006900 
Aug 17 14:06:59 solo kernel: Stack: c12527d8 c012b252 c02e5220 c02e5220 c02e5220 c012b8ef c12527d8 00006900 
Aug 17 14:06:59 solo kernel:        00003000 00001000 c0120846 00006900 00000001 00000000 0805c000 cd78b080 
Aug 17 14:06:59 solo kernel:        00003000 00001000 c0120846 00006900 00000001 00000000 0805c000 cd78b080 
Aug 17 14:06:59 solo kernel:        08059000 00000000 0805c000 cd78b080 c0185b18 00000006 c0185b18 00000006 
Aug 17 14:06:59 solo kernel:        08059000 00000000 0805c000 cd78b080 c0185b18 00000006 c0185b18 00000006 
Aug 17 14:06:59 solo kernel: Call Trace:    [delete_from_swap_cache+50/64] [free_swap_and_cache+111/160] [zap_page_range+406/592] [vt_console_print+104/704] [vt_console_print+104/704]
Aug 17 14:06:59 solo kernel: Call Trace:    [delete_from_swap_cache+50/64] [free_swap_and_cache+111/160] [zap_page_range+406/592] [vt_console_print+104/704] [vt_console_print+104/704]
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>edi; c12527d8 <_end+f4c434/1055dc5c>
>>ebp; cdbdc168 <_end+d8d5dc4/1055dc5c>
>>esp; cd7adca0 <_end+d4a78fc/1055dc5c>
>>edi; c12527d8 <_end+f4c434/1055dc5c>
>>ebp; cdbdc168 <_end+d8d5dc4/1055dc5c>
>>esp; cd7adca0 <_end+d4a78fc/1055dc5c>

Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000100
Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000100
Aug 17 14:06:59 solo kernel: 00000100
Aug 17 14:06:59 solo kernel: 00000100
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+256/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+256/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EFLAGS: 00010202
Aug 17 14:06:59 solo kernel: EFLAGS: 00010202
Aug 17 14:06:59 solo kernel: eax: 00000001   ebx: c02e5220   ecx: 00000001   edx: d081c000
Aug 17 14:06:59 solo kernel: eax: 00000001   ebx: c02e5220   ecx: 00000001   edx: d081c000
Aug 17 14:06:59 solo kernel: esi: 00000001   edi: ce8801f8   ebp: cfe91c60   esp: ce883e98
Aug 17 14:06:59 solo kernel: esi: 00000001   edi: ce8801f8   ebp: cfe91c60   esp: ce883e98
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: Process kdm (pid: 711, stackpage=ce883000)
Aug 17 14:06:59 solo kernel: Process kdm (pid: 711, stackpage=ce883000)
Aug 17 14:06:59 solo kernel: Stack: c1284d14 c0121646 c02e5220 00000001 4007e308 00000000 cfe91c60 ce98c4e0 
Aug 17 14:06:59 solo kernel: Stack: c1284d14 c0121646 c02e5220 00000001 4007e308 00000000 cfe91c60 ce98c4e0 
Aug 17 14:06:59 solo kernel:        c012198b cfe91c60 ce98c4e0 4007e308 ce8801f8 00000100 00000000 ce993b80 
Aug 17 14:06:59 solo kernel:        c012198b cfe91c60 ce98c4e0 4007e308 ce8801f8 00000100 00000000 ce993b80 
Aug 17 14:06:59 solo kernel:        cff1de00 c014275e 000005e6 cff1de00 0005c5e7 00000017 c0151ccc ce882000 
Aug 17 14:06:59 solo kernel:        cff1de00 c014275e 000005e6 cff1de00 0005c5e7 00000017 c0151ccc ce882000 
Aug 17 14:06:59 solo kernel: Call Trace:    [do_swap_page+134/240] [handle_mm_fault+107/192] [clear_inode+14/176] [ext2_free_inode+220/368] [do_page_fault+394/1227]
Aug 17 14:06:59 solo kernel: Call Trace:    [do_swap_page+134/240] [handle_mm_fault+107/192] [clear_inode+14/176] [ext2_free_inode+220/368] [do_page_fault+394/1227]
Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>edi; ce8801f8 <_end+e579e54/1055dc5c>
>>ebp; cfe91c60 <_end+fb8b8bc/1055dc5c>
>>esp; ce883e98 <_end+e57daf4/1055dc5c>
>>edi; ce8801f8 <_end+e579e54/1055dc5c>
>>ebp; cfe91c60 <_end+fb8b8bc/1055dc5c>
>>esp; ce883e98 <_end+e57daf4/1055dc5c>

Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000b00
Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000b00
Aug 17 14:06:59 solo kernel: 00000b00
Aug 17 14:06:59 solo kernel: 00000b00
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+2816/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EIP:    0010:[agp_frontend_cleanup+2816/-1072693248]    Not tainted
Aug 17 14:06:59 solo kernel: EFLAGS: 00010203
Aug 17 14:06:59 solo kernel: EFLAGS: 00010203
Aug 17 14:06:59 solo kernel: eax: 00000000   ebx: c02e5220   ecx: 0000000b   edx: d081c000
Aug 17 14:06:59 solo kernel: eax: 00000000   ebx: c02e5220   ecx: 0000000b   edx: d081c000
Aug 17 14:06:59 solo kernel: esi: 0000000b   edi: c1284d40   ebp: ce880234   esp: ce883ca0
Aug 17 14:06:59 solo kernel: esi: 0000000b   edi: c1284d40   ebp: ce880234   esp: ce883ca0
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: Process kdm (pid: 711, stackpage=ce883000)
Aug 17 14:06:59 solo kernel: Process kdm (pid: 711, stackpage=ce883000)
Aug 17 14:06:59 solo kernel: Stack: c1284d40 c012b252 c02e5220 c02e5220 c02e5220 c012b8ef c1284d40 00000b00 
Aug 17 14:06:59 solo kernel: Stack: c1284d40 c012b252 c02e5220 c02e5220 c02e5220 c012b8ef c1284d40 00000b00 
Aug 17 14:06:59 solo kernel:        00002000 00000000 c0120846 00000b00 00000000 00000000 4008f000 cdabd400 
Aug 17 14:06:59 solo kernel:        00002000 00000000 c0120846 00000b00 00000000 00000000 4008f000 cdabd400 
Aug 17 14:06:59 solo kernel:        4008d000 00000000 4008f000 cdabd400 c0186854 c02f0ed4 000496c0 c0185d58 
Aug 17 14:06:59 solo kernel:        4008d000 00000000 4008f000 cdabd400 c0186854 c02f0ed4 000496c0 c0185d58 
Aug 17 14:06:59 solo kernel: Call Trace:    [delete_from_swap_cache+50/64] [free_swap_and_cache+111/160] [zap_page_range+406/592] [poke_blanked_console+100/112] [vt_console_print+680/704]
Aug 17 14:06:59 solo kernel: Call Trace:    [delete_from_swap_cache+50/64] [free_swap_and_cache+111/160] [zap_page_range+406/592] [poke_blanked_console+100/112] [vt_console_print+680/704]
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>edi; c1284d40 <_end+f7e99c/1055dc5c>
>>ebp; ce880234 <_end+e579e90/1055dc5c>
>>esp; ce883ca0 <_end+e57d8fc/1055dc5c>
>>edi; c1284d40 <_end+f7e99c/1055dc5c>
>>ebp; ce880234 <_end+e579e90/1055dc5c>
>>esp; ce883ca0 <_end+e57d8fc/1055dc5c>

Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


Aug 17 14:06:59 solo kernel: Code:  Bad EIP value.


Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel paging request at virtual address 00c1284e
Aug 17 14:06:59 solo kernel:  <1>Unable to handle kernel paging request at virtual address 00c1284e
Aug 17 14:06:59 solo kernel: c1284ed0
Aug 17 14:06:59 solo kernel: c1284ed0
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: *pde = 00000000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: Oops: 0000
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: CPU:    0
Aug 17 14:06:59 solo kernel: EIP:    0010:[<c1284ed0>]    Not tainted
Aug 17 14:06:59 solo kernel: EIP:    0010:[<c1284ed0>]    Not tainted
Aug 17 14:06:59 solo kernel: EFLAGS: 00010297
Aug 17 14:06:59 solo kernel: EFLAGS: 00010297
Aug 17 14:06:59 solo kernel: eax: 0000004e   ebx: c02e5220   ecx: 000000b4   edx: d081c000
Aug 17 14:06:59 solo kernel: eax: 0000004e   ebx: c02e5220   ecx: 000000b4   edx: d081c000
Aug 17 14:06:59 solo kernel: esi: 00000002   edi: 00000200   ebp: 00000001   esp: cee41eac
Aug 17 14:06:59 solo kernel: esi: 00000002   edi: 00000200   ebp: 00000001   esp: cee41eac
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:06:59 solo kernel: Process kdm (pid: 701, stackpage=cee41000)
Aug 17 14:06:59 solo kernel: Process kdm (pid: 701, stackpage=cee41000)
Aug 17 14:06:59 solo kernel: Stack: c02e5220 c012b86a c02e5220 c1284ecc 00000000 00000001 c1284ecc 0000c000 
Aug 17 14:06:59 solo kernel: Stack: c02e5220 c012b86a c02e5220 c1284ecc 00000000 00000001 c1284ecc 0000c000 
Aug 17 14:06:59 solo kernel:        00002000 cf87220c c012b280 c1284ecc 0ea84045 c0120838 c1284ecc 00000003 
Aug 17 14:06:59 solo kernel:        00002000 cf87220c c012b280 c1284ecc 0ea84045 c0120838 c1284ecc 00000003 
Aug 17 14:06:59 solo kernel:        00000000 4008d000 cf94a400 40081000 00000000 4008d000 cf94a400 cfe91bc0 
Aug 17 14:06:59 solo kernel:        00000000 4008d000 cf94a400 40081000 00000000 4008d000 cf94a400 cfe91bc0 
Aug 17 14:06:59 solo kernel: Call Trace:    [remove_exclusive_swap_page+170/192] [free_page_and_swap_cache+32/64] [zap_page_range+392/592] [fput+175/208] [exit_mmap+184/288]
Aug 17 14:06:59 solo kernel: Call Trace:    [remove_exclusive_swap_page+170/192] [free_page_and_swap_cache+32/64] [zap_page_range+392/592] [fput+175/208] [exit_mmap+184/288]
Aug 17 14:06:59 solo kernel: Code: a0 4e 28 c1 00 00 00 00 00 02 00 00 f4 92 29 c1 02 00 00 00 


>>EIP; c1284ed0 <_end+f7eb2c/1055dc5c>   <=====
>>EIP; c1284ed0 <_end+f7eb2c/1055dc5c>   <=====

>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>ebx; c02e5220 <swap_info+0/700>
>>edx; d081c000 <_end+10515c5c/1055dc5c>
>>esp; cee41eac <_end+eb3bb08/1055dc5c>
>>esp; cee41eac <_end+eb3bb08/1055dc5c>

Code;  c1284ed0 <_end+f7eb2c/1055dc5c>
00000000 <_EIP>:
Code;  c1284ed0 <_end+f7eb2c/1055dc5c>   <=====
   0:   a0 4e 28 c1 00            mov    0xc1284e,%al   <=====
Code;  c1284ed5 <_end+f7eb31/1055dc5c>
   5:   00 00                     add    %al,(%eax)
Code;  c1284ed7 <_end+f7eb33/1055dc5c>
   7:   00 00                     add    %al,(%eax)
Code;  c1284ed9 <_end+f7eb35/1055dc5c>
   9:   02 00                     add    (%eax),%al
Code;  c1284edb <_end+f7eb37/1055dc5c>
   b:   00 f4                     add    %dh,%ah
Code;  c1284edd <_end+f7eb39/1055dc5c>
   d:   92                        xchg   %eax,%edx
Code;  c1284ede <_end+f7eb3a/1055dc5c>
   e:   29 c1                     sub    %eax,%ecx
Code;  c1284ee0 <_end+f7eb3c/1055dc5c>
  10:   02 00                     add    (%eax),%al

Aug 17 14:06:59 solo kernel: Code: a0 4e 28 c1 00 00 00 00 00 02 00 00 f4 92 29 c1 02 00 00 00 


Code;  c1284ed0 <_end+f7eb2c/1055dc5c>
00000000 <_EIP>:
Code;  c1284ed0 <_end+f7eb2c/1055dc5c>
   0:   a0 4e 28 c1 00            mov    0xc1284e,%al
Code;  c1284ed5 <_end+f7eb31/1055dc5c>
   5:   00 00                     add    %al,(%eax)
Code;  c1284ed7 <_end+f7eb33/1055dc5c>
   7:   00 00                     add    %al,(%eax)
Code;  c1284ed9 <_end+f7eb35/1055dc5c>
   9:   02 00                     add    (%eax),%al
Code;  c1284edb <_end+f7eb37/1055dc5c>
   b:   00 f4                     add    %dh,%ah
Code;  c1284edd <_end+f7eb39/1055dc5c>
   d:   92                        xchg   %eax,%edx
Code;  c1284ede <_end+f7eb3a/1055dc5c>
   e:   29 c1                     sub    %eax,%ecx
Code;  c1284ee0 <_end+f7eb3c/1055dc5c>
  10:   02 00                     add    (%eax),%al

