Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTJ0P7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTJ0P7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:59:44 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:61387 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S263258AbTJ0P46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:56:58 -0500
Subject: 2.4.23-preX oops and strange swappiness (nforce2 mobo)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-rRx4nUUz/2Ytvr6/t+Ai"
Message-Id: <1067270203.4503.9.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 27 Oct 2003 10:56:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rRx4nUUz/2Ytvr6/t+Ai
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Unfortunately, I really shouldn't run without nvnet so if thats a known
issue then its not in google ;)  (If its highly likely to be related I
can try it this week; it means I end up downing my wlan..)

It doesn't take long - couple of days at most - before there are a
couple of oopses in the logs (decodes below) and swap usage begins
climbing without ever being reclaimed.  (Similar problems occurred in
2.4.23-pre5, with the added bonus of processes cratering out in D state
and never going away.)

These are from an unpatched 2.4.23-pre8:
[10:49:24] [dis@floyd] $ uptime
 10:49:26 up 2 days, 30 min,  2 users,  load average: 1.56, 1.57, 1.49
[10:49:26] [dis@floyd] $ free
             total       used       free     shared    buffers     cached
Mem:        256932     254736       2196          0      13804      64932
-/+ buffers/cache:     176000      80932
Swap:      2000084     443248    1556836
[10:49:27] [dis@floyd] $ cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            62     72    108    2    2    1
ip_conntrack         255    804    320   67   67    1
fib6_nodes            12    112     32    1    1    1
ip6_dst_cache         13     20    192    1    1    1
ndisc_cache            3     30    128    1    1    1
tcp_tw_bucket          6     30    128    1    1    1
tcp_bind_bucket       72    448     32    4    4    1
tcp_open_request       0     30    128    0    1    1
inet_peer_cache        3     59     64    1    1    1
ip_fib_hash           13    112     32    1    1    1
ip_dst_cache        1850   1920    192   96   96    1
arp_cache             22     30    128    1    1    1
blkdev_requests     3072   3090    128  103  103    1
journal_head        1468   5236     48   55   68    1
revoke_table           3    250     12    1    1    1
revoke_record          0    112     32    0    1    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache       20     42     92    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache             12    112     32    1    1    1
skbuff_head_cache    225    780    192   39   39    1
sock                 240    336    896   83   84    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            16    118     64    2    2    1
bdev_cache             5     59     64    1    1    1
mnt_cache             13     59     64    1    1    1
inode_cache         6821   6825    512  975  975    1
dentry_cache        5297   5310    128  177  177    1
filp                2374   2400    128   80   80    1
names_cache            0      2   4096    0    2    1
buffer_head        17182  17790    128  592  593    1
mm_struct             76     90    128    3    3    1
vm_area_struct      3811   3930    128  131  131    1
fs_cache              73    118     64    2    2    1
files_cache           74     81    448    9    9    1
signal_act            89     90   1344   30   30    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             4      4  32768    4    4    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             8      8  16384    8    8    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              2      2   8192    2    2    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096            150    201   4096  150  201    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             63     78   2048   35   39    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             85     88   1024   22   22    1
size-512(DMA)          0      0    512    0    0    1
size-512             146    152    512   19   19    1
size-256(DMA)          0      0    256    0    0    1
size-256             517    525    256   35   35    1
size-128(DMA)          0      0    128    0    0    1
size-128            1810   1830    128   61   61    1
size-64(DMA)           0      0     64    0    0    1
size-64             3467   3481     64   59   59    1
size-32(DMA)           0      0     64    0    0    1
size-32             1612   2301     64   39   39    1
[10:51:34] [dis@floyd] $ lsmod
Module                  Size  Used by    Tainted: P
ipt_mark                 472  46
ipt_state                568   0 (unused)
ipt_mac                  696   2
ip_nat_irc              2192   0 (unused)
ip_conntrack_irc        3056   1
ip_conntrack_ftp        4016   1 (autoclean)
ip_nat_ftp              2864   0 (unused)
iptable_filter          1772   1
iptable_mangle          2168   1
ipt_LOG                 3416   0 (unused)
ipt_TOS                 1048   0 (unused)
ipt_REJECT              3544   0 (unused)
ipt_MARK                 792   3
ipt_MASQUERADE          1464   8
ipt_REDIRECT             824   4
iptable_nat            16014   3 [ip_nat_irc ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT]
ip_conntrack           19908   4 [ipt_state ip_nat_irc ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT iptable_nat]
ip_tables              12288  14 [ipt_mark ipt_state ipt_mac iptable_filter iptable_mangle ipt_LOG ipt_TOS ipt_REJECT ipt_MARK ipt_MASQUERADE ipt_REDIRECT iptable_nat]
nfsd                   72880   8 (autoclean)
lockd                  50928   1 (autoclean) [nfsd]
sunrpc                 68736   1 (autoclean) [nfsd lockd]
sd_mod                 11084   0 (autoclean) (unused)
sg                     27516   0 (autoclean) (unused)
sr_mod                 15576   0 (autoclean) (unused)
scsi_mod               85760   3 (autoclean) [sd_mod sg sr_mod]
ide-cd                 32032   0 (autoclean)
cdrom                  28320   0 (autoclean) [sr_mod ide-cd]
hid                    21572   0 (unused)
usbmouse                2264   0 (unused)
ehci-hcd               17260   0 (unused)
nvnet                  26272   1
ipv6                  167124  -1
tulip                  40608   1
crc32                   2880   0 [tulip]
usbkbd                  3640   0 (unused)
usb-ohci               18888   0 (unused)
usbcore                62892   1 [hid usbmouse ehci-hcd usbkbd usb-ohci]

