Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTK1LNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTK1LNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:13:30 -0500
Received: from max.hkust.se ([193.13.80.103]:7085 "EHLO max.hkust.se")
	by vger.kernel.org with ESMTP id S262131AbTK1LMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:12:54 -0500
Message-ID: <3FC72D71.9090708@hkust.se>
Date: Fri, 28 Nov 2003 12:11:45 +0100
From: Magnus Stenman <stone@hkust.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us, sv
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops on P4 i875 w/ 2 gig RAM [2.4 stuff]
References: <3FC1EE97.7020302@hkust.se>
In-Reply-To: <3FC1EE97.7020302@hkust.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-hkust.se-MailScanner-Information: Virusscanner at http://www.hkust.se/virus/
X-hkust.se-MailScanner: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nobody has any clues?

you know, there *is* a juicy kernel BUG in there


/magnus

(BUG oops at end of message)

Magnus Stenman wrote:

 > Hi!
 >
 > I realize it's 2.6 time but this problem is driving me nuts. I've 
searched LKML, RH bugzilla, Google, etc and cannot find a resolution.
 >
 >
 > Machine has a Gigabyte GA-8IK1100 mobo (intel i875 chipset) with an 
Adaptec AHA-2940UW Pro PCI card, 3 SCSI drives, SDT-9000 DAT drive
 > Intel P4 2.60GHz with (and without) HT
 >
 > 2 gig DDR400 non-ecc dual channel (mobo manufacturer certified) 
samsung memory
 >
 > Properly cooled case
 >
 > No special kernel options
 > Redhat 7.3 with latest errata
 >
 > Module                  Size  Used by    Not tainted
 > appletalk              28396  11  (autoclean)
 > 3c59x                  29192   1
 > st                     30416   0
 > ext3                   69600   4
 > jbd                    51816   4  [ext3]
 > aic7xxx               134784   5
 > sd_mod                 12828  10
 > scsi_mod              110876   3  [st aic7xxx sd_mod]
 >
 > some oddities in dmesg; unexpected IO-APIC, detects some XEON? stuff
 >
 >
 > Symptoms:
 >
 > The machine crashes after days or hours when using 2 gig memory.
 > When using 512Mb it runs fine for weeks.
 >
 >
 >
 > I cannot come up with anything that triggers the crashes. 
Mem/disk/CPU load does not trigger it.
 >
 > Tried both SMP and UP, (turned on and off HT in BIOS, booted SMP/UP 
kernel)
 >
 > Replaced memory (different manufacturer, same specs)
 >
 > Replaced motherboard (from ASUS->Gigabyte, roughly same specs)
 >
 > Passes Memtest86
 >
 >
 >
 > Anyone got any suggestions?
 >
 >
 > /magnus
 >
 >
 > attached two of the oopses (a couple more are attached compressed, 
including some with kernel BUGs in them)
 >
 >
 > ------------------------------------------------------------------------
 >
 > ksymoops 2.4.4 on i686 2.4.20-20.7smp.  Options used
 >      -V (default)
 >      -k /proc/ksyms (specified)
 >      -l /proc/modules (default)
 >      -o /lib/modules/2.4.20-20.7smp/ (default)
 >      -m /boot/System.map-2.4.20-20.7smp (default)
 >      -i
 >
 > Nov 20 01:45:47 lakrits kernel: Unable to handle kernel paging 
request at virtual address 8502a858
 > Nov 20 01:45:47 lakrits kernel: c015d0db
 > Nov 20 01:45:47 lakrits kernel: *pde = 00000000
 > Nov 20 01:45:47 lakrits kernel: Oops: 0000
 > Nov 20 01:45:47 lakrits kernel: CPU:    1
 > Nov 20 01:45:47 lakrits kernel: EIP:    0010:[<c015d0db>]    Not tainted
 > Using defaults from ksymoops -t elf32-i386 -a i386
 > Nov 20 01:45:47 lakrits kernel: EFLAGS: 00010282
 > Nov 20 01:45:47 lakrits kernel: eax: 8502a840   ebx: f0e29900   ecx: 
f4e29910   edx: ce84c930
 > Nov 20 01:45:47 lakrits kernel: esi: d414cf7c   edi: 8502a840   ebp: 
