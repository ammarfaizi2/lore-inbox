Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUL3SHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUL3SHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 13:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUL3SHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 13:07:34 -0500
Received: from boromix.nask.net.pl ([195.187.245.33]:2285 "EHLO
	boromix.nask.net.pl") by vger.kernel.org with ESMTP id S261688AbUL3SAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 13:00:52 -0500
Date: Thu, 30 Dec 2004 19:00:19 +0100 (CET)
From: Mateusz.Blaszczyk@nask.pl
X-X-Sender: mat@boromir
Reply-To: Mateusz.Blaszczyk@nask.pl
To: petero2@telia.com
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [pktcdvd] Badness in fork.c:91 then Oops
Message-ID: <Pine.GSO.4.58.0412301854420.2875@boromir>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
VirusProtection: checked - Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

PKTCDVD seems to create some badness in kernel/fork, line 91:

I loaded pktcdvd manaully end everything was fine

Dec 30 08:32:46 localhost kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com

Then I tried to map cd drive using udftools' pktsetup (v.1.0.3b):

Dec 30 08:33:27 localhost kernel: cdrom: This disc doesn't have any tracks I recognize!
Dec 30 08:33:27 localhost kernel: Badness in __put_task_struct at kernel/fork.c:91
Dec 30 08:33:27 localhost kernel:  [__put_task_struct+36/163] __put_task_struct+0x24/0xa3
Dec 30 08:33:27 localhost kernel:  [schedule+1041/1108] schedule+0x411/0x454
Dec 30 08:33:27 localhost kernel:  [wait_for_completion+128/195] wait_for_completion+0x80/0xc3
Dec 30 08:33:27 localhost kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Dec 30 08:33:27 localhost kernel:  [__wake_up+30/64] __wake_up+0x1e/0x40
Dec 30 08:33:27 localhost kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Dec 30 08:33:27 localhost kernel:  [kthread_create+169/221] kthread_create+0xa9/0xdd
Dec 30 08:33:27 localhost kernel:  [keventd_create_kthread+0/57] keventd_create_kthread+0x0/0x39
Dec 30 08:33:27 localhost kernel:  [pg0+268747723/1069315072] kcdrwd+0x0/0x1b9 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268753608/1069315072] pkt_new_dev+0xf6/0x1de [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268747723/1069315072] kcdrwd+0x0/0x1b9 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [blk_alloc_queue+15/81] blk_alloc_queue+0xf/0x51
Dec 30 08:33:27 localhost kernel:  [pg0+268754323/1069315072] pkt_setup_dev+0x13a/0x1a4 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268754935/1069315072] pkt_ctl_ioctl+0x75/0xf5 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [sys_ioctl+460/489] sys_ioctl+0x1cc/0x1e9
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel: pktcdvd: writer pktcdvd0 mapped to hdc

After some 2-3 minutes there was OOPS:

Dec 30 08:38:40 localhost kernel: Unable to handle kernel paging request at virtual address 00100100
Dec 30 08:38:40 localhost kernel:  printing eip:
Dec 30 08:38:40 localhost kernel: c0121653
Dec 30 08:38:40 localhost kernel: *pde = 00000000
Dec 30 08:38:40 localhost kernel: Oops: 0000 [#1]
Dec 30 08:38:40 localhost kernel: PREEMPT
Dec 30 08:38:40 localhost kernel: Modules linked in: pktcdvd lp binfmt_misc button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables usbhid ipw2100 ieee80211 ieee80211_crypt 8139too mii hw_random intel_agp agpgart parport_pc parport pcspkr cryptoloop loop
Dec 30 08:38:40 localhost kernel: CPU:    0
Dec 30 08:38:40 localhost kernel: EIP:    0060:[find_pid+36/60]    Not tainted VLI
Dec 30 08:38:40 localhost kernel: EFLAGS: 00010006   (2.6.10)
Dec 30 08:38:40 localhost kernel: EIP is at find_pid+0x24/0x3c
Dec 30 08:38:40 localhost kernel: eax: ce8cc118   ebx: 00001e91   ecx: 00100100   edx: 00100100
Dec 30 08:38:40 localhost kernel: esi: 00000000   edi: ce8cca20   ebp: ce8ccad8   esp: cebf5f1c
Dec 30 08:38:40 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 08:38:40 localhost kernel: Process automount (pid: 6031, threadinfo=cebf4000 task=cefea600)
Dec 30 08:38:40 localhost kernel: Stack: ce8cca20 c012168a 00001e91 ce8cca20 cedb42a8 b7fd88c8 cebf4000 c01141bf
Dec 30 08:38:40 localhost kernel:        cebf5fc4 bffff868 01200011 c0159041 cd9fb474 00000000 00000004 cebf5fc4
Dec 30 08:38:40 localhost kernel:        01200011 00000000 00001e91 c0114470 00000000 00000000 b7fd88c8 00001e91
Dec 30 08:38:40 localhost kernel: Call Trace:
Dec 30 08:38:40 localhost kernel:  [attach_pid+31/163] attach_pid+0x1f/0xa3
Dec 30 08:38:40 localhost kernel:  [copy_process+2147/2582] copy_process+0x863/0xa16
Dec 30 08:38:40 localhost kernel:  [pipe_readv+558/570] pipe_readv+0x22e/0x23a
Dec 30 08:38:40 localhost kernel:  [do_fork+162/372] do_fork+0xa2/0x174
Dec 30 08:38:40 localhost kernel:  [copy_to_user+39/47] copy_to_user+0x27/0x2f
Dec 30 08:38:40 localhost kernel:  [sys_clone+34/38] sys_clone+0x22/0x26
Dec 30 08:38:40 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 08:38:40 localhost kernel: Code: 5a 59 5b 5e 5f 5d c3 53 b9 20 00 00 00 8b 04 85 20 b3 40 c0 2b 0d 30 b3 40 c0 89 d3 69 d2 01 00 37 9e d3 ea 8b 0c 90 85 c9 74 14 <8b> 11 0f 18 02 90 39 59 fc 8d 41 fc 74 08 85 d2 89 d1 75 ec 31
Dec 30 08:38:40 localhost kernel:  <6>note: automount[6031] exited with preempt_count 1


ATTACHED full decoded oops, kerr.log and .config:

decoded oops:

ksymoops 2.4.9 on i686 2.6.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10/ (default)
     -m /boot/System.map-2.6.10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Dec 30 08:38:40 localhost kernel: Unable to handle kernel paging request at virtual address 00100100
Dec 30 08:38:40 localhost kernel: c0121653
Dec 30 08:38:40 localhost kernel: *pde = 00000000
Dec 30 08:38:40 localhost kernel: Oops: 0000 [#1]
Dec 30 08:38:40 localhost kernel: CPU:    0
Dec 30 08:38:40 localhost kernel: EIP:    0060:[find_pid+36/60]    Not tainted VLI
Dec 30 08:38:40 localhost kernel: EFLAGS: 00010006   (2.6.10)
Dec 30 08:38:40 localhost kernel: eax: ce8cc118   ebx: 00001e91   ecx: 00100100   edx: 00100100
Dec 30 08:38:40 localhost kernel: esi: 00000000   edi: ce8cca20   ebp: ce8ccad8   esp: cebf5f1c
Dec 30 08:38:40 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 08:38:40 localhost kernel: Stack: ce8cca20 c012168a 00001e91 ce8cca20 cedb42a8 b7fd88c8 cebf4000 c01141bf
Dec 30 08:38:40 localhost kernel:        cebf5fc4 bffff868 01200011 c0159041 cd9fb474 00000000 00000004 cebf5fc4
Dec 30 08:38:40 localhost kernel:        01200011 00000000 00001e91 c0114470 00000000 00000000 b7fd88c8 00001e91
Dec 30 08:38:40 localhost kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; ce8cc118 <pg0+e495118/3fbc7400>
>>edi; ce8cca20 <pg0+e495a20/3fbc7400>
>>ebp; ce8ccad8 <pg0+e495ad8/3fbc7400>
>>esp; cebf5f1c <pg0+e7bef1c/3fbc7400>

Dec 30 08:38:40 localhost kernel: Code: 5a 59 5b 5e 5f 5d c3 53 b9 20 00 00 00 8b 04 85 20 b3 40 c0 2b 0d 30 b3 40 c0 89 d3 69 d2 01 00 37 9e d3 ea 8b 0c 90 85 c9 74 14 <8b> 11 0f 18 02 90 39 59 fc 8d 41 fc 74 08 85 d2 89 d1 75 ec 31
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   5a                        pop    %edx
Code;  ffffffd6 <__kernel_rt_sigreturn+1b96/????>
   1:   59                        pop    %ecx
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   5b                        pop    %ebx
Code;  ffffffd8 <__kernel_rt_sigreturn+1b98/????>
   3:   5e                        pop    %esi
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   5f                        pop    %edi
Code;  ffffffda <__kernel_rt_sigreturn+1b9a/????>
   5:   5d                        pop    %ebp
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   c3                        ret
Code;  ffffffdc <__kernel_rt_sigreturn+1b9c/????>
   7:   53                        push   %ebx
Code;  ffffffdd <__kernel_rt_sigreturn+1b9d/????>
   8:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffe2 <__kernel_rt_sigreturn+1ba2/????>
   d:   8b 04 85 20 b3 40 c0      mov    0xc040b320(,%eax,4),%eax
Code;  ffffffe9 <__kernel_rt_sigreturn+1ba9/????>
  14:   2b 0d 30 b3 40 c0         sub    0xc040b330,%ecx
Code;  ffffffef <__kernel_rt_sigreturn+1baf/????>
  1a:   89 d3                     mov    %edx,%ebx
Code;  fffffff1 <__kernel_rt_sigreturn+1bb1/????>
  1c:   69 d2 01 00 37 9e         imul   $0x9e370001,%edx,%edx
Code;  fffffff7 <__kernel_rt_sigreturn+1bb7/????>
  22:   d3 ea                     shr    %cl,%edx
Code;  fffffff9 <__kernel_rt_sigreturn+1bb9/????>
  24:   8b 0c 90                  mov    (%eax,%edx,4),%ecx
Code;  fffffffc <__kernel_rt_sigreturn+1bbc/????>
  27:   85 c9                     test   %ecx,%ecx
Code;  fffffffe <__kernel_rt_sigreturn+1bbe/????>
  29:   74 14                     je     3f <_EIP+0x3f>
Code;  00000000 Before first symbol
  2b:   8b 11                     mov    (%ecx),%edx
Code;  00000002 Before first symbol
  2d:   0f 18 02                  prefetchnta (%edx)
Code;  00000005 Before first symbol
  30:   90                        nop
Code;  00000006 Before first symbol
  31:   39 59 fc                  cmp    %ebx,0xfffffffc(%ecx)
Code;  00000009 Before first symbol
  34:   8d 41 fc                  lea    0xfffffffc(%ecx),%eax
Code;  0000000c Before first symbol
  37:   74 08                     je     41 <_EIP+0x41>
Code;  0000000e Before first symbol
  39:   85 d2                     test   %edx,%edx
Code;  00000010 Before first symbol
  3b:   89 d1                     mov    %edx,%ecx
Code;  00000012 Before first symbol
  3d:   75 ec                     jne    2b <_EIP+0x2b>
Code;  00000014 Before first symbol
  3f:   31                        .byte 0x31


2 warnings and 1 error issued.  Results may not be reliable.


kern.log:

Dec 30 08:05:51 localhost kernel: klogd 1.4.1#16, log source = /proc/kmsg started.
Dec 30 08:05:51 localhost kernel: Inspecting /boot/System.map-2.6.10
Dec 30 08:05:52 localhost kernel: Loaded 30262 symbols from /boot/System.map-2.6.10.
Dec 30 08:05:52 localhost kernel: Symbols match kernel version 2.6.10.
Dec 30 08:05:52 localhost kernel: No module symbols loaded - kernel modules not enabled.
Dec 30 08:05:52 localhost kernel: Linux version 2.6.10 (mat@aaricia) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #1 Tue Dec 28 23:25:44 CET 2004
Dec 30 08:05:52 localhost kernel: BIOS-provided physical RAM map:
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 000000000f6f0000 - 000000000f6f8000 (ACPI data)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 000000000f6f8000 - 000000000f700000 (ACPI NVS)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 000000000f700000 - 0000000010000000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
Dec 30 08:05:52 localhost kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Dec 30 08:05:52 localhost kernel: 0MB HIGHMEM available.
Dec 30 08:05:52 localhost kernel: 246MB LOWMEM available.
Dec 30 08:05:52 localhost kernel: On node 0 totalpages: 63216
Dec 30 08:05:52 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
Dec 30 08:05:52 localhost kernel:   Normal zone: 59120 pages, LIFO batch:14
Dec 30 08:05:52 localhost kernel:   HighMem zone: 0 pages, LIFO batch:1
Dec 30 08:05:52 localhost kernel: DMI 2.3 present.
Dec 30 08:05:52 localhost kernel: ACPI: RSDP (v000 FUJ                                   ) @ 0x000f59a0
Dec 30 08:05:52 localhost kernel: ACPI: RSDT (v001 FUJ    FJNB16F  0x01060000 FUJ  0x00001000) @ 0x0f6f1dbf
Dec 30 08:05:52 localhost kernel: ACPI: FADT (v001 FUJ    FJNB16F  0x01060000 FUJ  0x00001000) @ 0x0f6f78a2
Dec 30 08:05:52 localhost kernel: ACPI: SSDT (v001 FUJ    FJNB16F  0x01060000 INTL 0x20030228) @ 0x0f6f7916
Dec 30 08:05:52 localhost kernel: ACPI: SSDT (v001 FUJ    FJNB16F  0x01060000 MSFT 0x0100000e) @ 0x0f6f7d2a
Dec 30 08:05:52 localhost kernel: ACPI: BOOT (v001 FUJ    FJNB16F  0x01060000 FUJ  0x00001000) @ 0x0f6f7fd8
Dec 30 08:05:52 localhost kernel: ACPI: DSDT (v001 FUJ    FJNB16F  0x01060000 MSFT 0x0100000e) @ 0x00000000
Dec 30 08:05:52 localhost kernel: ACPI: PM-Timer IO Port: 0xfc08
Dec 30 08:05:52 localhost kernel: Built 1 zonelists
Dec 30 08:05:52 localhost kernel: Kernel command line: BOOT_IMAGE=2610 ro root=301
Dec 30 08:05:52 localhost kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Dec 30 08:05:52 localhost kernel: mapped APIC to ffffd000 (011f1000)
Dec 30 08:05:52 localhost kernel: Initializing CPU#0
Dec 30 08:05:52 localhost kernel: PID hash table entries: 1024 (order: 10, 16384 bytes)
Dec 30 08:05:52 localhost kernel: Detected 1300.364 MHz processor.
Dec 30 08:05:52 localhost kernel: Using pmtmr for high-res timesource
Dec 30 08:05:52 localhost kernel: Console: colour dummy device 80x25
Dec 30 08:05:52 localhost kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec 30 08:05:52 localhost kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec 30 08:05:52 localhost kernel: Memory: 246760k/252864k available (1917k kernel code, 5532k reserved, 980k data, 148k init, 0k highmem)
Dec 30 08:05:52 localhost kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 30 08:05:52 localhost kernel: Calibrating delay loop... 2580.48 BogoMIPS (lpj=1290240)
Dec 30 08:05:52 localhost kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Dec 30 08:05:52 localhost kernel: CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
Dec 30 08:05:52 localhost kernel: CPU: After vendor identify, caps:  a7e9f9bf 00000000 00000000 00000000
Dec 30 08:05:52 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Dec 30 08:05:52 localhost kernel: CPU: L2 cache: 1024K
Dec 30 08:05:52 localhost kernel: CPU: After all inits, caps:        a7e9f9bf 00000000 00000000 00000040
Dec 30 08:05:52 localhost kernel: Intel machine check architecture supported.
Dec 30 08:05:52 localhost kernel: Intel machine check reporting enabled on CPU#0.
Dec 30 08:05:52 localhost kernel: CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Dec 30 08:05:52 localhost kernel: Enabling fast FPU save and restore... done.
Dec 30 08:05:52 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 30 08:05:52 localhost kernel: Checking 'hlt' instruction... OK.
Dec 30 08:05:52 localhost kernel: ACPI: setting ELCR to 0200 (from 0800)
Dec 30 08:05:52 localhost kernel: NET: Registered protocol family 16
Dec 30 08:05:52 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=3
Dec 30 08:05:52 localhost kernel: PCI: Using configuration type 1
Dec 30 08:05:52 localhost kernel: mtrr: v2.0 (20020519)
Dec 30 08:05:52 localhost kernel: ACPI: Subsystem revision 20041105
Dec 30 08:05:52 localhost kernel: ACPI: Interpreter enabled
Dec 30 08:05:52 localhost kernel: ACPI: Using PIC for interrupt routing
Dec 30 08:05:52 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec 30 08:05:52 localhost kernel: PCI: Probing PCI hardware (bus 00)
Dec 30 08:05:52 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Dec 30 08:05:52 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
Dec 30 08:05:52 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 30 08:05:52 localhost kernel: pnp: PnP ACPI init
Dec 30 08:05:52 localhost kernel: pnp: PnP ACPI: found 11 devices
Dec 30 08:05:52 localhost kernel: PnPBIOS: Disabled by ACPI
Dec 30 08:05:52 localhost kernel: SCSI subsystem initialized
Dec 30 08:05:52 localhost kernel: usbcore: registered new driver usbfs
Dec 30 08:05:52 localhost kernel: usbcore: registered new driver hub
Dec 30 08:05:52 localhost kernel: PCI: Using ACPI for IRQ routing
Dec 30 08:05:52 localhost kernel: ** PCI interrupts are no longer routed automatically.  If this
Dec 30 08:05:52 localhost kernel: ** causes a device to stop working, it is probably because the
Dec 30 08:05:52 localhost kernel: ** driver failed to call pci_enable_device().  As a temporary
Dec 30 08:05:52 localhost kernel: ** workaround, the "pci=routeirq" argument restores the old
Dec 30 08:05:52 localhost kernel: ** behavior.  If this argument makes the device work again,
Dec 30 08:05:52 localhost kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Dec 30 08:05:52 localhost kernel: ** so I can fix the driver.
Dec 30 08:05:52 localhost kernel: irda_init()
Dec 30 08:05:52 localhost kernel: NET: Registered protocol family 23
Dec 30 08:05:52 localhost kernel: Simple Boot Flag at 0x7f set to 0x1
Dec 30 08:05:52 localhost kernel: Machine check exception polling timer started.
Dec 30 08:05:52 localhost kernel: Initializing Cryptographic API
Dec 30 08:05:52 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Dec 30 08:05:52 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
Dec 30 08:05:52 localhost kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xd0080000, using 1536k, total 8000k
Dec 30 08:05:52 localhost kernel: vesafb: mode is 1024x768x8, linelength=1024, pages=9
Dec 30 08:05:52 localhost kernel: vesafb: protected mode interface info at 00ff:44f0
Dec 30 08:05:52 localhost kernel: vesafb: scrolling: redraw
Dec 30 08:05:52 localhost kernel: vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Dec 30 08:05:52 localhost kernel: Console: switching to colour frame buffer device 128x48
Dec 30 08:05:52 localhost kernel: fb0: VESA VGA frame buffer device
Dec 30 08:05:52 localhost kernel: isapnp: Scanning for PnP cards...
Dec 30 08:05:52 localhost kernel: isapnp: No Plug & Play device found
Dec 30 08:05:52 localhost kernel: Real Time Clock Driver v1.12
Dec 30 08:05:52 localhost kernel: i8042.c: Detected active multiplexing controller, rev 1.9.
Dec 30 08:05:52 localhost kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Dec 30 08:05:52 localhost kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Dec 30 08:05:52 localhost kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Dec 30 08:05:52 localhost kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Dec 30 08:05:52 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 30 08:05:52 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Dec 30 08:05:52 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 30 08:05:52 localhost kernel: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
Dec 30 08:05:52 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: PCI: setting IRQ 11 as level-triggered
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 30 08:05:52 localhost kernel: io scheduler noop registered
Dec 30 08:05:52 localhost kernel: io scheduler cfq registered
Dec 30 08:05:52 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec 30 08:05:52 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec 30 08:05:52 localhost kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Dec 30 08:05:52 localhost kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: ICH4: chipset revision 3
Dec 30 08:05:52 localhost kernel: ICH4: not 100%% native mode: will probe irqs later
Dec 30 08:05:52 localhost kernel:     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
Dec 30 08:05:52 localhost kernel:     ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide0...
Dec 30 08:05:52 localhost kernel: hda: FUJITSU MHT2020AT, ATA DISK drive
Dec 30 08:05:52 localhost kernel: elevator: using cfq as default io scheduler
Dec 30 08:05:52 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide1...
Dec 30 08:05:52 localhost kernel: hdc: TOSHIBA DVD-ROM SD-R2412, ATAPI CD/DVD-ROM drive
Dec 30 08:05:52 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide2...
Dec 30 08:05:52 localhost kernel: ide2: Wait for ready failed before probe !
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide3...
Dec 30 08:05:52 localhost kernel: ide3: Wait for ready failed before probe !
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide4...
Dec 30 08:05:52 localhost kernel: ide4: Wait for ready failed before probe !
Dec 30 08:05:52 localhost kernel: Probing IDE interface ide5...
Dec 30 08:05:52 localhost kernel: ide5: Wait for ready failed before probe !
Dec 30 08:05:52 localhost kernel: hda: max request size: 128KiB
Dec 30 08:05:52 localhost kernel: hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(100)
Dec 30 08:05:52 localhost kernel: hda: cache flushes supported
Dec 30 08:05:52 localhost kernel:  hda: hda1 hda2 hda4
Dec 30 08:05:52 localhost kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Dec 30 08:05:52 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Dec 30 08:05:52 localhost kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xd0100000
Dec 30 08:05:52 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Dec 30 08:05:52 localhost kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Dec 30 08:05:52 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
Dec 30 08:05:52 localhost kernel: hub 1-0:1.0: USB hub found
Dec 30 08:05:52 localhost kernel: hub 1-0:1.0: 6 ports detected
Dec 30 08:05:52 localhost kernel: USB Universal Host Controller Interface driver v2.2
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x1820
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Dec 30 08:05:52 localhost kernel: hub 2-0:1.0: USB hub found
Dec 30 08:05:52 localhost kernel: hub 2-0:1.0: 2 ports detected
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 0x1840
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Dec 30 08:05:52 localhost kernel: hub 3-0:1.0: USB hub found
Dec 30 08:05:52 localhost kernel: hub 3-0:1.0: 2 ports detected
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x1860
Dec 30 08:05:52 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Dec 30 08:05:52 localhost kernel: hub 4-0:1.0: USB hub found
Dec 30 08:05:52 localhost kernel: hub 4-0:1.0: 2 ports detected
Dec 30 08:05:52 localhost kernel: mice: PS/2 mouse device common for all mice
Dec 30 08:05:52 localhost kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Dec 30 08:05:52 localhost kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Dec 30 08:05:52 localhost kernel: input: PS/2 Generic Mouse on isa0060/serio4
Dec 30 08:05:52 localhost kernel: Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Dec 30 08:05:52 localhost kernel: ALSA sound/pci/ac97/ac97_codec.c:2501: ac97 quirk for Fujitsu-Siemens E4010 (10cf:11c3)
Dec 30 08:05:52 localhost kernel: intel8x0_measure_ac97_clock: measured 49213 usecs
Dec 30 08:05:52 localhost kernel: intel8x0: clocking to 48000
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: PCI: Setting latency timer of device 0000:00:1f.6 to 64
Dec 30 08:05:52 localhost kernel: ALSA device list:
Dec 30 08:05:52 localhost kernel:   #0: Intel 82801DB-ICH4 with STAC9766/67 at 0xd0100c00, irq 11
Dec 30 08:05:52 localhost kernel:   #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 11
Dec 30 08:05:52 localhost kernel: NET: Registered protocol family 2
Dec 30 08:05:52 localhost kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Dec 30 08:05:52 localhost kernel: TCP: Hash tables configured (established 16384 bind 32768)
Dec 30 08:05:52 localhost kernel: NET: Registered protocol family 1
Dec 30 08:05:52 localhost kernel: IrCOMM protocol (Dag Brattli)
Dec 30 08:05:52 localhost kernel: Software Suspend Core.
Dec 30 08:05:52 localhost kernel: Software Suspend text mode support loaded.
Dec 30 08:05:52 localhost kernel: Software Suspend LZF Compression Driver registered.
Dec 30 08:05:52 localhost kernel: Software Suspend Swap Writer registered.
Dec 30 08:05:52 localhost kernel: ACPI wakeup devices:
Dec 30 08:05:52 localhost kernel: UAR1  HUB A97M  LID
Dec 30 08:05:52 localhost kernel: ACPI: (supports S0 S3 S4 S5)
Dec 30 08:05:52 localhost kernel: Software Suspend 2.1.5.10: You need to use a resume2= command line parameter to tell Software Suspend 2 where to look for an image.
Dec 30 08:05:52 localhost kernel: Software Suspend 2.1.5.10: Missing or invalid storage location (resume2= parameter). Please correct and rerun lilo (or equivalent) before suspending.
Dec 30 08:05:52 localhost kernel: ReiserFS: hda1: found reiserfs format "3.6" with standard journal
Dec 30 08:05:52 localhost kernel: ReiserFS: hda1: using ordered data mode
Dec 30 08:05:52 localhost kernel: ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Dec 30 08:05:52 localhost kernel: ReiserFS: hda1: checking transaction log (hda1)
Dec 30 08:05:52 localhost kernel: ReiserFS: hda1: Using r5 hash to sort names
Dec 30 08:05:52 localhost kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Dec 30 08:05:52 localhost kernel: Freeing unused kernel memory: 148k freed
Dec 30 08:05:52 localhost kernel: Adding 1020116k swap on /dev/hda4.  Priority:-1 extents:1
Dec 30 08:05:52 localhost kernel: loop: loaded (max 8 devices)
Dec 30 08:05:52 localhost kernel: input: PC Speaker
Dec 30 08:05:52 localhost kernel: parport_pc: Ignoring new-style parameters in presence of obsolete ones
Dec 30 08:05:52 localhost kernel: parport: PnPBIOS parport detected.
Dec 30 08:05:52 localhost kernel: parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
Dec 30 08:05:52 localhost kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 30 08:05:52 localhost kernel: agpgart: Detected an Intel 855 Chipset.
Dec 30 08:05:52 localhost kernel: agpgart: Maximum main memory to use for agp memory: 195M
Dec 30 08:05:52 localhost kernel: agpgart: Detected 8060K stolen memory.
Dec 30 08:05:52 localhost kernel: agpgart: AGP aperture is 128M @ 0xd8000000
Dec 30 08:05:52 localhost kernel: hw_random hardware driver 1.0.0 loaded
Dec 30 08:05:52 localhost kernel: 8139too Fast Ethernet driver 0.9.27
Dec 30 08:05:52 localhost kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: eth0: RealTek RTL8139 at 0xd006a000, 00:0b:5d:06:94:1c, IRQ 11
Dec 30 08:05:52 localhost kernel: eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Dec 30 08:05:52 localhost kernel: ieee80211_crypt: registered algorithm 'NULL'
Dec 30 08:05:52 localhost kernel: ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.2
Dec 30 08:05:52 localhost kernel: ipw2100: Copyright(c) 2003-2004 Intel Corporation
Dec 30 08:05:52 localhost kernel: ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
Dec 30 08:05:52 localhost kernel: ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
Dec 30 08:05:52 localhost kernel: wlan0: Radio is disabled by RF switch.
Dec 30 08:05:52 localhost kernel: usbcore: registered new driver hiddev
Dec 30 08:05:52 localhost kernel: input: USB HID v1.10 Mouse [A4Tech USB Optical Mouse] on usb-0000:00:1d.1-1
Dec 30 08:05:52 localhost kernel: usbcore: registered new driver usbhid
Dec 30 08:05:52 localhost kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Dec 30 08:05:52 localhost kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Dec 30 08:05:52 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec 30 08:05:52 localhost kernel: ip_conntrack version 2.1 (1975 buckets, 15800 max) - 304 bytes per conntrack
Dec 30 08:05:52 localhost kernel: ACPI: Battery Slot [CMB1] (battery present)
Dec 30 08:05:52 localhost kernel: ACPI: Battery Slot [CMB2] (battery absent)
Dec 30 08:05:52 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Dec 30 08:05:52 localhost kernel: ACPI: Processor [CPU0] (supports C1 C2 C3)
Dec 30 08:05:52 localhost kernel: ACPI: Power Button (FF) [PWRF]
Dec 30 08:05:52 localhost kernel: ACPI: Lid Switch [LID]
Dec 30 08:05:57 localhost kernel: lp0: using parport0 (interrupt-driven).
Dec 30 08:32:46 localhost kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Dec 30 08:33:27 localhost kernel: cdrom: This disc doesn't have any tracks I recognize!
Dec 30 08:33:27 localhost kernel: Badness in __put_task_struct at kernel/fork.c:91
Dec 30 08:33:27 localhost kernel:  [__put_task_struct+36/163] __put_task_struct+0x24/0xa3
Dec 30 08:33:27 localhost kernel:  [schedule+1041/1108] schedule+0x411/0x454
Dec 30 08:33:27 localhost kernel:  [wait_for_completion+128/195] wait_for_completion+0x80/0xc3
Dec 30 08:33:27 localhost kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Dec 30 08:33:27 localhost kernel:  [__wake_up+30/64] __wake_up+0x1e/0x40
Dec 30 08:33:27 localhost kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Dec 30 08:33:27 localhost kernel:  [kthread_create+169/221] kthread_create+0xa9/0xdd
Dec 30 08:33:27 localhost kernel:  [keventd_create_kthread+0/57] keventd_create_kthread+0x0/0x39
Dec 30 08:33:27 localhost kernel:  [pg0+268747723/1069315072] kcdrwd+0x0/0x1b9 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268753608/1069315072] pkt_new_dev+0xf6/0x1de [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268747723/1069315072] kcdrwd+0x0/0x1b9 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [blk_alloc_queue+15/81] blk_alloc_queue+0xf/0x51
Dec 30 08:33:27 localhost kernel:  [pg0+268754323/1069315072] pkt_setup_dev+0x13a/0x1a4 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [pg0+268754935/1069315072] pkt_ctl_ioctl+0x75/0xf5 [pktcdvd]
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [sys_ioctl+460/489] sys_ioctl+0x1cc/0x1e9
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel:  [reiserfs_allocate_blocks_for_region+1139/4123] reiserfs_allocate_blocks_for_region+0x473/0x101b
Dec 30 08:33:27 localhost kernel: pktcdvd: writer pktcdvd0 mapped to hdc
Dec 30 08:38:40 localhost kernel: Unable to handle kernel paging request at virtual address 00100100
Dec 30 08:38:40 localhost kernel:  printing eip:
Dec 30 08:38:40 localhost kernel: c0121653
Dec 30 08:38:40 localhost kernel: *pde = 00000000
Dec 30 08:38:40 localhost kernel: Oops: 0000 [#1]
Dec 30 08:38:40 localhost kernel: PREEMPT
Dec 30 08:38:40 localhost kernel: Modules linked in: pktcdvd lp binfmt_misc button processor ac battery ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables usbhid ipw2100 ieee80211 ieee80211_crypt 8139too mii hw_random intel_agp agpgart parport_pc parport pcspkr cryptoloop loop
Dec 30 08:38:40 localhost kernel: CPU:    0
Dec 30 08:38:40 localhost kernel: EIP:    0060:[find_pid+36/60]    Not tainted VLI
Dec 30 08:38:40 localhost kernel: EFLAGS: 00010006   (2.6.10)
Dec 30 08:38:40 localhost kernel: EIP is at find_pid+0x24/0x3c
Dec 30 08:38:40 localhost kernel: eax: ce8cc118   ebx: 00001e91   ecx: 00100100   edx: 00100100
Dec 30 08:38:40 localhost kernel: esi: 00000000   edi: ce8cca20   ebp: ce8ccad8   esp: cebf5f1c
Dec 30 08:38:40 localhost kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 08:38:40 localhost kernel: Process automount (pid: 6031, threadinfo=cebf4000 task=cefea600)
Dec 30 08:38:40 localhost kernel: Stack: ce8cca20 c012168a 00001e91 ce8cca20 cedb42a8 b7fd88c8 cebf4000 c01141bf
Dec 30 08:38:40 localhost kernel:        cebf5fc4 bffff868 01200011 c0159041 cd9fb474 00000000 00000004 cebf5fc4
Dec 30 08:38:40 localhost kernel:        01200011 00000000 00001e91 c0114470 00000000 00000000 b7fd88c8 00001e91
Dec 30 08:38:40 localhost kernel: Call Trace:
Dec 30 08:38:40 localhost kernel:  [attach_pid+31/163] attach_pid+0x1f/0xa3
Dec 30 08:38:40 localhost kernel:  [copy_process+2147/2582] copy_process+0x863/0xa16
Dec 30 08:38:40 localhost kernel:  [pipe_readv+558/570] pipe_readv+0x22e/0x23a
Dec 30 08:38:40 localhost kernel:  [do_fork+162/372] do_fork+0xa2/0x174
Dec 30 08:38:40 localhost kernel:  [copy_to_user+39/47] copy_to_user+0x27/0x2f
Dec 30 08:38:40 localhost kernel:  [sys_clone+34/38] sys_clone+0x22/0x26
Dec 30 08:38:40 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 30 08:38:40 localhost kernel: Code: 5a 59 5b 5e 5f 5d c3 53 b9 20 00 00 00 8b 04 85 20 b3 40 c0 2b 0d 30 b3 40 c0 89 d3 69 d2 01 00 37 9e d3 ea 8b 0c 90 85 c9 74 14 <8b> 11 0f 18 02 90 39 59 fc 8d 41 fc 74 08 85 d2 89 d1 75 ec 31
Dec 30 08:38:40 localhost kernel:  <6>note: automount[6031] exited with preempt_count 1


--- .config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10
# Tue Dec 28 23:14:28 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

#
# NeTraverse Win4Lin Support
#
# CONFIG_MKI is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# Software Suspend 2
#
CONFIG_SOFTWARE_SUSPEND2=y
CONFIG_SOFTWARE_SUSPEND2_BUILTIN=y
CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=y

#
# Page Transformers
#
CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION=y

#
# User Interface Options
#
CONFIG_SOFTWARE_SUSPEND_TEXT_MODE=y

#
# General Options
#
CONFIG_SOFTWARE_SUSPEND_DEFAULT_RESUME2=""
# CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE is not set

#
# Debugging
#
CONFIG_SOFTWARE_SUSPEND_DEBUG=y
# CONFIG_SOFTWARE_SUSPEND_CHECKSUMS is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_DEBUG is not set
# CONFIG_CPU_FREQ_PROC_INTF is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CONCAT=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PNC2000 is not set
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_ELAN_104NC is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_DILNETPC is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLKMTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOC2001PLUS=m
CONFIG_MTD_DOCPROBE=m
CONFIG_MTD_DOCECC=m
CONFIG_MTD_DOCPROBE_ADVANCED=y
CONFIG_MTD_DOCPROBE_ADDRESS=0x0000
CONFIG_MTD_DOCPROBE_HIGH=y
# CONFIG_MTD_DOCPROBE_55AA is not set

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_VERIFY_WRITE=y
CONFIG_MTD_NAND_IDS=m
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
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
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=y
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=m
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
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
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IEEE80211=m
CONFIG_IEEE80211_CRYPT=m
CONFIG_IEEE80211_WPA=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IPW2100=m
CONFIG_IPW_DEBUG=y
CONFIG_IPW2100_PROMISC=y
# CONFIG_IPW2100_LEGACY_FW_LOAD is not set
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I8XX_TCO=m
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=m
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
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y
CONFIG_USB_KC2190=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_TEST=m

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_SA1100 is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_OMAP is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
CONFIG_USB_FILE_STORAGE_TEST=y
CONFIG_USB_G_SERIAL=m

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
# CONFIG_MMC_WBSD is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
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
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZF=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y



-mat

-- 
Pozdrowienia,Regards,Cheers,Grüße,A plus!,
