Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130736AbQKCWFT>; Fri, 3 Nov 2000 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130771AbQKCWFJ>; Fri, 3 Nov 2000 17:05:09 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:42512 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S130736AbQKCWE6>; Fri, 3 Nov 2000 17:04:58 -0500
Message-ID: <3A0332E2.9D602A81@dm.ultramaster.com>
Date: Fri, 03 Nov 2000 16:49:22 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: blk-8 oopses at boot (was: blk-7 fails to boot)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 03 2000, David Mansfield wrote:
> > Hi Jens.
> >
> > I've tried your blk-8 patch and it oopses during boot.  I only hand
> > copied the stack trace, and ran it through ksymoops:
> >
 >
> > I'm going to try taking MSDOS out of my .config to try to work around
> > this.  I'll keep you posted as to my progress.
>
> Thanks, I think this is a generic msdos problem though. If it still
> oopses without blk-8, could you send the complete oops please?

Actually, it has nothing to do with MSDOS fs, per-se.  I misread the
trace. In fact, it's just an MSDOS style *partition table*, i.e. normal
Linux on a PC partition table.

I have here the bootup messages of 2.4.0-test10 + blk-8, along with a
ksymoops of the oops, and a gdb disassemble of __wait_on_buffer:

Linux version 2.4.0-test10 (kernel@mercury) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #18 Fri Nov 3 11:01:28 EST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=812 mem=256m
console=ttyS0,115200n8
Initializing CPU#0
Detected 698.665 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1392.64 BogoMIPS
Memory: 255508k/262144k available (1360k kernel code, 6248k reserved,
99k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: L1 I Cache: 64K  L1 D Cache: 64K (64 bytes/line)
CPU: L2 Cache: 512K
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.36 (20000221) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
ACPI: "AWARD" found at 0x000f6340
ACPI: unreserved table memory @ 0x0fff3000!
ACPI: missing RSDT at 0x0fff3000
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: CREATIVE CD5230E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
LVM version 0.8final  by Heinz Mauelshagen  (15/02/2000)
lvm -- Driver successfully initialized
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 0/11/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST39102LW         Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: IBM       Model: DNES-318350W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
Partition check:
 sda:<1>Unable to handle kernel NULL pointer dereference at virtual
address 00000010
 printing eip:
00000010
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000010>]
EFLAGS: 00010202
eax: c15da9e4   ebx: c023c7ea   ecx: c1591800   edx: 00000010
esi: c1582240   edi: c15fe000   ebp: c15ffe70   esp: c15ffe50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c15ff000)
Stack: c01310e0 c1591800 00000800 00000000 00000800 c15da980 c1591800
c1582288 
       01234567 c15fe000 c158228c c158228c c0131f55 c1582240 c1582240
c014c88e 
       00000800 00000000 00000400 00000800 c0259b04 00000000 00000800
c15da980 
Call Trace: [<c01310e0>] [<c0131f55>] [<c014c88e>] [<c014c3dc>]
[<c01b9cea>] [<c014c4ea>] [<c014c456>] 
       [<c01ba3a4>] [<c018c7ab>] [<c0105000>] [<c018c8ae>] [<c01070e7>]
[<c0108ce3>] 
Code:  Bad EIP value.
Kernel panic: Attempted to kill init!


And here's the ksymoops:

>>EIP; 00000010 Before first symbol   <=====
Trace; c01310e0 <__wait_on_buffer+90/c0>
Trace; c0131f55 <bread+45/70>
Trace; c014c88e <msdos_partition+8e/3f0>
Trace; c014c3dc <check_partition+8c/d0>
Trace; c01b9cea <sd_init_onedisk+75a/770>
Trace; c014c4ea <grok_partitions+8a/d0>
Trace; c014c456 <register_disk+26/30>
Trace; c01ba3a4 <sd_finish+134/1c0>
Trace; c018c7ab <scsi_register_device_module+eb/110>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c018c8ae <scsi_register_module+4e/60>
Trace; c01070e7 <init+7/150>
Trace; c0108ce3 <kernel_thread+23/30>

And here's a 'disassemble' of __wait_on_buffer from gdb:


(gdb) disassemble __wait_on_buffer
Dump of assembler code for function __wait_on_buffer:
0xc0131050 <__wait_on_buffer>:	sub    $0x18,%esp
0xc0131053 <__wait_on_buffer+3>:	push   %ebp
0xc0131054 <__wait_on_buffer+4>:	push   %edi
0xc0131055 <__wait_on_buffer+5>:	push   %esi
0xc0131056 <__wait_on_buffer+6>:	mov    $0xffffe000,%edi
0xc013105b <__wait_on_buffer+11>:	push   %ebx
0xc013105c <__wait_on_buffer+12>:	and    %esp,%edi
0xc013105e <__wait_on_buffer+14>:	mov    0x2c(%esp,1),%esi
0xc0131062 <__wait_on_buffer+18>:	movl   $0x1234567,0x18(%esp,1)
0xc013106a <__wait_on_buffer+26>:	mov    %edi,0x1c(%esp,1)
0xc013106e <__wait_on_buffer+30>:	movl   $0x0,0x20(%esp,1)
0xc0131076 <__wait_on_buffer+38>:	movl   $0x0,0x24(%esp,1)
0xc013107e <__wait_on_buffer+46>:	incl   0x10(%esi)
0xc0131081 <__wait_on_buffer+49>:	lea    0x18(%esp,1),%ebp
0xc0131085 <__wait_on_buffer+53>:	lea    0x48(%esi),%ecx
0xc0131088 <__wait_on_buffer+56>:	mov    %ecx,0x14(%esp,1)
0xc013108c <__wait_on_buffer+60>:	mov    %ebp,%edx
0xc013108e <__wait_on_buffer+62>:	mov    %ecx,%eax
0xc0131090 <__wait_on_buffer+64>:	call   0xc0118440 <add_wait_queue>
0xc0131095 <__wait_on_buffer+69>:	jmp    0xc01310a2
<__wait_on_buffer+82>
0xc0131097 <__wait_on_buffer+71>:	call   0xc01172b0 <schedule>
0xc013109c <__wait_on_buffer+76>:	testb  $0x4,0x18(%esi)
0xc01310a0 <__wait_on_buffer+80>:	je     0xc01310f1
<__wait_on_buffer+161>
0xc01310a2 <__wait_on_buffer+82>:	cmpl   $0x0,0xc025ac20
0xc01310a9 <__wait_on_buffer+89>:	je     0xc01310e5
<__wait_on_buffer+149>
0xc01310ab <__wait_on_buffer+91>:	pushf  
0xc01310ac <__wait_on_buffer+92>:	pop    %eax
0xc01310ad <__wait_on_buffer+93>:	cli    
0xc01310ae <__wait_on_buffer+94>:	mov    0xc025ac20,%ebx
0xc01310b4 <__wait_on_buffer+100>:	movl   $0x0,0xc025ac20
0xc01310be <__wait_on_buffer+110>:	push   %eax
0xc01310bf <__wait_on_buffer+111>:	popf   
0xc01310c0 <__wait_on_buffer+112>:	test   %ebx,%ebx
0xc01310c2 <__wait_on_buffer+114>:	je     0xc01310e5
<__wait_on_buffer+149>
0xc01310c4 <__wait_on_buffer+116>:	mov    0xc(%ebx),%ecx
0xc01310c7 <__wait_on_buffer+119>:	mov    %ecx,0x10(%esp,1)
0xc01310cb <__wait_on_buffer+123>:	mov    0x8(%ebx),%edx
0xc01310ce <__wait_on_buffer+126>:	mov    %ebx,%eax
0xc01310d0 <__wait_on_buffer+128>:	mov    (%ebx),%ebx
0xc01310d2 <__wait_on_buffer+130>:	movl   $0x0,0x4(%eax)
0xc01310d9 <__wait_on_buffer+137>:	test   %edx,%edx
0xc01310db <__wait_on_buffer+139>:	je     0xc01310c0
<__wait_on_buffer+112>
0xc01310dd <__wait_on_buffer+141>:	push   %ecx
0xc01310de <__wait_on_buffer+142>:	call   *%edx
0xc01310e0 <__wait_on_buffer+144>:	add    $0x4,%esp
0xc01310e3 <__wait_on_buffer+147>:	jmp    0xc01310c0
<__wait_on_buffer+112>
0xc01310e5 <__wait_on_buffer+149>:	movl   $0x2,(%edi)
0xc01310eb <__wait_on_buffer+155>:	testb  $0x4,0x18(%esi)
0xc01310ef <__wait_on_buffer+159>:	jne    0xc0131097
<__wait_on_buffer+71>
0xc01310f1 <__wait_on_buffer+161>:	movl   $0x0,(%edi)
0xc01310f7 <__wait_on_buffer+167>:	mov    %ebp,%edx
0xc01310f9 <__wait_on_buffer+169>:	mov    0x14(%esp,1),%eax
0xc01310fd <__wait_on_buffer+173>:	call   0xc0118490 <remove_wait_queue>
0xc0131102 <__wait_on_buffer+178>:	decl   0x10(%esi)
0xc0131105 <__wait_on_buffer+181>:	pop    %ebx
0xc0131106 <__wait_on_buffer+182>:	pop    %esi
0xc0131107 <__wait_on_buffer+183>:	pop    %edi
0xc0131108 <__wait_on_buffer+184>:	pop    %ebp
0xc0131109 <__wait_on_buffer+185>:	add    $0x18,%esp
0xc013110c <__wait_on_buffer+188>:	ret    
0xc013110d <__wait_on_buffer+189>:	lea    0x0(%esi),%esi
End of assembler dump.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