0000135e   esp: c44c1f3c
 > Nov 20 01:45:47 lakrits kernel: ds: 0018   es: 0018   ss: 0018
 > Nov 20 01:45:47 lakrits kernel: Process kswapd (pid: 5, 
stackpage=c44c1000)
 > Nov 20 01:45:47 lakrits kernel: Stack: f7fb0000 ea2f6760 ea2f6760 
f1bce580 ce84c918 ce84c900 f0e29900 c015a84b
 > Nov 20 01:45:47 lakrits kernel:        f0e29900 c01485ac ea2f6760 
c014ab7a 00000246 c44c1f84 00c4c5f5 c0118e94
 > Nov 20 01:45:47 lakrits kernel:        c44c1f84 c44c1f84 00000000 
00000000 00c4c5f5 00000100 c030c4a0 000001d0
 > Nov 20 01:45:47 lakrits kernel: Call Trace:   [<c015a84b>] 
prune_dcache [kernel] 0xeb (0xc44c1f58))
 > Nov 20 01:45:47 lakrits kernel: [<c01485ac>] balance_dirty_state 
[kernel] 0xc (0xc44c1f60))
 > Nov 20 01:45:47 lakrits kernel: [<c014ab7a>] try_to_free_buffers 
[kernel] 0x13a (0xc44c1f68))
 > Nov 20 01:45:47 lakrits kernel: [<c0118e94>] schedule_timeout 
[kernel] 0x84 (0xc44c1f78))
 > Nov 20 01:45:47 lakrits kernel: [<c015ac40>] shrink_dcache_memory 
[kernel] 0x20 (0xc44c1fa0))
 > Nov 20 01:45:47 lakrits kernel: [<c013c513>] 
do_try_to_free_pages_kswapd [kernel] 0x13 (0xc44c1fa8))
 > Nov 20 01:45:47 lakrits kernel: [<c013c9e1>] kswapd [kernel] 0x141 
(0xc44c1fd4))
 > Nov 20 01:45:47 lakrits kernel: [<c0105000>] stext [kernel] 0x0 
(0xc44c1fe8))
 > Nov 20 01:45:47 lakrits kernel: [<c0107266>] arch_kernel_thread 
[kernel] 0x26 (0xc44c1ff0))
 > Nov 20 01:45:47 lakrits kernel: [<c013c8a0>] kswapd [kernel] 0x0 
(0xc44c1ff8))
 > Nov 20 01:45:47 lakrits kernel: Code: 8b 47 18 85 c0 74 04 53 ff d0 
58 68 dc 0a 31 c0 8d 43 2c 50
 >
 >
 >>> EIP; c015d0db <iput+3b/280>   <=====
 >
 >
 > Trace; c015a84b <prune_dcache+eb/190>
 > Trace; c01485ac <balance_dirty_state+c/60>
 > Trace; c014ab7a <try_to_free_buffers+13a/150>
 > Trace; c0118e94 <schedule_timeout+84/a0>
 > Trace; c015ac40 <shrink_dcache_memory+20/30>
 > Trace; c013c513 <do_try_to_free_pages_kswapd+13/310>
 > Trace; c013c9e1 <kswapd+141/4e0>
 > Trace; c0105000 <_stext+0/0>
 > Trace; c0107266 <arch_kernel_thread+26/30>
 > Trace; c013c8a0 <kswapd+0/4e0>
 > Code;  c015d0db <iput+3b/280>
 > 00000000 <_EIP>:
 > Code;  c015d0db <iput+3b/280>   <=====
 >    0:   8b 47 18                  mov    0x18(%edi),%eax   <=====
 > Code;  c015d0de <iput+3e/280>
 >    3:   85 c0                     test   %eax,%eax
 > Code;  c015d0e0 <iput+40/280>
 >    5:   74 04                     je     b <_EIP+0xb> c015d0e6 
<iput+46/280>
 > Code;  c015d0e2 <iput+42/280>
 >    7:   53                        push   %ebx
 > Code;  c015d0e3 <iput+43/280>
 >    8:   ff d0                     call   *%eax
 > Code;  c015d0e5 <iput+45/280>
 >    a:   58                        pop    %eax
 > Code;  c015d0e6 <iput+46/280>
 >    b:   68 dc 0a 31 c0            push   $0xc0310adc
 > Code;  c015d0eb <iput+4b/280>
 >   10:   8d 43 2c                  lea    0x2c(%ebx),%eax
 > Code;  c015d0ee <iput+4e/280>
 >   13:   50                        push   %eax
 >
 >
 >
 > ------------------------------------------------------------------------
 >
 > ksymoops 2.4.4 on i686 2.4.20-20.7smp.  Options used
 >      -V (default)
 >      -k /proc/ksyms (specified)
 >      -l /proc/modules (default)
 >      -o /lib/modules/2.4.20-20.7smp/ (default)
 >      -m /boot/System.map-2.4.20-20.7smp (default)
 >      -i
 >
 > Oct 22 02:19:26 lakrits kernel: Unable to handle kernel paging 