Crash dump and config attached - if you need anything else let me know.

(I'm on the list, no need to CC)

Thanks!
-- 
Disconnect <lkml@sigkill.net>

--=-rRx4nUUz/2Ytvr6/t+Ai
Content-Disposition: inline; filename=Crash
Content-Type: text/plain; name=Crash; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.9 on i686 2.4.23-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre8/ (default)
     -m /boot/System.map-2.4.23-pre8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 000006e2
c012c185
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012c185>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000006da   ebx: cff64b58   ecx: 00000010   edx: 000092d6
esi: 00001000   edi: ce97f134   ebp: 000006da   esp: c5cf3f0c
ds: 0018   es: 0018   ss: 0018
Process imap (pid: 9735, stackpage=c5cf3000)
Stack: c5cf3f74 c11ad2dc 00000000 00001000 00000d65 00000001 00000000 0000029b 
       ce97f080 c012c7b0 c5cf3f74 c99d18e0 c99d18c0 00001000 00001000 ffffffea 
       00000000 c012c904 c99d18c0 c99d18e0 c5cf3f74 c012c7b0 00edae84 00000046 
Call Trace:    [<c012c7b0>] [<c012c904>] [<c012c7b0>] [<c01e530a>] [<c0139f53>]
  [<c0108e0f>]
Code: 39 78 08 74 05 8b 40 10 eb f2 39 68 0c 75 f6 85 c0 89 c6 0f 


>>EIP; c012c185 <do_generic_file_read+145/450>   <=====

>>ebx; cff64b58 <_end+fc72ad8/10651000>
>>edi; ce97f134 <_end+e68d0b4/10651000>
>>esp; c5cf3f0c <_end+5a01e8c/10651000>

Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c012c904 <generic_file_read+b4/1a0>
Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c01e530a <net_rx_action+6a/100>
Trace; c0139f53 <sys_read+a3/130>
Trace; c0108e0f <system_call+33/38>

Code;  c012c185 <do_generic_file_read+145/450>
00000000 <_EIP>:
Code;  c012c185 <do_generic_file_read+145/450>   <=====
   0:   39 78 08                  cmp    %edi,0x8(%eax)   <=====
Code;  c012c188 <do_generic_file_read+148/450>
   3:   74 05                     je     a <_EIP+0xa>
Code;  c012c18a <do_generic_file_read+14a/450>
   5:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c012c18d <do_generic_file_read+14d/450>
   8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
Code;  c012c18f <do_generic_file_read+14f/450>
   a:   39 68 0c                  cmp    %ebp,0xc(%eax)
Code;  c012c192 <do_generic_file_read+152/450>
   d:   75 f6                     jne    5 <_EIP+0x5>
Code;  c012c194 <do_generic_file_read+154/450>
   f:   85 c0                     test   %eax,%eax
Code;  c012c196 <do_generic_file_read+156/450>
  11:   89 c6                     mov    %eax,%esi
Code;  c012c198 <do_generic_file_read+158/450>
  13:   0f 00 00                  sldtl  (%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000006e2
c012c185
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012c185>]    Tainted: P 
EFLAGS: 00010202
eax: 000006da   ebx: cff64b58   ecx: 00000010   edx: 000092d6
esi: 00001000   edi: ce97f134   ebp: 000006da   esp: c3c51f0c
ds: 0018   es: 0018   ss: 0018
Process imap (pid: 12057, stackpage=c3c51000)
Stack: c3c51f74 c128ac20 00000000 00001000 00000d65 00000001 00000000 0000029b 
       ce97f080 c012c7b0 c3c51f74 c9ec5a60 c9ec5a40 00001000 00001000 ffffffea 
       00000000 c012c904 c9ec5a40 c9ec5a60 c3c51f74 c012c7b0 cf31e2e4 00000000 
Call Trace:    [<c012c7b0>] [<c012c904>] [<c012c7b0>] [<c0139f53>] [<c0108e0f>]
Code: 39 78 08 74 05 8b 40 10 eb f2 39 68 0c 75 f6 85 c0 89 c6 0f 


>>EIP; c012c185 <do_generic_file_read+145/450>   <=====

>>ebx; cff64b58 <_end+fc72ad8/10651000>
>>edi; ce97f134 <_end+e68d0b4/10651000>
>>esp; c3c51f0c <_end+395fe8c/10651000>

Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c012c904 <generic_file_read+b4/1a0>
Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c0139f53 <sys_read+a3/130>
Trace; c0108e0f <system_call+33/38>

Code;  c012c185 <do_generic_file_read+145/450>
00000000 <_EIP>:
Code;  c012c185 <do_generic_file_read+145/450>   <=====
   0:   39 78 08                  cmp    %edi,0x8(%eax)   <=====
Code;  c012c188 <do_generic_file_read+148/450>
   3:   74 05                     je     a <_EIP+0xa>
Code;  c012c18a <do_generic_file_read+14a/450>
   5:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c012c18d <do_generic_file_read+14d/450>
   8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
Code;  c012c18f <do_generic_file_read+14f/450>
   a:   39 68 0c                  cmp    %ebp,0xc(%eax)
Code;  c012c192 <do_generic_file_read+152/450>
   d:   75 f6                     jne    5 <_EIP+0x5>
Code;  c012c194 <do_generic_file_read+154/450>
   f:   85 c0                     test   %eax,%eax
Code;  c012c196 <do_generic_file_read+156/450>
  11:   89 c6                     mov    %eax,%esi
Code;  c012c198 <do_generic_file_read+158/450>
  13:   0f 00 00                  sldtl  (%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000006e2
c012b819
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b819>]    Tainted: P 
EFLAGS: 00010202
eax: 000006da   ebx: c12440d8   ecx: c026c320   edx: 02a21800
esi: 02a21800   edi: cff64b58   ebp: cff21e8c   esp: cff21e50
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=cff21000)
Stack: c12440d8 02a21800 c1adf384 c01342fc c12440d8 c026c320 02a21800 cff64b58 
       c12440d8 02a21800 c01331af c12440d8 02a21800 0d2ed045 00000000 02a21800 
       1a0e1000 c1adf384 1a400000 00000020 c0133080 cea11cc0 cd6edac0 1a0e1000 
