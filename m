Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUGURBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUGURBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUGURBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:01:54 -0400
Received: from mail.tdb.com ([216.99.214.4]:57509 "HELO mail.tdb.com")
	by vger.kernel.org with SMTP id S266544AbUGURBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:01:49 -0400
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Oops 2.6.8-rc1 doing an rsync to USB mass storage
References: <861xj62prs.fsf@coulee.tdb.com> <20040721063939.GB21404@kroah.com>
From: Russell Senior <seniorr@aracnet.com>
Date: 21 Jul 2004 10:01:45 -0700
In-Reply-To: <20040721063939.GB21404@kroah.com>
Message-ID: <86wu0xl2fa.fsf@coulee.tdb.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Russell> I am rsyncing from over a network to a locally attached USB2
Russell> Mass Storage external 200gig IDE drive in an ADS Technologies
Russell> enclosure.  Locks up the box solid, can't ping, can't SysRq
Russell> anything.  I've seen this on two different IDE drives and
Russell> enclosures, and also a similar but uncaptured Oops under
Russell> 2.6.7 (whereupon I tried 2.6.8-rc1).

Greg> Can you try 2.6.8-rc2?  It has some usb fixes in it that might
Greg> help here.

Oops'd on 2.6.8-rc2 also.

   # ksymoops oops-2.6.8-rc2
   ksymoops 2.4.9 on i686 2.6.8-rc2.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8-rc2/ (default)
        -m /boot/System.map-2.6.8-rc2 (default)

   Warning: You did not tell me where to find symbol information.  I will
   assume that the log matches the kernel and modules that are running
   right now and I'll use the default options above for symbol resolution.
   If the current kernel and/or modules do not match the log, you can get
   more accurate output by telling me the kernel version and where to find
   map, modules, ksyms etc.  ksymoops -h explains the options.

   Error (regular_file): read_ksyms stat /proc/ksyms failed
   No modules in ksyms, skipping objects
   No ksyms, skipping lsmod
   Unable to handle kernel paging request at virtual address 00100104
   f8be21e5
   *pde = 00000000
   Oops: 0002 [#1]
   CPU:    1
   EIP:    0060:[<f8be21e5>]    Not tainted
   Using defaults from ksymoops -t elf32-i386 -a i386
   EFLAGS: 00010046   (2.6.8-rc2) 
   eax: 00100100   ebx: 00001c00   ecx: f75bb0f8   edx: 00200200
   esi: f75bb0c0   edi: f7d9eee0   ebp: e3ccfee8   esp: e3ccfea8
   ds: 007b   es: 007b   ss: 0068
   Stack: f6e22000 f7d9eee0 00001000 00001c00 e3cce000 f6c4214c 01000000 00000000 
          00000001 00000000 f75bb218 f75bb600 00000000 f6c4214c 00000000 f6c42100 
          e3ccff18 f8be30b5 f6e22000 f6c42100 00000000 f6c42160 00000000 00000000 
   Call Trace:
    [<c01053ff>] show_stack+0x7f/0xa0
    [<c01055af>] show_registers+0x15f/0x1c0
    [<c0105772>] die+0xa2/0x120
    [<c0115286>] do_page_fault+0x1f6/0x5ac
    [<c0105079>] error_code+0x2d/0x38
    [<f8be30b5>] scan_async+0xa5/0x170 [ehci_hcd]
    [<f8be55c5>] ehci_work+0x35/0xd0 [ehci_hcd]
    [<f8be4e08>] ehci_watchdog+0x68/0xb0 [ehci_hcd]
    [<c0125b58>] run_timer_softirq+0xe8/0x1d0
    [<c01213f5>] __do_softirq+0xb5/0xc0
    [<c0121435>] do_softirq+0x35/0x40
    [<c0111e17>] smp_apic_timer_interrupt+0xd7/0x150
    [<c0104ffe>] apic_timer_interrupt+0x1a/0x20
   Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 46 38 00 01 10 00 89 


   >>EIP; f8be21e5 <__crc_ide_abort+795fd/153619>   <=====

   >>ecx; f75bb0f8 <__crc_unlock_rename+dbda/13348b>
   >>edx; 00200200 <__crc_smp_call_function+b422f/3a03fb>
   >>esi; f75bb0c0 <__crc_unlock_rename+dba2/13348b>
   >>edi; f7d9eee0 <__crc_pci_remove_behind_bridge+1113ad/566930>
   >>ebp; e3ccfee8 <__crc_ide_set_handler+9570ff/b5d134>
   >>esp; e3ccfea8 <__crc_ide_set_handler+9570bf/b5d134>

   Trace; c01053ff <show_stack+7f/a0>
   Trace; c01055af <show_registers+15f/1c0>
   Trace; c0105772 <die+a2/120>
   Trace; c0115286 <do_page_fault+1f6/5ac>
   Trace; c0105079 <error_code+2d/38>
   Trace; f8be30b5 <__crc_ide_abort+7a4cd/153619>
   Trace; f8be55c5 <__crc_ide_abort+7c9dd/153619>
   Trace; f8be4e08 <__crc_ide_abort+7c220/153619>
   Trace; c0125b58 <run_timer_softirq+e8/1d0>
   Trace; c01213f5 <__do_softirq+b5/c0>
   Trace; c0121435 <do_softirq+35/40>
   Trace; c0111e17 <smp_apic_timer_interrupt+d7/150>
   Trace; c0104ffe <apic_timer_interrupt+1a/20>

   Code;  f8be21e5 <__crc_ide_abort+795fd/153619>
   00000000 <_EIP>:
   Code;  f8be21e5 <__crc_ide_abort+795fd/153619>   <=====
      0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
   Code;  f8be21e8 <__crc_ide_abort+79600/153619>
      3:   89 02                     mov    %eax,(%edx)
   Code;  f8be21ea <__crc_ide_abort+79602/153619>
      5:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)
   Code;  f8be21f1 <__crc_ide_abort+79609/153619>
      c:   c7 46 38 00 01 10 00      movl   $0x100100,0x38(%esi)
   Code;  f8be21f8 <__crc_ide_abort+79610/153619>
     13:   89 00                     mov    %eax,(%eax)

    <0>Kernel panic: Fatal exception in interrupt

   1 warning and 1 error issued.  Results may not be reliable.


-- 
Russell Senior         ``I have nine fingers; you have ten.''
seniorr@aracnet.com
