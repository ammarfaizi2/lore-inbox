Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTKXLma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 06:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTKXLma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 06:42:30 -0500
Received: from max.hkust.se ([193.13.80.103]:50644 "EHLO max.hkust.se")
	by vger.kernel.org with ESMTP id S263762AbTKXLmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 06:42:15 -0500
Message-ID: <3FC1EE97.7020302@hkust.se>
Date: Mon, 24 Nov 2003 12:42:15 +0100
From: Magnus Stenman <stone@hkust.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us, sv
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: oops on P4 i875 w/ 2 gig RAM
Content-Type: multipart/mixed;
 boundary="------------060709070409060602060305"
X-hkust.se-MailScanner-Information: Virusscanner at http://www.hkust.se/virus/
X-hkust.se-MailScanner: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709070409060602060305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I realize it's 2.6 time but this problem is driving me nuts. I've 
searched LKML, RH bugzilla, Google, etc and cannot find a resolution.


Machine has a Gigabyte GA-8IK1100 mobo (intel i875 chipset) with an 
Adaptec AHA-2940UW Pro PCI card, 3 SCSI drives, SDT-9000 DAT drive
Intel P4 2.60GHz with (and without) HT

2 gig DDR400 non-ecc dual channel (mobo manufacturer certified) samsung 
memory

Properly cooled case

No special kernel options
Redhat 7.3 with latest errata

Module                  Size  Used by    Not tainted
appletalk              28396  11  (autoclean)
3c59x                  29192   1
st                     30416   0
ext3                   69600   4
jbd                    51816   4  [ext3]
aic7xxx               134784   5
sd_mod                 12828  10
scsi_mod              110876   3  [st aic7xxx sd_mod]

some oddities in dmesg; unexpected IO-APIC, detects some XEON? stuff


Symptoms:

The machine crashes after days or hours when using 2 gig memory.
When using 512Mb it runs fine for weeks.



I cannot come up with anything that triggers the crashes. Mem/disk/CPU 
load does not trigger it.

Tried both SMP and UP, (turned on and off HT in BIOS, booted SMP/UP kernel)

Replaced memory (different manufacturer, same specs)

Replaced motherboard (from ASUS->Gigabyte, roughly same specs)

Passes Memtest86



Anyone got any suggestions?


/magnus


attached two of the oopses (a couple more are attached compressed, 
including some with kernel BUGs in them)


--------------060709070409060602060305
Content-Type: text/plain;
 name="oops.11-20"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.11-20"

ksymoops 2.4.4 on i686 2.4.20-20.7smp.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-20.7smp/ (default)
     -m /boot/System.map-2.4.20-20.7smp (default)
     -i