Call Trace:    [<c01342fc>] [<c01331af>] [<c0133080>] [<c0132f3c>] [<c013251d>]
  [<c013272f>] [<c0132a8d>] [<c0132b03>] [<c0132cae>] [<c0132d09>] [<c0132e2d>]
  [<c0132da0>] [<c0105000>] [<c01072ab>] [<c0132da0>]
Code: 39 48 08 74 05 8b 40 10 eb f2 39 50 0c 75 f6 85 c0 be 01 00 


>>EIP; c012b819 <add_to_page_cache_unique+19/90>   <=====

>>ebx; c12440d8 <_end+f52058/10651000>
>>ecx; c026c320 <swapper_space+0/30>
>>edi; cff64b58 <_end+fc72ad8/10651000>
>>ebp; cff21e8c <_end+fc2fe0c/10651000>
>>esp; cff21e50 <_end+fc2fdd0/10651000>

Trace; c01342fc <add_to_swap_cache+6c/c0>
Trace; c01331af <try_to_swap_out+11f/1b0>
Trace; c0133080 <swap_out_pmd+f0/100>
Trace; c0132f3c <swap_out_mm+ec/140>
Trace; c013251d <swap_out+5d/d0>
Trace; c013272f <shrink_cache+19f/370>
Trace; c0132a8d <shrink_caches+3d/60>
Trace; c0132b03 <try_to_free_pages_zone+53/e0>
Trace; c0132cae <kswapd_balance_pgdat+5e/a0>
Trace; c0132d09 <kswapd_balance+19/30>
Trace; c0132e2d <kswapd+8d/b0>
Trace; c0132da0 <kswapd+0/b0>
Trace; c0105000 <_stext+0/0>
Trace; c01072ab <arch_kernel_thread+2b/40>
Trace; c0132da0 <kswapd+0/b0>

