Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131882AbQK3JZo>; Thu, 30 Nov 2000 04:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131948AbQK3JZe>; Thu, 30 Nov 2000 04:25:34 -0500
Received: from gw2-int.ensim.com ([38.186.181.2]:22779 "EHLO
        nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
        id <S131882AbQK3JZW>; Thu, 30 Nov 2000 04:25:22 -0500
From: Borislav Deianov <borislav@ensim.com>
Date: Thu, 30 Nov 2000 00:54:51 -0800
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-test12-pre3] SCSI Oops
Message-ID: <20001130005451.E874@aero.ensim.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is on a Dell PowerEdge 6300. It has two Adaptec AIC-7890, one
Adaptec AIC-7860, and an AMI MegaRAID controller. There's nothing on
the 7890s, a CDROM and a tape drive on the 7890.

With all of the above enabled the kernel boots with no problems.
However, if I disable the two 7890s from the BIOS (to save 30 seconds
of boot time), I get an oops.

I'm attaching the decoded oops, the boot log from a successful boot
and my .config. Let me know if any other info is needed.

Many thanks,
Borislav


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.oops.decoded"

ksymoops 2.3.5 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m linux-2.4.0-test12-pre3/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000001
c0197b60
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0197b60>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 000000ff   ebx: f7dd4878   ecx: 00000000   edx: f7dd2000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c2139bc8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c2139000)
Stack: ff789004 f7dd4878 f7dd2000 f7dd4878 f7dd4a34 c0199228 f7dd4878 f7dd2000
       00000000 00000000 ffffffff 000000ff 00dd4984 f7de4200 f7dd4878 00000000
       c01abb91 00000000 ff000002 f7de4000 00804001 00000101 00000007 f7dd4878
Call Trace: [<ff789004>] [<c0199228>] [<c01abb91>] [<ff000002>] [<c01ac1bc>] [<c01ac448>] [<c01ac6cd>] [<c018c37e>] [<c0191350>] [<c0192c43>] [<c0192930>] [<c019210a>] [<c018c45e>] [<c018beb0>] [<c01959e6>] [<c012cc89>] [<c016f21e>] [<c016f18d>] [<c016f227>] [<c019582a>] [<c0244c20>] [<c0244c20>] [<c0122930>] [<c0112a60>] [<c02039ec>] [<c011b8a5>] [<c018d443>] [<c014f92f>] [<c022602e>] [<c014fdc1>] [<c0226029>] [<c0107000>] [<c0107000>] [<c0107028>] [<c0107000>] [<c010930b>]
Code: 0f b6 57 01 88 d0 c0 e8 04 0f b6 d8 88 d0 c0 e8 03 83 e0 01              

>>EIP; c0197b60 <aic7xxx_match_scb+20/a0>   <=====
Trace; ff789004 <END_OF_CODE+6ef080b/????>
Trace; c0199228 <aic7xxx_search_qinfifo+a8/3c0>
Trace; c01abb91 <aic7xxx_allocate_negotiation_command+41/140>
Trace; ff000002 <END_OF_CODE+6767809/????>
Trace; c01ac1bc <aic7xxx_build_negotiation_cmnd+cc/1e0>
Trace; c01ac448 <aic7xxx_buildscb+178/340>
Trace; c01ac6cd <aic7xxx_queue+bd/140>
Trace; c018c37e <scsi_dispatch_cmd+13e/1a0>
Trace; c0191350 <scsi_old_done+0/630>
Trace; c0192c43 <scsi_request_fn+313/370>
Trace; c0192930 <scsi_request_fn+0/370>
Trace; c019210a <scsi_insert_special_req+7a/90>
Trace; c018c45e <scsi_wait_req+7e/c0>
Trace; c018beb0 <scsi_wait_done+0/30>
Trace; c01959e6 <scan_scsis_single+b6/520>
Trace; c012cc89 <kmem_cache_alloc+39/a0>
Trace; c016f21e <blk_init_queue+3e/90>
Trace; c016f18d <blk_init_free_list+1d/70>
Trace; c016f227 <blk_init_queue+47/90>
Trace; c019582a <scan_scsis+2ea/3f0>
Trace; c0244c20 <timer_bug_msg+7f80/8280>
Trace; c0244c20 <timer_bug_msg+7f80/8280>
Trace; c0122930 <update_process_times+20/a0>
Trace; c0112a60 <smp_apic_timer_interrupt+f0/110>
Trace; c02039ec <call_apic_timer_interrupt+5/d>
Trace; c011b8a5 <printk+185/1a0>
Trace; c018d443 <scsi_register_host+1d3/2f0>
Trace; c014f92f <proc_register+f/90>
Trace; c022602e <scsi_device_types+44e/e10>
Trace; c014fdc1 <create_proc_entry+101/110>
Trace; c0226029 <scsi_device_types+449/e10>
Trace; c0107000 <init+0/180>
Trace; c0107000 <init+0/180>
Trace; c0107028 <init+28/180>
Trace; c0107000 <init+0/180>
Trace; c010930b <kernel_thread+2b/40>
Code;  c0197b60 <aic7xxx_match_scb+20/a0>
00000000 <_EIP>:
Code;  c0197b60 <aic7xxx_match_scb+20/a0>   <=====
   0:   0f b6 57 01               movzbl 0x1(%edi),%edx   <=====