request at virtual address 00cd14a4
 > Oct 22 02:19:26 lakrits kernel: c01432a7
 > Oct 22 02:19:26 lakrits kernel: *pde = 00000000
 > Oct 22 02:19:26 lakrits kernel: Oops: 0000
 > Oct 22 02:19:26 lakrits kernel: CPU:    1
 > Oct 22 02:19:26 lakrits kernel: EIP:    0010:[<c01432a7>]    Not tainted
 > Using defaults from ksymoops -t elf32-i386 -a i386
 > Oct 22 02:19:26 lakrits kernel: EFLAGS: 00010206
 > Oct 22 02:19:26 lakrits kernel: eax: 00000000   ebx: c44c0000   ecx: 
f66a1880   edx: c102a9d0
 > Oct 22 02:19:26 lakrits kernel: esi: c102a9d0   edi: 00cd1428   ebp: 
000001f4   esp: c44c1f74
 > Oct 22 02:19:26 lakrits kernel: ds: 0018   es: 0018   ss: 0018
 > Oct 22 02:19:26 lakrits kernel: Process kscand (pid: 6, 
stackpage=c44c1000)
 > Oct 22 02:19:26 lakrits kernel: Stack: 0000001e 00000000 00000000 
00000000 c44c1fac c102a9d0 c44c0000 c102a9d0
 > Oct 22 02:19:26 lakrits kernel:        00000000 000001f4 c013b3f1 
c44c1fac c102a9b4 c030d558 00000001 c44c0000
 > Oct 22 02:19:26 lakrits kernel:        c030c4a0 00000000 000001f4 
c013d339 c030c4a0 00000000 00000001 c44c0000
 > Oct 22 02:19:26 lakrits kernel: Call Trace:   [<c013b3f1>] 
scan_active_list [kernel] 0xe1 (0xc44c1f9c))
 > Oct 22 02:19:26 lakrits kernel: [<c013d339>] kscand [kernel] 0xc9 
(0xc44c1fc0))
 > Oct 22 02:19:26 lakrits kernel: [<c0105000>] stext [kernel] 0x0 
(0xc44c1fe8))
 > Oct 22 02:19:26 lakrits kernel: [<c0107266>] arch_kernel_thread 
[kernel] 0x26 (0xc44c1ff0))
 > Oct 22 02:19:26 lakrits kernel: [<c013d270>] kscand [kernel] 0x0 
(0xc44c1ff8))
 > Oct 22 02:19:26 lakrits kernel: Code: 8b 47 7c 85 c0 0f 84 38 01 00 
00 8b 35 b0 84 3b c0 90 8d b4
 >
 >
 >>> EIP; c01432a7 <page_referenced+177/320>   <=====
 >
 >
 > Trace; c013b3f1 <scan_active_list+e1/6d0>
 > Trace; c013d339 <kscand+c9/1ce>
 > Trace; c0105000 <_stext+0/0>
 > Trace; c0107266 <arch_kernel_thread+26/30>
 > Trace; c013d270 <kscand+0/1ce>
 > Code;  c01432a7 <page_referenced+177/320>
 > 00000000 <_EIP>:
 > Code;  c01432a7 <page_referenced+177/320>   <=====
 >    0:   8b 47 7c                  mov    0x7c(%edi),%eax   <=====
 > Code;  c01432aa <page_referenced+17a/320>
 >    3:   85 c0                     test   %eax,%eax
 > Code;  c01432ac <page_referenced+17c/320>
 >    5:   0f 84 38 01 00 00         je     143 <_EIP+0x143> c01433ea 
<page_referenced+2ba/320>
 > Code;  c01432b2 <page_referenced+182/320>
 >    b:   8b 35 b0 84 3b c0         mov    0xc03b84b0,%esi
 > Code;  c01432b8 <page_referenced+188/320>
 >   11:   90                        nop    Code;  c01432b9 