Code;  c012b819 <add_to_page_cache_unique+19/90>
00000000 <_EIP>:
Code;  c012b819 <add_to_page_cache_unique+19/90>   <=====
   0:   39 48 08                  cmp    %ecx,0x8(%eax)   <=====
Code;  c012b81c <add_to_page_cache_unique+1c/90>
   3:   74 05                     je     a <_EIP+0xa>
Code;  c012b81e <add_to_page_cache_unique+1e/90>
   5:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c012b821 <add_to_page_cache_unique+21/90>
   8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
Code;  c012b823 <add_to_page_cache_unique+23/90>
   a:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  c012b826 <add_to_page_cache_unique+26/90>
   d:   75 f6                     jne    5 <_EIP+0x5>
Code;  c012b828 <add_to_page_cache_unique+28/90>
   f:   85 c0                     test   %eax,%eax
Code;  c012b82a <add_to_page_cache_unique+2a/90>
  11:   be 01 00 00 00            mov    $0x1,%esi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000006e2
c012bc54
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012bc54>]    Tainted: P 
EFLAGS: 00010202
eax: 000006da   ebx: c026c320   ecx: 00000010   edx: 000092d6
esi: 01a21900   edi: 00000000   ebp: 00000000   esp: c68afef0
ds: 0018   es: 0018   ss: 0018
Process giftd (pid: 13178, stackpage=c68af000)
Stack: c02cad40 01a21900 c0134a37 c026c320 01a21900 0025d000 cacb9974 00400000 
       c012984a 01a21900 c3f8eb60 c4a7a7c8 c4a7a780 42000000 c36e7420 42000000 
       00000000 c012838b cfe09940 c36e741c 41c00000 00400000 42000000 00000000 
Call Trace:    [<c0134a37>] [<c012984a>] [<c012838b>] [<c012aca5>] [<c0118c97>]
  [<c011d7a7>] [<c011d9c3>] [<c0108e0f>]
Code: 39 58 08 74 05 8b 40 10 eb f2 39 70 0c 75 f6 85 c0 89 c2 74 


>>EIP; c012bc54 <find_trylock_page+34/60>   <=====

>>ebx; c026c320 <swapper_space+0/30>
>>esp; c68afef0 <_end+65bde70/10651000>

Trace; c0134a37 <free_swap_and_cache+b7/c0>
Trace; c012984a <zap_pte_range+fa/102>
Trace; c012838b <zap_page_range+8b/f0>
Trace; c012aca5 <exit_mmap+b5/130>
Trace; c0118c97 <mmput+47/b0>
Trace; c011d7a7 <do_exit+77/260>
Trace; c011d9c3 <sys_exit+13/20>
Trace; c0108e0f <system_call+33/38>

Code;  c012bc54 <find_trylock_page+34/60>
00000000 <_EIP>:
Code;  c012bc54 <find_trylock_page+34/60>   <=====
   0:   39 58 08                  cmp    %ebx,0x8(%eax)   <=====
Code;  c012bc57 <find_trylock_page+37/60>
   3:   74 05                     je     a <_EIP+0xa>
Code;  c012bc59 <find_trylock_page+39/60>
   5:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c012bc5c <find_trylock_page+3c/60>
   8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
Code;  c012bc5e <find_trylock_page+3e/60>
   a:   39 70 0c                  cmp    %esi,0xc(%eax)
Code;  c012bc61 <find_trylock_page+41/60>
   d:   75 f6                     jne    5 <_EIP+0x5>
Code;  c012bc63 <find_trylock_page+43/60>
   f:   85 c0                     test   %eax,%eax
Code;  c012bc65 <find_trylock_page+45/60>
  11:   89 c2                     mov    %eax,%edx
Code;  c012bc67 <find_trylock_page+47/60>
  13:   74 00                     je     15 <_EIP+0x15>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000006e2