Code;  c0197b64 <aic7xxx_match_scb+24/a0>
   4:   88 d0                     mov    %dl,%al
Code;  c0197b66 <aic7xxx_match_scb+26/a0>
   6:   c0 e8 04                  shr    $0x4,%al
Code;  c0197b69 <aic7xxx_match_scb+29/a0>
   9:   0f b6 d8                  movzbl %al,%ebx
Code;  c0197b6c <aic7xxx_match_scb+2c/a0>
   c:   88 d0                     mov    %dl,%al
Code;  c0197b6e <aic7xxx_match_scb+2e/a0>
   e:   c0 e8 03                  shr    $0x3,%al
Code;  c0197b71 <aic7xxx_match_scb+31/a0>
  11:   83 e0 01                  and    $0x1,%eax


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

, pol 0, trig 0, bus 5, IRQ 04, APIC ID 4, APIC INT 13
Int: type 0, pol 0, trig 0, bus 5, IRQ 0d, APIC ID 4, APIC INT 13
Int: type 0, pol 0, trig 0, bus 5, IRQ 16, APIC ID 4, APIC INT 13
Int: type 0, pol 0, trig 0, bus 5, IRQ 1f, APIC ID 4, APIC INT 13
Int: type 0, pol 0, trig 0, bus 0, IRQ 19, APIC ID 4, APIC INT 14
Int: type 0, pol 0, trig 0, bus 1, IRQ 14, APIC ID 4, APIC INT 14
Int: type 0, pol 0, trig 0, bus 0, IRQ 22, APIC ID 4, APIC INT 14
Int: type 0, pol 0, trig 0, bus 0, IRQ 2b, APIC ID 4, APIC INT 14
Int: type 0, pol 0, trig 0, bus 4, IRQ 20, APIC ID 4, APIC INT 14
Int: type 0, pol 0, trig 0, bus 4, IRQ 10, APIC ID 4, APIC INT 15
Int: type 0, pol 0, trig 0, bus 4, IRQ 18, APIC ID 4, APIC INT 16
Int: type 0, pol 0, trig 0, bus 0, IRQ 1a, APIC ID 4, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 23, APIC ID 4, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 3, IRQ 10, APIC ID 4, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 28, APIC ID 4, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 1b, APIC ID 4, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 20, APIC ID 4, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 29, APIC ID 4, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 3, IRQ 14, APIC ID 4, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 18, APIC ID 4, APIC INT 05
Int: type 0, pol 0, trig 0, bus 1, IRQ 10, APIC ID 4, APIC INT 05
Int: type 0, pol 0, trig 0, bus 0, IRQ 21, APIC ID 4, APIC INT 05
Int: type 0, pol 0, trig 0, bus 0, IRQ 2a, APIC ID 4, APIC INT 05
Lint: type 3, pol 1, trig 1, bus 6, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 6, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 4
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=new ro root=806 BOOT_FILE=/boot/vmlinuz-2.4.0-test12 console=ttyS0,38400 console=tty0
Initializing CPU#0
Detected 549.985 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1097.73 BogoMIPS
Memory: 1028812k/1048568k available (1324k kernel code, 19372k reserved, 86k data, 184k init, 131064k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1465.22 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
CPU present map: f
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Initializing CPU#1
Waiting for send to finish...
CPU#1 (phys ID: 0) waiting for CALLOUT
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.73 BogoMIPS
Stack at about c2119fb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Booting processor 2/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Initializing CPU#2
Waiting for send to finish...
CPU#2 (phys ID: 1) waiting for CALLOUT
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 2.
After Callout 2.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.73 BogoMIPS
Stack at about c213dfb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#2.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU2: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Booting processor 3/2 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Initializing CPU#3
Waiting for send to finish...
CPU#3 (phys ID: 2) waiting for CALLOUT
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 3.
After Callout 3.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.73 BogoMIPS
Stack at about c213bfb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#3.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU3: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Before bogomips.
Total of 4 processors activated (4390.91 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 4 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-10, 4-13, 4-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 46.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  1    1    0   1   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 00F 0F  1    1    0   1   0    1    1    79
 0c 00F 0F  0    0    0   0   0    1    1    81
 0d 000 00  1    0    0   0   0    0    0    00
 0e 00F 0F  1    1    0   1   0    1    1    89
 0f 00F 0F  0    0    0   0   0    1    1    91
 10 00F 0F  1    1    0   1   0    1    1    99
 11 00F 0F  1    1    0   1   0    1    1    A1
 12 00F 0F  1    1    0   1   0    1    1    A9
 13 00F 0F  1    1    0   1   0    1    1    B1
 14 00F 0F  1    1    0   1   0    1    1    B9
 15 00F 0F  1    1    0   1   0    1    1    C1
 16 00F 0F  1    1    0   1   0    1    1    C9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ11 -> 11
IRQ12 -> 12
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
IRQ20 -> 20
IRQ21 -> 21
IRQ22 -> 22
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 549.9848 MHz.
..... host bus clock speed is 99.9971 MHz.
cpu: 0, clocks: 999971, slice: 199994
CPU0<T0:999968,T1:799968,D:6,S:199994,C:999971>
cpu: 1, clocks: 999971, slice: 199994
cpu: 2, clocks: 999971, slice: 199994
cpu: 3, clocks: 999971, slice: 199994
CPU1<T0:999968,T1:599968,D:12,S:199994,C:999971>
CPU2<T0:999968,T1:399984,D:2,S:199994,C:999971>
CPU3<T0:999968,T1:199984,D:8,S:199994,C:999971>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfcc5e, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Searching for i450NX host bridges on 00:10.0
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 14
PCI->APIC IRQ transform: (B4,I4,P0) -> 21
PCI->APIC IRQ transform: (B4,I6,P0) -> 22
PCI->APIC IRQ transform: (B4,I8,P0) -> 20
PCI->APIC IRQ transform: (B1,I4,P0) -> 5
PCI->APIC IRQ transform: (B1,I5,P0) -> 20
PCI->APIC IRQ transform: (B3,I4,P0) -> 11
PCI->APIC IRQ transform: (B3,I5,P0) -> 14
  got res[1000:100f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
  got res[1020:103f] for resource 4 of Intel Corporation 82371AB PIIX4 USB
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:E3:26:27, IRQ 5.
  Board assembly 751110-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth1: OEM i82557/i82558 10/100 Ethernet, 00:90:27:E3:26:28, IRQ 20.
  Board assembly 751110-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth2: OEM i82557/i82558 10/100 Ethernet, 00:90:27:E3:3F:3B, IRQ 11.
  Board assembly 751110-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth3: OEM i82557/i82558 10/100 Ethernet, 00:90:27:E3:3F:3C, IRQ 14.
  Board assembly 751110-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7890/1 Ultra2 SCSI host adapter> found at PCI 4/4/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7890/1 Ultra2 SCSI host adapter> found at PCI 4/6/0
(scsi1) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
(scsi2) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 4/8/0
(scsi2) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi2) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7890/1 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7890/1 Ultra2 SCSI host adapter>
scsi2 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7860 Ultra SCSI host adapter>
(scsi2:0:5:0) Synchronous at 20.0 Mbyte/sec, offset 15.
  Vendor: NEC       Model: CD-ROM DRIVE:466  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi2:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SONY      Model: SDT-9000          Rev: 0400
  Type:   Sequential-Access                  ANSI SCSI revision: 02
megaraid: v107 (December 22, 1999)
megaraid: found 0x8086:0x1960: in 00:08.1
scsi3 : Found a MegaRAID controller at 0xf880e000, IRQ: 14
megaraid: [3.13:1.43] detected 1 logical drives
scsi3 : AMI MegaRAID 3.13 254 commands 16 targs 1 chans 8 luns
scsi3: scanning channel 1 for devices.
  Vendor: DELL      Model: 1x6 U2W SCSI BP   Rev: 5.23
  Type:   Processor                          ANSI SCSI revision: 02
scsi3: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 25704R  Rev: 3.13
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi3, channel 1, id 0, lun 0
SCSI device sda: 52641792 512-byte hdwr sectors (26953 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 1052216k swap-space (priority -1)
Detected scsi tape st0 at scsi2, channel 0, id 6, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wispa4-2.4.0-test12"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
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
# CONFIG_MODVERSIONS is not set
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
CONFIG_M686FXSR=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_FXSR=y
CONFIG_X86_XMM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
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
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
# CONFIG_AIC7XXX_PROC_STATS is not set
CONFIG_AIC7XXX_RESET_DELAY=5
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_MEGARAID=y
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
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
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
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

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
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

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
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

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
# CONFIG_INPUT is not set

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

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
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
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

--cvVnyQ+4j833TQvp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