<page_referenced+189/320>
 >   12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi
 >


---
Oct 23 13:30:41 lakrits kernel: kernel BUG at rmap.c:278!
Oct 23 13:30:41 lakrits kernel: invalid operand: 0000
Oct 23 13:30:41 lakrits kernel: CPU:    0
Oct 23 13:30:41 lakrits kernel: EIP:    0010:[<c013af47>]    Not tainted
Oct 23 13:30:41 lakrits kernel: EFLAGS: 00010246
Oct 23 13:30:41 lakrits kernel: eax: f6800500   ebx: f6800500   ecx: 
00000006   edx: 00000000
Oct 23 13:30:41 lakrits kernel: esi: 00000000   edi: f69ab500   ebp: 
3a4a943c   esp: f6b93e88
Oct 23 13:30:41 lakrits kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 13:30:41 lakrits kernel: Process httpd (pid: 882, stackpage=f6b93000)
Oct 23 13:30:41 lakrits kernel: Stack: 7e226005 c2b97880 ffff743c 
4210f000 c0126a2c 7e226005 ffff843c f69ab500
Oct 23 13:30:41 lakrits kernel:        00000001 4212c000 f686e420 
f6b94420 f6952918 00000200 00000000 f7301818
Oct 23 13:30:41 lakrits kernel:        00000246 00000000 c0136670 
c01153ce f699c780 f699c80c f699c7c4 f6b67f80
Oct 23 13:30:41 lakrits kernel: Call Trace:   [<c0126a2c>] 
copy_page_range [kernel] 0x21c (0xf6b93e98))
Oct 23 13:30:41 lakrits kernel: [<c0136670>] __get_free_pages [kernel] 
0x10 (0xf6b93ed0))
Oct 23 13:30:41 lakrits kernel: [<c01153ce>] pgd_alloc [kernel] 0xe 
(0xf6b93ed4))
Oct 23 13:30:41 lakrits kernel: [<c0116cb7>] copy_mm [kernel] 0x227 
(0xf6b93ee8))
Oct 23 13:30:41 lakrits kernel: [<c0117572>] do_fork [kernel] 0x432 
(0xf6b93f2c))
Oct 23 13:30:41 lakrits kernel: [<f8860bd2>] ext3_file_write [ext3] 0x22 
(0xf6b93f3c))
Oct 23 13:30:41 lakrits kernel: [<c014bbe2>] sys_select [kernel] 0x472 
(0xf6b93f70))
Oct 23 13:30:41 lakrits kernel: [<c01074b5>] sys_fork [kernel] 0x15 
(0xf6b93fac))
Oct 23 13:30:41 lakrits kernel: [<c01088c3>] system_call [kernel] 0x33 
(0xf6b93fc0))
Oct 23 13:30:41 lakrits kernel: Code: 0f 0b 16 01 73 42 23 c0 b9 1d 00 
00 00 8d 53 04 89 f6 8d bc

 >>EIP; c013af47 <refill_inactive_zone+f57/1260>   <=====
Trace; c0126a2c <sys_rt_sigprocmask+1cc/1f0>
Trace; c0136670 <kmem_cache_destroy+70/120>
Trace; c01153ce <apm+26e/2d1>
Trace; c0116cb7 <clear_IO_APIC_pin+37/b0>
Trace; c0117572 <set_ioapic_affinity+42/a0>
Trace; f8860bd2 <END_OF_CODE+17f8dce7/????>
Trace; c014bbe2 <drop_super+32/50>
Trace; c01074b5 <dump_thread+115/120>
Trace; c01088c3 <do_signal+b3/27b>
Code;  c013af47 <refill_inactive_zone+f57/1260>
00000000 <_EIP>:
Code;  c013af47 <refill_inactive_zone+f57/1260>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c013af49 <refill_inactive_zone+f59/1260>
    2:   16                        push   %ss
Code;  c013af4a <refill_inactive_zone+f5a/1260>
    3:   01 73 42                  add    %esi,0x42(%ebx)
Code;  c013af4d <refill_inactive_zone+f5d/1260>
    6:   23 c0                     and    %eax,%eax
Code;  c013af4f <refill_inactive_zone+f5f/1260>
    8:   b9 1d 00 00 00            mov    $0x1d,%ecx
Code;  c013af54 <refill_inactive_zone+f64/1260>
    d:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c013af57 <refill_inactive_zone+f67/1260>
   10:   89 f6                     mov    %esi,%esi