c012b8d5
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b8d5>]    Tainted: P 
EFLAGS: 00010202
eax: 000006da   ebx: ce97f134   ecx: 00000010   edx: 000092d6
esi: 000006bd   edi: 000006da   ebp: cff64b58   esp: c5c67ec4
ds: 0018   es: 0018   ss: 0018
Process imap (pid: 13250, stackpage=c5c67000)
Stack: c109bee0 c01613e0 000006d9 cff64b54 c799d5c0 0000001d 000006bd c799d5c0 
       00000a86 c012bf6f 0000001f 00000020 000006af c799d5c0 c10fcebc ce97f134 
       000006af c012c1cc 00000001 c799d5c0 ce97f080 c10fcebc 00001000 00000001 
Call Trace:    [<c01613e0>] [<c012bf6f>] [<c012c1cc>] [<c012c7b0>] [<c012c904>]
  [<c012c7b0>] [<c0139f53>] [<c0108e0f>]
Code: 39 58 08 74 05 8b 40 10 eb f2 39 78 0c 75 f6 31 c0 83 c4 14 


>>EIP; c012b8d5 <page_cache_read+45/c0>   <=====

>>ebx; ce97f134 <_end+e68d0b4/10651000>
>>ebp; cff64b58 <_end+fc72ad8/10651000>
>>esp; c5c67ec4 <_end+5975e44/10651000>

Trace; c01613e0 <ext3_get_block+0/90>
Trace; c012bf6f <generic_file_readahead+cf/170>
Trace; c012c1cc <do_generic_file_read+18c/450>
Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c012c904 <generic_file_read+b4/1a0>
Trace; c012c7b0 <file_read_actor+0/a0>
Trace; c0139f53 <sys_read+a3/130>
Trace; c0108e0f <system_call+33/38>

Code;  c012b8d5 <page_cache_read+45/c0>
00000000 <_EIP>:
Code;  c012b8d5 <page_cache_read+45/c0>   <=====
   0:   39 58 08                  cmp    %ebx,0x8(%eax)   <=====
Code;  c012b8d8 <page_cache_read+48/c0>
   3:   74 05                     je     a <_EIP+0xa>
Code;  c012b8da <page_cache_read+4a/c0>
   5:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c012b8dd <page_cache_read+4d/c0>
   8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
Code;  c012b8df <page_cache_read+4f/c0>
   a:   39 78 0c                  cmp    %edi,0xc(%eax)
Code;  c012b8e2 <page_cache_read+52/c0>
   d:   75 f6                     jne    5 <_EIP+0x5>
Code;  c012b8e4 <page_cache_read+54/c0>
   f:   31 c0                     xor    %eax,%eax
Code;  c012b8e6 <page_cache_read+56/c0>
  11:   83 c4 14                  add    $0x14,%esp


1 warning issued.  Results may not be reliable.

--=-rRx4nUUz/2Ytvr6/t+Ai
Content-Disposition: inline; filename=config-2.4.23-pre8
Content-Type: text/plain; name=config-2.4.23-pre8; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_RELAXED_AML=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=2
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=128
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_MEGARAID2=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m

#
# Wireless Pcmcia cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
# CONFIG_AIRONET4500_CS is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_OLD=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
CONFIG_INPUT_IFORCE_USB=m
# CONFIG_INPUT_IFORCE_232 is not set
CONFIG_INPUT_WARRIOR=m
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_K8 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_ATI is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=m
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=m
# CONFIG_VIDEO_SAA5249 is not set
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZR36120=m
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
CONFIG_SOUND_TVMIXER=m
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_EMI26=m

#
#   USB Bluetooth can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_AX8817X=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=m
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_USB_SCO=y
CONFIG_BLUEZ_USB_ZERO_PACKET=y
CONFIG_BLUEZ_HCIUART=m
CONFIG_BLUEZ_HCIUART_H4=y
CONFIG_BLUEZ_HCIUART_BCSP=y
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=y
CONFIG_BLUEZ_HCIBFUSB=m
CONFIG_BLUEZ_HCIDTL1=m
CONFIG_BLUEZ_HCIBT3C=m
CONFIG_BLUEZ_HCIBLUECARD=m
CONFIG_BLUEZ_HCIBTUART=m
CONFIG_BLUEZ_HCIVHCI=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_FW_LOADER=m

--=-rRx4nUUz/2Ytvr6/t+Ai--

