Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUDDBQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 20:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUDDBQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 20:16:12 -0500
Received: from pool-162-83-168-144.ny5030.east.verizon.net ([162.83.168.144]:43991
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S262078AbUDDBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 20:15:55 -0500
Message-ID: <32948.192.168.0.250.1081041322.squirrel@192.168.0.250>
Date: Sat, 3 Apr 2004 20:15:22 -0500 (EST)
Subject: Re: 2.6.5-rc3-mm4
From: "Paul Blazejowski" <paulb@blazebox.homeip.net>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under kernel 2.6.5-rc3-mm4 i get a nice oops when trying to see the
contents of NFS export from BSD box.The NFS share gets mounted and shows:

blazebox:/usr/home/paul on /mnt/nfs type nfs (rw,addr=192.168.0.1)

but any attempt to browse using ls or nautilus etc... gets seg faulted.

dmesg:

Unable to handle kernel NULL pointer dereference at virtual address 00000002
 printing eip:
43bdb08f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<43bdb08f>]    Tainted: P   VLI
EFLAGS: 00010206   (2.6.5-rc3-mm4)
EIP is at nfs3_decode_dirent+0xf/0x250 [nfs]
eax: 00000002   ebx: 00000000   ecx: 00000016   edx: 31bb6000
esi: 31bb6000   edi: 2443cf50   ebp: 00000002   esp: 2443cd50
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 6283, threadinfo=2443c000 task=244ace10)
Stack: 00000000 035f76c0 00001000 00000002 ffff82b0 40c493c0 24473c80
035f76c0
       00000000 00000000 035f76c0 0213c2f0 2443cf28 035f76c0 00000000
000000d0
       00000000 035f76c0 2443cf50 00000000 43bca5d0 31bb6000 00000002
00000002
Call Trace:
 [<0213c2f0>] read_cache_page+0x90/0x410
 [<43bca5d0>] nfs_readdir+0x200/0x8b0 [nfs]
 [<43bd8885>] nfs3_proc_access+0xd5/0x140 [nfs]
 [<0213a639>] find_get_page+0x29/0x70
 [<0213bc77>] filemap_nopage+0x2b7/0x420
 [<0214eed3>] page_add_rmap+0x23/0xd0
 [<0214a969>] do_no_page+0x1d9/0x500
 [<0214aee1>] handle_mm_fault+0x101/0x1e0
 [<43bdb080>] nfs3_decode_dirent+0x0/0x250 [nfs]
 [<0216cec6>] vfs_readdir+0x86/0xa0
 [<0216d2d0>] filldir64+0x0/0x180
 [<0216d4c3>] sys_getdents64+0x73/0xc5
 [<0216d2d0>] filldir64+0x0/0x180
 [<0216c4c9>] sys_fcntl64+0x59/0xa0

Code: 70 ff ff ff 89 0c 24 89 44 24 04 e8 4c f0 ff ff 89 c1 e9 21 fe ff ff
90 8d 74 26 00 55 57 56 53 83 ec 40 8b 6c 24 58 8b 74 24 54 <8b> 45 00 89
44 24 10 8b 45 04 89 44 24 14 8b 45 08 89 44 24 18

ksymoops decoded:

Apr  3 18:46:49 blaze kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000002
Apr  3 18:46:49 blaze kernel: 43bdb08f
Apr  3 18:46:49 blaze kernel: *pde = 00000000
Apr  3 18:46:49 blaze kernel: Oops: 0000 [#1]
Apr  3 18:46:49 blaze kernel: CPU:    0
Apr  3 18:46:49 blaze kernel: EIP:    0060:[<43bdb08f>]    Tainted: P   VLI
Apr  3 18:46:49 blaze kernel: EFLAGS: 00010206   (2.6.5-rc3-mm4)
Apr  3 18:46:49 blaze kernel: eax: 00000002   ebx: 00000000   ecx:
00000016   edx: 31bb6000
Apr  3 18:46:49 blaze kernel: esi: 31bb6000   edi: 2443cf50   ebp:
00000002   esp: 2443cd50
Apr  3 18:46:49 blaze kernel: ds: 007b   es: 007b   ss: 0068
Apr  3 18:46:49 blaze kernel: Stack: 00000000 035f76c0 00001000 00000002
ffff82b0 40c493c0 24473c80 035f76c0
Apr  3 18:46:49 blaze kernel:        00000000 00000000 035f76c0 0213c2f0
2443cf28 035f76c0 00000000 000000d0
Apr  3 18:46:49 blaze kernel:        00000000 035f76c0 2443cf50 00000000
43bca5d0 31bb6000 00000002 00000002
Apr  3 18:46:49 blaze kernel: Call Trace:
Apr  3 18:46:49 blaze kernel:  [<0213c2f0>] read_cache_page+0x90/0x410
Apr  3 18:46:49 blaze kernel:  [<43bca5d0>] nfs_readdir+0x200/0x8b0 [nfs]
Apr  3 18:46:49 blaze kernel:  [<43bd8885>] nfs3_proc_access+0xd5/0x140 [nfs]
Apr  3 18:46:49 blaze kernel:  [<0213a639>] find_get_page+0x29/0x70
Apr  3 18:46:49 blaze kernel:  [<0213bc77>] filemap_nopage+0x2b7/0x420
Apr  3 18:46:49 blaze kernel:  [<0214eed3>] page_add_rmap+0x23/0xd0
Apr  3 18:46:49 blaze kernel:  [<0214a969>] do_no_page+0x1d9/0x500
Apr  3 18:46:49 blaze kernel:  [<0214aee1>] handle_mm_fault+0x101/0x1e0
Apr  3 18:46:49 blaze kernel:  [<43bdb080>] nfs3_decode_dirent+0x0/0x250
[nfs]
Apr  3 18:46:49 blaze kernel:  [<0216cec6>] vfs_readdir+0x86/0xa0
Apr  3 18:46:49 blaze kernel:  [<0216d2d0>] filldir64+0x0/0x180
Apr  3 18:46:49 blaze kernel:  [<0216d4c3>] sys_getdents64+0x73/0xc5
Apr  3 18:46:49 blaze kernel:  [<0216d2d0>] filldir64+0x0/0x180
Apr  3 18:46:49 blaze kernel:  [<0216c4c9>] sys_fcntl64+0x59/0xa0
Apr  3 18:46:49 blaze kernel: Code: 70 ff ff ff 89 0c 24 89 44 24 04 e8 4c
f0 ff ff 89 c1 e9 21 fe ff ff 90 8d 74 26 00 55 57 56 53 83 ec 40 8b 6c 24
58 8b 74 24 54 <8b> 45 00 89 44 24 10 8b 45 04 89 44 24 14 8b 45 08 89 44
24 18


>>EIP; 43bdb08f <__crc_acpi_os_free+3f4db/1e7237>   <=====

>>edx; 31bb6000 <__crc_handle_sysrq+24d7e3/4319f2>
>>esi; 31bb6000 <__crc_handle_sysrq+24d7e3/4319f2>
>>edi; 2443cf50 <__crc_cap_bprm_compute_creds+47557d/556d6f>
>>esp; 2443cd50 <__crc_cap_bprm_compute_creds+47537d/556d6f>

Trace; 0213c2f0 <read_cache_page+90/410>
Trace; 43bca5d0 <__crc_acpi_os_free+2ea1c/1e7237>
Trace; 43bd8885 <__crc_acpi_os_free+3ccd1/1e7237>
Trace; 0213a639 <find_get_page+29/70>
Trace; 0213bc77 <filemap_nopage+2b7/420>
Trace; 0214eed3 <page_add_rmap+23/d0>
Trace; 0214a969 <do_no_page+1d9/500>
Trace; 0214aee1 <handle_mm_fault+101/1e0>
Trace; 43bdb080 <__crc_acpi_os_free+3f4cc/1e7237>
Trace; 0216cec6 <vfs_readdir+86/a0>
Trace; 0216d2d0 <filldir64+0/180>
Trace; 0216d4c3 <sys_getdents64+73/c5>
Trace; 0216d2d0 <filldir64+0/180>
Trace; 0216c4c9 <sys_fcntl64+59/a0>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  43bdb064 <__crc_acpi_os_free+3f4b0/1e7237>
00000000 <_EIP>:
Code;  43bdb064 <__crc_acpi_os_free+3f4b0/1e7237>
   0:   70 ff                     jo     1 <_EIP+0x1>
Code;  43bdb066 <__crc_acpi_os_free+3f4b2/1e7237>
   2:   ff                        (bad)
Code;  43bdb067 <__crc_acpi_os_free+3f4b3/1e7237>
   3:   ff 89 0c 24 89 44         decl   0x4489240c(%ecx)
Code;  43bdb06d <__crc_acpi_os_free+3f4b9/1e7237>
   9:   24 04                     and    $0x4,%al
Code;  43bdb06f <__crc_acpi_os_free+3f4bb/1e7237>
   b:   e8 4c f0 ff ff            call   fffff05c <_EIP+0xfffff05c>
Code;  43bdb074 <__crc_acpi_os_free+3f4c0/1e7237>
  10:   89 c1                     mov    %eax,%ecx
Code;  43bdb076 <__crc_acpi_os_free+3f4c2/1e7237>
  12:   e9 21 fe ff ff            jmp    fffffe38 <_EIP+0xfffffe38>
Code;  43bdb07b <__crc_acpi_os_free+3f4c7/1e7237>
  17:   90                        nop
Code;  43bdb07c <__crc_acpi_os_free+3f4c8/1e7237>
  18:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  43bdb080 <__crc_acpi_os_free+3f4cc/1e7237>
  1c:   55                        push   %ebp
Code;  43bdb081 <__crc_acpi_os_free+3f4cd/1e7237>
  1d:   57                        push   %edi
Code;  43bdb082 <__crc_acpi_os_free+3f4ce/1e7237>
  1e:   56                        push   %esi
Code;  43bdb083 <__crc_acpi_os_free+3f4cf/1e7237>
  1f:   53                        push   %ebx
Code;  43bdb084 <__crc_acpi_os_free+3f4d0/1e7237>
  20:   83 ec 40                  sub    $0x40,%esp
Code;  43bdb087 <__crc_acpi_os_free+3f4d3/1e7237>
  23:   8b 6c 24 58               mov    0x58(%esp),%ebp
Code;  43bdb08b <__crc_acpi_os_free+3f4d7/1e7237>
  27:   8b 74 24 54               mov    0x54(%esp),%esi

This decode from eip onwards should be reliable

Code;  43bdb08f <__crc_acpi_os_free+3f4db/1e7237>
00000000 <_EIP>:
Code;  43bdb08f <__crc_acpi_os_free+3f4db/1e7237>   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  43bdb092 <__crc_acpi_os_free+3f4de/1e7237>
   3:   89 44 24 10               mov    %eax,0x10(%esp)
Code;  43bdb096 <__crc_acpi_os_free+3f4e2/1e7237>
   7:   8b 45 04                  mov    0x4(%ebp),%eax
Code;  43bdb099 <__crc_acpi_os_free+3f4e5/1e7237>
   a:   89 44 24 14               mov    %eax,0x14(%esp)
Code;  43bdb09d <__crc_acpi_os_free+3f4e9/1e7237>
   e:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  43bdb0a0 <__crc_acpi_os_free+3f4ec/1e7237>
  11:   89 44 24 18               mov    %eax,0x18(%esp)

lsmod:

nfs                   192256  1
lockd                  64200  2 nfs
sunrpc                143816  4 nfs,lockd

Last kernel NFS worked here was 2.6.5-rc3-mm1 (have not tried mm2/mm3).

BTW, the 1394 debug messages i reported are still showing up in dmesg...on
this kernel.

Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
Call Trace:
 [<4381310e>] get_phy_reg+0x10e/0x120 [ohci1394]
 [<43813f3c>] ohci_devctl+0x5c/0x5d0 [ohci1394]
 [<02114a54>] delay_pmtmr+0x14/0x20
 [<43816058>] ohci_irq_handler+0x588/0x830 [ohci1394]
 [<0212833f>] do_timer+0xdf/0xf0
 [<0210ac2a>] handle_IRQ_event+0x3a/0x70
 [<0210b005>] do_IRQ+0xd5/0x1b0
 =======================
 [<43813193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<022d2467>] hcd_submit_urb+0x137/0x160
 [<438c6d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<438cf3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<438c6d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<438c41a5>] hpsb_reset_bus+0x35/0x40 [ieee1394]
 [<438c6df4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<02128154>] run_timer_softirq+0xd4/0x1d0
 [<0212fefd>] rcu_process_callbacks+0x9d/0x100
 [<02123e7d>] __do_softirq+0x7d/0x80
 [<0210b92e>] do_softirq+0x4e/0x60
 =======================
 [<0210b08b>] do_IRQ+0x15b/0x1b0

Badness in set_phy_reg at drivers/ieee1394/ohci1394.c:267
Call Trace:
 [<43813230>] set_phy_reg+0x110/0x120 [ohci1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<02114a54>] delay_pmtmr+0x14/0x20
 [<43816058>] ohci_irq_handler+0x588/0x830 [ohci1394]
 [<0212833f>] do_timer+0xdf/0xf0
 [<0210ac2a>] handle_IRQ_event+0x3a/0x70
 [<0210b005>] do_IRQ+0xd5/0x1b0
 =======================
 [<43813193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<022d2467>] hcd_submit_urb+0x137/0x160
 [<438c6d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<438cf3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<438c6d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<438c41a5>] hpsb_reset_bus+0x35/0x40 [ieee1394]
 [<438c6df4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<02128154>] run_timer_softirq+0xd4/0x1d0
 [<0212fefd>] rcu_process_callbacks+0x9d/0x100
 [<02123e7d>] __do_softirq+0x7d/0x80
 [<0210b92e>] do_softirq+0x4e/0x60
 =======================
 [<0210b08b>] do_IRQ+0x15b/0x1b0

Regards,

Paul

-- 
FreeBSD -- The Power To Serve!