Code;  c013af59 <refill_inactive_zone+f69/1260>
   12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

Oct 23 13:35:02 lakrits kernel: kernel BUG at rmap.c:278!
Oct 23 13:35:02 lakrits kernel: invalid operand: 0000
Oct 23 13:35:02 lakrits kernel: CPU:    0
Oct 23 13:35:02 lakrits kernel: EIP:    0010:[<c013af47>]    Not tainted
Oct 23 13:35:02 lakrits kernel: EFLAGS: 00010246
Oct 23 13:35:02 lakrits kernel: eax: f6800500   ebx: f6800500   ecx: 
00000006   edx: 00000000
Oct 23 13:35:02 lakrits kernel: esi: 00000000   edi: f69abe80   ebp: 
3fa9543c   esp: f6273e88
Oct 23 13:35:02 lakrits kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 13:35:02 lakrits kernel: Process afpd (pid: 1211, stackpage=f6273000)
Oct 23 13:35:02 lakrits kernel: Stack: 7e226005 c2b97880 ffff743c 
4210f000 c0126a2c 7e226005 ffff843c f69abe80
Oct 23 13:35:02 lakrits kernel:        00000001 4212c000 f6036420 
f6271420 c02df738 000001f0 f6952c80 f689e930
Oct 23 13:35:02 lakrits kernel:        00000246 00000000 c0136670 
c01153ce f6a89880 f6a8990c f6a898c4 f6833680
Oct 23 13:35:02 lakrits kernel: Call Trace:   [<c0126a2c>] 
copy_page_range [kernel] 0x21c (0xf6273e98))
Oct 23 13:35:02 lakrits kernel: [<c0136670>] __get_free_pages [kernel] 
0x10 (0xf6273ed0))
Oct 23 13:35:02 lakrits kernel: [<c01153ce>] pgd_alloc [kernel] 0xe 
(0xf6273ed4))
Oct 23 13:35:02 lakrits kernel: [<c0116cb7>] copy_mm [kernel] 0x227 
(0xf6273ee8))
Oct 23 13:35:02 lakrits kernel: [<c0117572>] do_fork [kernel] 0x432 
(0xf6273f2c))
Oct 23 13:35:02 lakrits kernel: [<c01296ef>] do_munmap [kernel] 0x24f 
(0xf6273f60))
Oct 23 13:35:02 lakrits kernel: [<c013d33d>] filp_close [kernel] 0x4d 
(0xf6273f90))
Oct 23 13:35:02 lakrits kernel: [<c01074b5>] sys_fork [kernel] 0x15 
(0xf6273fac))
Oct 23 13:35:02 lakrits kernel: [<c01088c3>] system_call [kernel] 0x33 
(0xf6273fc0))
Oct 23 13:35:02 lakrits kernel: Code: 0f 0b 16 01 73 42 23 c0 b9 1d 00 
00 00 8d 53 04 89 f6 8d bc

 >>EIP; c013af47 <refill_inactive_zone+f57/1260>   <=====
Trace; c0126a2c <sys_rt_sigprocmask+1cc/1f0>
Trace; c0136670 <kmem_cache_destroy+70/120>
Trace; c01153ce <apm+26e/2d1>
Trace; c0116cb7 <clear_IO_APIC_pin+37/b0>
Trace; c0117572 <set_ioapic_affinity+42/a0>
Trace; c01296ef <exec_usermodehelper+df/420>
Trace; c013d33d <kscand+cd/1ce>
Trace; c01074b5 <dump_thread+115/120>
Trace; c01088c3 <do_signal+b3/27b>
Code;  c013af47 <refill_inactive_zone+f57/1260>
00000000 <_EIP>:
Code;  c013af47 <refill_inactive_zone+f57/1260>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c013af49 <refill_inactive_zone+f59/1260>
    2:   16                        push   %ss
Code;  c013af4a <refill_inactive_zone+f5a/1260>
    3:   01 73 42                  add    %esi,0x42(%ebx)
Code;  c013af4d <refill_inactive_zone+f5d/1260>
    6:   23 c0                     and    %eax,%eax
Code;  c013af4f <refill_inactive_zone+f5f/1260>
    8:   b9 1d 00 00 00            mov    $0x1d,%ecx
Code;  c013af54 <refill_inactive_zone+f64/1260>
    d:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c013af57 <refill_inactive_zone+f67/1260>
   10:   89 f6                     mov    %esi,%esi