Nov 20 01:45:47 lakrits kernel: Unable to handle kernel paging request at virtual address 8502a858
Nov 20 01:45:47 lakrits kernel: c015d0db
Nov 20 01:45:47 lakrits kernel: *pde = 00000000
Nov 20 01:45:47 lakrits kernel: Oops: 0000
Nov 20 01:45:47 lakrits kernel: CPU:    1
Nov 20 01:45:47 lakrits kernel: EIP:    0010:[<c015d0db>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 20 01:45:47 lakrits kernel: EFLAGS: 00010282
Nov 20 01:45:47 lakrits kernel: eax: 8502a840   ebx: f0e29900   ecx: f4e29910   edx: ce84c930
Nov 20 01:45:47 lakrits kernel: esi: d414cf7c   edi: 8502a840   ebp: 0000135e   esp: c44c1f3c
Nov 20 01:45:47 lakrits kernel: ds: 0018   es: 0018   ss: 0018
Nov 20 01:45:47 lakrits kernel: Process kswapd (pid: 5, stackpage=c44c1000)
Nov 20 01:45:47 lakrits kernel: Stack: f7fb0000 ea2f6760 ea2f6760 f1bce580 ce84c918 ce84c900 f0e29900 c015a84b
Nov 20 01:45:47 lakrits kernel:        f0e29900 c01485ac ea2f6760 c014ab7a 00000246 c44c1f84 00c4c5f5 c0118e94
Nov 20 01:45:47 lakrits kernel:        c44c1f84 c44c1f84 00000000 00000000 00c4c5f5 00000100 c030c4a0 000001d0
Nov 20 01:45:47 lakrits kernel: Call Trace:   [<c015a84b>] prune_dcache [kernel] 0xeb (0xc44c1f58))
Nov 20 01:45:47 lakrits kernel: [<c01485ac>] balance_dirty_state [kernel] 0xc (0xc44c1f60))
Nov 20 01:45:47 lakrits kernel: [<c014ab7a>] try_to_free_buffers [kernel] 0x13a (0xc44c1f68))
Nov 20 01:45:47 lakrits kernel: [<c0118e94>] schedule_timeout [kernel] 0x84 (0xc44c1f78))
Nov 20 01:45:47 lakrits kernel: [<c015ac40>] shrink_dcache_memory [kernel] 0x20 (0xc44c1fa0))
Nov 20 01:45:47 lakrits kernel: [<c013c513>] do_try_to_free_pages_kswapd [kernel] 0x13 (0xc44c1fa8))
Nov 20 01:45:47 lakrits kernel: [<c013c9e1>] kswapd [kernel] 0x141 (0xc44c1fd4))
Nov 20 01:45:47 lakrits kernel: [<c0105000>] stext [kernel] 0x0 (0xc44c1fe8))
Nov 20 01:45:47 lakrits kernel: [<c0107266>] arch_kernel_thread [kernel] 0x26 (0xc44c1ff0))
Nov 20 01:45:47 lakrits kernel: [<c013c8a0>] kswapd [kernel] 0x0 (0xc44c1ff8))
Nov 20 01:45:47 lakrits kernel: Code: 8b 47 18 85 c0 74 04 53 ff d0 58 68 dc 0a 31 c0 8d 43 2c 50

>>EIP; c015d0db <iput+3b/280>   <=====
Trace; c015a84b <prune_dcache+eb/190>
Trace; c01485ac <balance_dirty_state+c/60>
Trace; c014ab7a <try_to_free_buffers+13a/150>
Trace; c0118e94 <schedule_timeout+84/a0>
Trace; c015ac40 <shrink_dcache_memory+20/30>
Trace; c013c513 <do_try_to_free_pages_kswapd+13/310>
Trace; c013c9e1 <kswapd+141/4e0>
Trace; c0105000 <_stext+0/0>
Trace; c0107266 <arch_kernel_thread+26/30>
Trace; c013c8a0 <kswapd+0/4e0>
Code;  c015d0db <iput+3b/280>
00000000 <_EIP>:
Code;  c015d0db <iput+3b/280>   <=====
   0:   8b 47 18                  mov    0x18(%edi),%eax   <=====
Code;  c015d0de <iput+3e/280>
   3:   85 c0                     test   %eax,%eax
Code;  c015d0e0 <iput+40/280>
   5:   74 04                     je     b <_EIP+0xb> c015d0e6 <iput+46/280>
Code;  c015d0e2 <iput+42/280>
   7:   53                        push   %ebx
Code;  c015d0e3 <iput+43/280>
   8:   ff d0                     call   *%eax
Code;  c015d0e5 <iput+45/280>
   a:   58                        pop    %eax
Code;  c015d0e6 <iput+46/280>
   b:   68 dc 0a 31 c0            push   $0xc0310adc
Code;  c015d0eb <iput+4b/280>
  10:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c015d0ee <iput+4e/280>
  13:   50                        push   %eax


--------------060709070409060602060305
Content-Type: text/plain;
 name="oops.10-22"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.10-22"

ksymoops 2.4.4 on i686 2.4.20-20.7smp.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-20.7smp/ (default)
     -m /boot/System.map-2.4.20-20.7smp (default)
     -i

