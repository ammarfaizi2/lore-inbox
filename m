Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbRACEKy>; Tue, 2 Jan 2001 23:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRACEKr>; Tue, 2 Jan 2001 23:10:47 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:6153 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132124AbRACEKX>; Tue, 2 Jan 2001 23:10:23 -0500
Message-ID: <3A529F06.5BFA4229@Hell.WH8.TU-Dresden.De>
Date: Wed, 03 Jan 2001 04:39:50 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in prune_dcache (2.4.0-prerelease)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus et. all

While under massive disk and cpu load, 2.4.0-prerelease produced
the following oops (decode see below)

Keith, I've read the FAQ about having been bitten by Makefile bugs
with certain symbols and such, yet I still get these symbol warnings
even after a mrproper rebuild. Any clues?

-Udo.

ksymoops 2.3.5 on i686 2.4.0-prerelease.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-prerelease/ (default)
     -m /boot/System.map-2.4.0-prerelease (specified)

Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_cm_memcpy_R__ver_acpi_cm_memcpy not found in System.map.  Ignoring ksyms_base entry

[ ** many other warnings snipped to reduce spam ** ]

Unable to handle kernel paging request at virtual address 01000014
c01419cc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01419cc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 01000000   ebx: c20847e0   ecx: c2081d10   edx: c2081d10
esi: c20847c0   edi: c2081d00   ebp: 00002c79   esp: c147bfa4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c147b000)
Stack: 00010f00 00000003 00000004 00000000 c0141cc1 00006ea6 c012a0d3 00000006 
       00000004 00010f00 c023e1f1 c147a239 0008e000 c012a19a 00000004 00000000 
       cffe5fbc c0105000 ffffff9c c01074d3 00000000 c02d6d64 c02a5fdc 
Call Trace: [<c0141cc1>] [<c012a0d3>] [<c023e1f1>] [<c012a19a>] [<c0105000>] [<c01074d3>] 
Code: 8b 40 14 85 c0 74 09 57 56 ff d0 83 c4 08 eb 0c 57 e8 be 1b 

>>EIP; c01419cc <prune_dcache+9c/120>   <=====
Trace; c0141cc1 <shrink_dcache_memory+21/30>
Trace; c012a0d3 <do_try_to_free_pages+53/90>
Trace; c023e1f1 <tvecs+2169/1b124>
Trace; c012a19a <kswapd+8a/140>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01074d3 <kernel_thread+23/30>
Code;  c01419cc <prune_dcache+9c/120>
00000000 <_EIP>:
Code;  c01419cc <prune_dcache+9c/120>   <=====
   0:   8b 40 14                  movl   0x14(%eax),%eax   <=====
Code;  c01419cf <prune_dcache+9f/120>
   3:   85 c0                     testl  %eax,%eax
Code;  c01419d1 <prune_dcache+a1/120>
   5:   74 09                     je     10 <_EIP+0x10> c01419dc <prune_dcache+ac/120>
Code;  c01419d3 <prune_dcache+a3/120>
   7:   57                        pushl  %edi
Code;  c01419d4 <prune_dcache+a4/120>
   8:   56                        pushl  %esi
Code;  c01419d5 <prune_dcache+a5/120>
   9:   ff d0                     call   *%eax
Code;  c01419d7 <prune_dcache+a7/120>
   b:   83 c4 08                  addl   $0x8,%esp
Code;  c01419da <prune_dcache+aa/120>
   e:   eb 0c                     jmp    1c <_EIP+0x1c> c01419e8 <prune_dcache+b8/120>
Code;  c01419dc <prune_dcache+ac/120>
  10:   57                        pushl  %edi
Code;  c01419dd <prune_dcache+ad/120>
  11:   e8 be 1b 00 00            call   1bd4 <_EIP+0x1bd4> c01435a0 <iput+0/150>


45 warnings issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