Code;  c013af59 <refill_inactive_zone+f69/1260>
   12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

Oct 23 12:16:31 lakrits kernel: kernel BUG at page_alloc.c:109!
Oct 23 12:16:31 lakrits kernel: invalid operand: 0000
Oct 23 12:16:31 lakrits kernel: CPU:    0
Oct 23 12:16:31 lakrits kernel: EIP:    0010:[<c0135b9c>]    Not tainted
Oct 23 12:16:31 lakrits kernel: EFLAGS: 00010206
Oct 23 12:16:31 lakrits kernel: eax: 00000012   ebx: c2402938   ecx: 
c2402954   edx: c20e6554
Oct 23 12:16:31 lakrits kernel: esi: 00000040   edi: 00000000   ebp: 
00000048   esp: d5c95c64
Oct 23 12:16:31 lakrits kernel: ds: 0018   es: 0018   ss: 0018
Oct 23 12:16:31 lakrits kernel: Process httpd (pid: 24549, 
stackpage=d5c95000)
Oct 23 12:16:31 lakrits kernel: Stack: c01373a0 c034a2c0 c02df450 
c1c40030 c02df69c 00000203 ffffffff 00017d1a
Oct 23 12:16:31 lakrits kernel:        c2402938 00000040 00100000 
5b797067 c012661a c2402938 000a3000 ffff88a8
Oct 23 12:16:31 lakrits kernel:        c0126db1 f580c800 080a3000 
ffff88a8 08000000 0000009b 00000000 08287000
Oct 23 12:16:31 lakrits kernel: Call Trace:   [<c01373a0>] 
remove_exclusive_swap_page [kernel] 0xb0 (0xd5c95c64))
Oct 23 12:16:31 lakrits kernel: [<c012661a>] __free_pte [kernel] 0x4a 
(0xd5c95c94))
Oct 23 12:16:31 lakrits kernel: [<c0126db1>] zap_page_range [kernel] 
0x221 (0xd5c95ca4))
Oct 23 12:16:31 lakrits kernel: [<c017d359>] scrup [kernel] 0x69 
(0xd5c95ce4))
Oct 23 12:16:31 lakrits kernel: [<c0129a78>] exit_mmap [kernel] 0xa8 
(0xd5c95d14))
Oct 23 12:16:31 lakrits kernel: [<c0116a37>] mmput [kernel] 0x37 
(0xd5c95d48))
Oct 23 12:16:31 lakrits kernel: [<c011ad98>] do_exit [kernel] 0xa8 
(0xd5c95d54))
Oct 23 12:16:31 lakrits kernel: [<c0118196>] __call_console_drivers 
[kernel] 0x46 (0xd5c95d60))
Oct 23 12:16:31 lakrits kernel: [<c0118490>] printk [kernel] 0x100 
(0xd5c95dac))
Oct 23 12:16:31 lakrits kernel: [<c011445e>] bust_spinlocks [kernel] 
0x3e (0xd5c95dbc))
Oct 23 12:16:31 lakrits kernel: [<c0108ed1>] die [kernel] 0x61 (0xd5c95dc8))
Oct 23 12:16:31 lakrits kernel: [<c0109120>] do_invalid_op [kernel] 0x0 
(0xd5c95dd4))
Oct 23 12:16:31 lakrits kernel: [<c01091ac>] do_invalid_op [kernel] 0x8c 
(0xd5c95ddc))
Oct 23 12:16:31 lakrits kernel: [<f8865105>] ext3_mark_iloc_dirty [ext3] 
0x35 (0xd5c95df8))
Oct 23 12:16:31 lakrits kernel: [<c020a967>] inet_accept [kernel] 0x37 
(0xd5c95e18))
Oct 23 12:16:31 lakrits kernel: [<c01fc57d>] tcp_clear_xmit_timers 
[kernel] 0x6d (0xd5c95e2c))
Oct 23 12:16:31 lakrits kernel: [<c020184e>] tcp_time_wait [kernel] 
0x26e (0xd5c95e3c))
Oct 23 12:16:31 lakrits kernel: [<f88634fd>] ext3_commit_write [ext3] 
0x1ed (0xd5c95e48))
Oct 23 12:16:31 lakrits kernel: [<c01d0d69>] sk_free [kernel] 0x69 
(0xd5c95e60))
Oct 23 12:16:31 lakrits kernel: [<c01f1e7f>] tcp_close [kernel] 0x4ef 
(0xd5c95e78))
Oct 23 12:16:31 lakrits kernel: [<c01089b4>] error_code [kernel] 0x34 
(0xd5c95e94))
Oct 23 12:16:31 lakrits kernel: [<c020a967>] inet_accept [kernel] 0x37 
(0xd5c95ec8))
Oct 23 12:16:31 lakrits kernel: [<c01cf593>] sys_accept [kernel] 0x63 
(0xd5c95ee4))
Oct 23 12:16:31 lakrits kernel: [<c014b384>] poll_freewait [kernel] 0x44 
(0xd5c95f20))
Oct 23 12:16:31 lakrits kernel: [<c014b726>] do_select [kernel] 0x226 
(0xd5c95f30))
Oct 23 12:16:31 lakrits kernel: [<c014bbe2>] sys_select [kernel] 0x472 
(0xd5c95f70))
Oct 23 12:16:31 lakrits kernel: [<c01cffe0>] sys_socketcall [kernel] 
0xb0 (0xd5c95f8c))
Oct 23 12:16:31 lakrits kernel: [<c01088c3>] system_call [kernel] 0x33 
(0xd5c95fc0))
Oct 23 12:16:31 lakrits kernel: Code: 0f 0b 6d 00 f6 40 23 c0 8b 73 08 
85 f6 74 29 68 e0 38 23 c0

 >>EIP; c0135b9c <vread+2c/b0>   <=====