Oct 22 02:19:26 lakrits kernel: Unable to handle kernel paging request at virtual address 00cd14a4
Oct 22 02:19:26 lakrits kernel: c01432a7
Oct 22 02:19:26 lakrits kernel: *pde = 00000000
Oct 22 02:19:26 lakrits kernel: Oops: 0000
Oct 22 02:19:26 lakrits kernel: CPU:    1
Oct 22 02:19:26 lakrits kernel: EIP:    0010:[<c01432a7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 22 02:19:26 lakrits kernel: EFLAGS: 00010206
Oct 22 02:19:26 lakrits kernel: eax: 00000000   ebx: c44c0000   ecx: f66a1880   edx: c102a9d0
Oct 22 02:19:26 lakrits kernel: esi: c102a9d0   edi: 00cd1428   ebp: 000001f4   esp: c44c1f74
Oct 22 02:19:26 lakrits kernel: ds: 0018   es: 0018   ss: 0018
Oct 22 02:19:26 lakrits kernel: Process kscand (pid: 6, stackpage=c44c1000)
Oct 22 02:19:26 lakrits kernel: Stack: 0000001e 00000000 00000000 00000000 c44c1fac c102a9d0 c44c0000 c102a9d0
Oct 22 02:19:26 lakrits kernel:        00000000 000001f4 c013b3f1 c44c1fac c102a9b4 c030d558 00000001 c44c0000
Oct 22 02:19:26 lakrits kernel:        c030c4a0 00000000 000001f4 c013d339 c030c4a0 00000000 00000001 c44c0000
Oct 22 02:19:26 lakrits kernel: Call Trace:   [<c013b3f1>] scan_active_list [kernel] 0xe1 (0xc44c1f9c))
Oct 22 02:19:26 lakrits kernel: [<c013d339>] kscand [kernel] 0xc9 (0xc44c1fc0))
Oct 22 02:19:26 lakrits kernel: [<c0105000>] stext [kernel] 0x0 (0xc44c1fe8))
Oct 22 02:19:26 lakrits kernel: [<c0107266>] arch_kernel_thread [kernel] 0x26 (0xc44c1ff0))
Oct 22 02:19:26 lakrits kernel: [<c013d270>] kscand [kernel] 0x0 (0xc44c1ff8))
Oct 22 02:19:26 lakrits kernel: Code: 8b 47 7c 85 c0 0f 84 38 01 00 00 8b 35 b0 84 3b c0 90 8d b4

>>EIP; c01432a7 <page_referenced+177/320>   <=====
Trace; c013b3f1 <scan_active_list+e1/6d0>
Trace; c013d339 <kscand+c9/1ce>
Trace; c0105000 <_stext+0/0>
Trace; c0107266 <arch_kernel_thread+26/30>
Trace; c013d270 <kscand+0/1ce>
Code;  c01432a7 <page_referenced+177/320>
00000000 <_EIP>:
Code;  c01432a7 <page_referenced+177/320>   <=====
   0:   8b 47 7c                  mov    0x7c(%edi),%eax   <=====
Code;  c01432aa <page_referenced+17a/320>
   3:   85 c0                     test   %eax,%eax
Code;  c01432ac <page_referenced+17c/320>
   5:   0f 84 38 01 00 00         je     143 <_EIP+0x143> c01433ea <page_referenced+2ba/320>
Code;  c01432b2 <page_referenced+182/320>
   b:   8b 35 b0 84 3b c0         mov    0xc03b84b0,%esi
Code;  c01432b8 <page_referenced+188/320>
  11:   90                        nop    
Code;  c01432b9 <page_referenced+189/320>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi


--------------060709070409060602060305
Content-Type: application/x-tar;
 name="oops.resolved.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="oops.resolved.gz"

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
--------------060709070409060602060305
Content-Type: application/x-tar;
 name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.gz"

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
--------------060709070409060602060305--

