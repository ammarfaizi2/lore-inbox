Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbQKKBJT>; Fri, 10 Nov 2000 20:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132165AbQKKBI7>; Fri, 10 Nov 2000 20:08:59 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:24843 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S132038AbQKKBI4>;
	Fri, 10 Nov 2000 20:08:56 -0500
Date: Sat, 11 Nov 2000 02:08:39 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: Jan Harkes <jaharkes@cs.cmu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre2
Message-ID: <20001111020839.A29815@burza.icm.edu.pl>
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com> <20001110202747.A16806@burza.icm.edu.pl> <20001110150652.F27422@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
In-Reply-To: <20001110150652.F27422@cs.cmu.edu>; from jaharkes@cs.cmu.edu on Fri, Nov 10, 2000 at 03:06:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 03:06:52PM -0500, Jan Harkes wrote:
> On Fri, Nov 10, 2000 at 08:27:47PM +0100, Rafal Maszkowski wrote:
> > On Thu, Nov 09, 2000 at 05:52:29PM -0800, Linus Torvalds wrote:
> > >  - pre2:
> > >     - David Miller: sparc64 updates, make sparc32 boot again
> > Thanks for working on it but I am getting still:
[...]
> > SPARCstation 10, 1 CPU, Fore 200e SBA, 64 MB RAM
> > gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> > Linux etest.icm.edu.pl 2.2.17 #1 Fri Oct 27 03:43:05 MEST 2000 sparc unknown
> > I wonder if it could be my fault - could anybody testify that he was able to
> > boot any 2.4.0 on Sparc32?
> Yup, SparcStation IPC, 48MB
> What you are not seeing is probably the BUG() at bootmem.c:219. I can
> almost bet it is related to the `holes' in your memory map,
> > free_bootmem: base[0] size[1000000]
> hole from 1000000 to 3fffffff
> > free_bootmem: base[4000000] size[1000000]
> hole from 5000000 to 7fffffff
> > free_bootmem: base[8000000] size[1000000]

I see... Is kernel v. 2.2 smarter in respect to holes? Various 2.2s boot with
all 64 MB without problems.

> arch/sparc/kernel/setup.c:48
> - #undef PROM_DEBUG_CONSOLE
> + #define PROM_DEBUG_CONSOLE 1

Done. But I got an idea to use mem=16mb and, yes, now it goes much farther -
but stops on serial ports:

boot: 11.2 mem=16mb
Uncompressing image...
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.4.0-test11 (root@etest.icm.edu.pl) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Fri Nov 10
21:33:12 MET 2000
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:71:7b:ba
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for srmmu[TI Viking/MXCC]/iommu
bootmem_init: Scan sp_banks,  init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[1000])
free_bootmem: base[0] size[1000000]
reserve_bootmem: base[0] size[1f5000]
reserve_bootmem: base[1f5000] size[200]
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Booting Linux...
Found CPU 0 <node=ffd66140,mid=8>
Found 1 CPU prom device tree node(s).
Power off control detected.
Kernel command line: root=/dev/sda2 ro mem=16mb
Calibrating delay loop... 49.87 BogoMIPS
mem_init: Calling free_all_bootmem().
Memory: 12040k available (1340k kernel code, 304k data, 116k init, 0k highmem) [f0000000,01000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
IOMMU: impl 0 vers 3 page table at f04c0000 of size 262144 bytes
sbus0: Clock 20.0 MHz
dma0: Revision 2
dma1: Revision 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
ioremap: done with statics, switching to malloc
FDC 0 is a post-1991 82077
sunlance.c:v2.00 11/Sep/99 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:71:7b:ba
eth0: using auto-carrier-detection.
SCSI subsystem driver Revision: 1.00
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST31200N SUN1.05  Rev: 8722
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 2061108 512-byte hdwr sectors (1055 MB)
Partition check:
 sda: sda1 sda2
Sparc Zilog8530 serial driver version 1.60
[freezes completely here, will have to visit it tomorrow]


I will try to analize tomorrow the crash I am getting without mem limit:

[...]
bootmem_init: Scan sp_banks,  15MB HIGHMEM available.
init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[c000])
free_bootmem: base[0] size[1000000]
free_bootmem: base[4000000] size[1000000]
free_bootmem: base[8000000] size[1000000]
reserve_bootmem: base[0] size[1f5000]
reserve_bootmem: base[1f5000] size[1800]
On node 0 totalpages: 53075
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 3923 pages.
Booting Linux...
Found CPU 0 <node=ffd66140,mid=8>
Found 1 CPU prom device tree node(s).
Unable to handle kernel paging request at virtual address fd000000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops
PSR: 40801fc2 PC: f01a77ac NPC: f01a77b0 Y: 01c00000
g0: f000e000 g1: 00000400 g2: fe2fffff g3: f018bc74 g4: 00000000 g5: 00000000 g6: f000e000 g7: 00007fff
o0: 00000002 o1: fd000000 o2: fd000000 o3: f0155b38 o4: f1800000 o5: f018c8d4 sp: f000fcf8 o7: f01a7760
l0: f01db400 l1: f01dd400 l2: f018c400 l3: 00000000 l4: f018c800 l5: 00000000 l6: 0ffffc00 l7: 04000000
i0: 00000026 i1: 00000000 i2: f01c431a i3: 00000025 i4: 00000001 i5: f01c42f3 fp: f000fd90 i7: f01a74c8
Caller[f01a74c8]
Caller[f01a7cdc]
Caller[f01a67c4]
Caller[f01a4f94]
Caller[f01a4790]
Caller[00000000]
Instruction DUMP: 80a26000  02800005  01000000 <d00a4000> 901220f1  d02a4000  81c7e008  81e80000  9de3bf68
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
Press L1-A to return to the boot prom
IO device interrupt, irq = 10
PC = f002d9d0 NPC = f002d9d4 FP=f000f9d8
AIEEE
Kernel panic: bogus interrupt received
In interrupt handler - not syncing
[...]

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
