Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263085AbTCNOEa>; Fri, 14 Mar 2003 09:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTCNOEa>; Fri, 14 Mar 2003 09:04:30 -0500
Received: from vpn-global-dhcp1-11.ethz.ch ([129.132.208.11]:22912 "EHLO
	kibako.lan.kinali.ch") by vger.kernel.org with ESMTP
	id <S263085AbTCNOE1>; Fri, 14 Mar 2003 09:04:27 -0500
Date: Fri, 14 Mar 2003 15:14:17 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Strange oops
Message-ID: <20030314141417.GA4955@kibako>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Attila Kinali <kinali@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I know, the subject isnt apropriate at all, but i dont know how to
describe it better. I got this two oopses with 5 minutes time
differences while i was working on my laptop.

I was downloading something and upgrading my system (apt-get upgrade) ie
was doing a lot of network traffic and working on the harddisk.

I dont think that the problem comes from the ext2 or the paging system
directly but is somehow related to the airo (cisco wireles card) driver
i use. This is also the thing where the tainting comes from, i had to
use the drivers from cisco directly because those of 2.4.20 crashed my
system everytime i created some network traffic. Otherwise it's a plain
vanilla 2.4.20 kernel.

Also something special about my system is that i dont have swap
activated (gave me other problems with the vm), but the 256MB are enough
for most i do.

The system i work on is a Thinkpad A21m (PIII 700) with a 2.4.20 kernel
and a Debian Sarge installed. The kernel was compiled with gcc 2.95.4
(Linux version 2.4.20 (root@kibako) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Tue Mar 4 13:33:55 CET 2003)

The modules i had loaded were:
Module                  Size  Used by    Tainted: P  
ppp_deflate             2904   0  (autoclean)
zlib_inflate           18116   0  (autoclean) [ppp_deflate]
zlib_deflate           17368   0  (autoclean) [ppp_deflate]
bsd_comp                3928   0  (autoclean)
ppp_async               6400   1  (autoclean)
ppp_generic            16672   3  (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4336   0  (autoclean) [ppp_generic]
cs46xx                 54384   2  (autoclean)
ac97_codec              9928   0  (autoclean) [cs46xx]
airo_cs                 3332   0  (unused)
airo                  101964   1  [airo_cs]

I also dont think that the problem comes from the hardware, as i have
this laptop now for a little more than 2 years and everything else
(mostly gcc and perl/shell stuff) works fine.

Due to some reasons i dont seem to be able to reproduce it :(

I know this bugreport (if you can call it like this) is very vague, but
maybe it helps.

Please CC me as i'm not subscribed to the mailinglist.

Thanks a lot for your work.

			Attila Kinali

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops1.txt"

ksymoops 2.4.6 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address e3790044
c0131935
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0131935>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: e3790040   ebx: c007f738   ecx: 649c609c   edx: c007f6e0
esi: c007f6e0   edi: c007f6e0   ebp: c1001330   esp: c12f3f1c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c12f3000)
Stack: c007f6e0 c0133d52 c007f6e0 c1001330 000001d0 0000001b 00000200 c01322ec 
       c007f6e0 c1001330 c012a0c2 c1001330 000001d0 00000020 000001d0 00000020 
       00000006 00000006 c12f2000 00001aba 000001d0 c021b854 c012a320 00000006 
Call Trace:    [<c0133d52>] [<c01322ec>] [<c012a0c2>] [<c012a320>] [<c012a382>]
  [<c012a481>] [<c012a4e6>] [<c012a5fd>] [<c0105548>]
Code: 89 48 04 89 01 c7 42 58 00 00 00 00 c7 43 04 00 00 00 00 5b


>>EIP; c0131935 <__remove_inode_queue+15/2c>   <=====

>>ebp; c1001330 <_end+d6a658/10976388>
>>esp; c12f3f1c <_end+105d244/10976388>

Trace; c0133d52 <try_to_free_buffers+56/e4>
Trace; c01322ec <try_to_release_page+44/48>
Trace; c012a0c2 <shrink_cache+1ea/2fc>
Trace; c012a320 <shrink_caches+58/80>
Trace; c012a382 <try_to_free_pages_zone+3a/5c>
Trace; c012a481 <kswapd_balance_pgdat+41/8c>
Trace; c012a4e6 <kswapd_balance+1a/30>
Trace; c012a5fd <kswapd+99/bc>
Trace; c0105548 <kernel_thread+28/38>

Code;  c0131935 <__remove_inode_queue+15/2c>
00000000 <_EIP>:
Code;  c0131935 <__remove_inode_queue+15/2c>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c0131938 <__remove_inode_queue+18/2c>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c013193a <__remove_inode_queue+1a/2c>
   5:   c7 42 58 00 00 00 00      movl   $0x0,0x58(%edx)
Code;  c0131941 <__remove_inode_queue+21/2c>
   c:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c0131948 <__remove_inode_queue+28/2c>
  13:   5b                        pop    %ebx


1 warning issued.  Results may not be reliable.

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.txt"

ksymoops 2.4.6 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 6000a058
c0133c66
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0133c66>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: ffffffff   ebx: 6000a040   ecx: 000001d2   edx: 00000012
esi: 00000000   edi: c007f740   ebp: c10b5008   esp: c1763db8
ds: 0018   es: 0018   ss: 0018
Process troff (pid: 839, stackpage=c1763000)
Stack: c10b5008 c007f740 c007f740 c0133dba c007f740 c10b5008 000001d2 00000004 
       000001e2 c01322ec c007f740 c10b5008 c012a0c2 c10b5008 000001d2 00000020 
       000001d2 00000020 00000006 00000006 c1762000 00001a76 000001d2 c021b854 
Call Trace:    [<c0133dba>] [<c01322ec>] [<c012a0c2>] [<c012a320>] [<c012a382>]
  [<c012ad48>] [<c012afd2>] [<c012acf6>] [<c0121fd0>] [<c01220a3>] [<c012223e>]
  [<c0111d34>] [<c0111bd4>] [<c0124bf3>] [<c0123498>] [<c012256b>] [<c0106cb8>]
Code: f6 43 18 06 74 7c b8 07 00 00 00 0f ab 43 18 19 c0 85 c0 74 


>>EIP; c0133c66 <sync_page_buffers+e/a4>   <=====

>>ebp; c10b5008 <_end+e1e330/10976388>
>>esp; c1763db8 <_end+14cd0e0/10976388>

Trace; c0133dba <try_to_free_buffers+be/e4>
Trace; c01322ec <try_to_release_page+44/48>
Trace; c012a0c2 <shrink_cache+1ea/2fc>
Trace; c012a320 <shrink_caches+58/80>
Trace; c012a382 <try_to_free_pages_zone+3a/5c>
Trace; c012ad48 <balance_classzone+50/1c8>
Trace; c012afd2 <__alloc_pages+112/160>
Trace; c012acf6 <_alloc_pages+16/18>
Trace; c0121fd0 <do_anonymous_page+34/d4>
Trace; c01220a3 <do_no_page+33/17c>
Trace; c012223e <handle_mm_fault+52/b0>
Trace; c0111d34 <do_page_fault+160/480>
Trace; c0111bd4 <do_page_fault+0/480>
Trace; c0124bf3 <do_generic_file_read+3f7/404>
Trace; c0123498 <do_brk+11c/200>
Trace; c012256b <sys_brk+bb/e4>
Trace; c0106cb8 <error_code+34/3c>

Code;  c0133c66 <sync_page_buffers+e/a4>
00000000 <_EIP>:
Code;  c0133c66 <sync_page_buffers+e/a4>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0133c6a <sync_page_buffers+12/a4>
   4:   74 7c                     je     82 <_EIP+0x82> c0133ce8 <sync_page_buffers+90/a4>
Code;  c0133c6c <sync_page_buffers+14/a4>
   6:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c0133c71 <sync_page_buffers+19/a4>
   b:   0f ab 43 18               bts    %eax,0x18(%ebx)
Code;  c0133c75 <sync_page_buffers+1d/a4>
   f:   19 c0                     sbb    %eax,%eax
Code;  c0133c77 <sync_page_buffers+1f/a4>
  11:   85 c0                     test   %eax,%eax
Code;  c0133c79 <sync_page_buffers+21/a4>
  13:   74 00                     je     15 <_EIP+0x15> c0133c7b <sync_page_buffers+23/a4>


1 warning issued.  Results may not be reliable.

--W/nzBZO5zC0uMSeA--