Trace; c01373a0 <kmem_cache_reap+230/370>
Trace; c012661a <force_sig+a/20>
Trace; c0126db1 <sys_rt_sigtimedwait+2c1/320>
Trace; c017d359 <semctl_main+f9/430>
Trace; c0129a78 <exec_modprobe+48/80>
Trace; c0116a37 <__mask_IO_APIC_irq+67/a0>
Trace; c011ad98 <copy_mm+278/2f0>
Trace; c0118196 <remap_area_pages+176/1d0>
Trace; c0118490 <set_pmd_pte+0/50>
Trace; c011445e <apm_engage_power_management+2e/80>
Trace; c0108ed1 <show_trace+b1/c0>
Trace; c0109120 <handle_BUG+10/90>
Trace; c01091ac <die+c/90>
Trace; f8865105 <END_OF_CODE+17f9221a/????>
Trace; c020a967 <tcp_setsockopt+3c7/7b0>
Trace; c01fc57d <ip_route_input_slow+76d/9a0>
Trace; c020184e <ip_options_rcv_srr+1e/160>
Trace; f88634fd <END_OF_CODE+17f90612/????>
Trace; c01d0d69 <vgacon_scrolldelta+9/130>
Trace; c01f1e7f <wireless_process_ioctl+1ef/6b0>
Trace; c01089b4 <do_signal+1a4/27b>
Trace; c020a967 <tcp_setsockopt+3c7/7b0>
Trace; c01cf593 <isapnp_set_port+23/120>
Trace; c014b384 <.text.lock.buffer+25b/287>
Trace; c014b726 <get_filesystem_list+66/80>
Trace; c014bbe2 <drop_super+32/50>
Trace; c01cffe0 <vgacon_build_attr+20/a0>
Trace; c01088c3 <do_signal+b3/27b>
Code;  c0135b9c <vread+2c/b0>
00000000 <_EIP>:
Code;  c0135b9c <vread+2c/b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0135b9e <vread+2e/b0>
    2:   6d                        insl   (%dx),%es:(%edi)
Code;  c0135b9f <vread+2f/b0>
    3:   00 f6                     add    %dh,%dh
Code;  c0135ba1 <vread+31/b0>
    5:   40                        inc    %eax
Code;  c0135ba2 <vread+32/b0>
    6:   23 c0                     and    %eax,%eax
Code;  c0135ba4 <vread+34/b0>
    8:   8b 73 08                  mov    0x8(%ebx),%esi
Code;  c0135ba7 <vread+37/b0>
    b:   85 f6                     test   %esi,%esi
Code;  c0135ba9 <vread+39/b0>
    d:   74 29                     je     38 <_EIP+0x38> c0135bd4 
<vread+64/b0>
Code;  c0135bab <vread+3b/b0>
    f:   68 e0 38 23 c0            push   $0xc02338e0
----





