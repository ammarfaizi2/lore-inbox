Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTHCByY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTHCByY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:54:24 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:33271
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S270520AbTHCBxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:53:18 -0400
Date: Sat, 2 Aug 2003 21:55:10 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030803015510.GB4696@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20030801144455.450d8e52.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.6.0-test2-mm3
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2003 at 02:44:55PM -0700, Andrew Morton wrote:
> Diffie <diffie@blazebox.homeip.net> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00120
> > printing eip:
> > c02a8cae
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > CPU:    0
> > EIP:    0060:[<c02a8cae>]    Not tainted VLI
> > EFLAGS: 00210286
> > EIP is at aic7xxx_proc_info+0x2e/0xc80
> > eax: c1bb25b0   ebx: c1bb2400   ecx: c038bb20   edx: 00000000
> > esi: 00000400   edi: f1715000   ebp: 412de000   esp: f620fecc
> > ds: 007b   es: 007b   ss: 0068
> > Process nautilus (pid: 3555, threadinfo=3Df620e000 task=3Df6216720)
> > Stack: 000001f7 00000000 00000000 c013c612 c0379eb0 00000000 00000000 f=
6613340
> >        00000000 00000000 c0379eb0 00000400 00000400 f1715000 412de000 c=
02956fc
> >        c1bb2400 f1715000 f620ff60 00000000 00000400 00000000 c02956c0 c=
018bc91
> > Call Trace:
> > [<c013c612>] __alloc_pages+0x92/0x320
> > [<c02956fc>] proc_scsi_read+0x3c/0x60
> > [<c02956c0>] proc_scsi_read+0x0/0x60
>=20
> This patch should fix the oops.
>=20
> As for why the proc reading code was unable to locate the HBA: dunno, but
> this is a first step.
>=20
> Or maybe you don't have any adaptec controllers in the machine?
>=20
> (jejb, please apply..)
>=20
>=20
>  25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff -puN drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix dr=
ivers/scsi/aic7xxx_old/aic7xxx_proc.c
> --- 25/drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix	Fri A=
ug  1 14:41:14 2003
> +++ 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	Fri Aug  1 14:41:20 2=
003
> @@ -92,7 +92,7 @@ aic7xxx_proc_info ( struct Scsi_Host *HB
> =20
>    HBAptr =3D NULL;
> =20
> -  for(p=3Dfirst_aic7xxx; p->host !=3D HBAptr; p=3Dp->next)
> +  for(p=3Dfirst_aic7xxx; p && p->host !=3D HBAptr; p=3Dp->next)
>      ;
> =20
>    if (!p)
>=20
> _
>=20
>=20

Andrew,

After applaying the above patch and testing it still oopses the kernel.

I noticed same patch in today's mm3 which i compiled and use right now.

When using cat /proc/scsi/aic7xxx/0 i get segmentation fault and oops
which i'll attach to this email.

uname: Linux blaze 2.6.0-test2-mm3 #1 Sat Aug 2 20:12:35 EDT 2003 i686 unkn=
own

gcc version 3.2.2 on Slackware 9.0

I noticed this when the SCSI sybsystem is initialized upon boot:
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id=
 1 lun 0

Regards,

Paul B.


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aic7xxx-oops.txt"
Content-Transfer-Encoding: quoted-printable

invalid kernel-mode pagefault 0! [addr:0000004c, eip:022ab7a8]
=20
Pid: 4678, comm:                  cat
EIP: 0060:[<022ab7a8>] CPU: 0
EIP is at aic7xxx_proc_info+0xc28/0xc80
 EFLAGS: 00010246    Not tainted
EAX: 32cbb000 EBX: 00000400 ECX: 03b64400 EDX: 03b64400
ESI: 32cbb000 EDI: 00000400 EBP: 00000000 DS: 007b ES: 007b
CR0: 8005003b CR2: 0000004c CR3: 00101000 CR4: 000006d0
Call Trace:
 [<0213dbd2>] __alloc_pages+0x92/0x320
 [<0229767c>] proc_scsi_read+0x3c/0x60
 [<02297640>] proc_scsi_read+0x0/0x60
 [<0218d942>] proc_file_read+0xc2/0x250
 [<02157e1e>] vfs_read+0xbe/0x130
 [<021580f2>] sys_read+0x42/0x70
=20
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<0211a910>]    Not tainted VLI
EFLAGS: 00010006
EIP is at do_page_fault+0x70/0x48e
eax: 00000001   ebx: 00000400   ecx: 00000001   edx: 02379798
esi: 00000000   edi: 0211a8a0   ebp: 0000004c   esp: 2964fdf4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 4678, threadinfo=3D2964e000 task=3D37452d40)
Stack: 2964fea8 00000000 0000004c 022ab7a8 00001184 2964e000 00000000 00001=
184
       41fdee00 02173274 2d3c8390 03b10540 41fdee00 0218b3a7 2964fe30 3f2c6=
6b8
       02173c9f 2d3c8390 0218b6d3 2d3c8390 00001184 00000000 00000ffc 36485=
900
Call Trace:
 [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
 [<02173274>] iget_locked+0x94/0xc0
 [<0218b3a7>] proc_read_inode+0x17/0x40
 [<02173c9f>] wake_up_inode+0xf/0x30
 [<0218b6d3>] proc_get_inode+0x113/0x140
 [<02147428>] follow_page+0xc8/0x120
 [<02155274>] rw_vm+0x134/0x330
 [<0211a8a0>] do_page_fault+0x0/0x48e
 [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
 [<0213dbd2>] __alloc_pages+0x92/0x320
 [<0229767c>] proc_scsi_read+0x3c/0x60
 [<02297640>] proc_scsi_read+0x0/0x60
 [<0218d942>] proc_file_read+0xc2/0x250
 [<02157e1e>] vfs_read+0xbe/0x130
 [<021580f2>] sys_read+0x42/0x70
=20
Code:  Bad EIP value.

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-decode.txt"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.8 on i686 2.6.0-test2-mm3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2-mm3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Aug  2 21:34:48 blaze kernel: Pid: 4678, comm:                  cat
Aug  2 21:34:48 blaze kernel: EIP: 0060:[<022ab7a8>] CPU: 0
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  2 21:34:48 blaze kernel:  EFLAGS: 00010246    Not tainted
Aug  2 21:34:48 blaze kernel: EAX: 32cbb000 EBX: 00000400 ECX: 03b64400 EDX=
: 03b64400
Aug  2 21:34:48 blaze kernel: ESI: 32cbb000 EDI: 00000400 EBP: 00000000 DS:=
 007b ES: 007b
Warning (Oops_set_regs): garbage 'DS: 007b ES: 007b' at end of register lin=
e ignored
Aug  2 21:34:48 blaze kernel: CR0: 8005003b CR2: 0000004c CR3: 00101000 CR4=
: 000006d0
Aug  2 21:34:48 blaze kernel: Call Trace:
Aug  2 21:34:48 blaze kernel:  [<0213dbd2>] __alloc_pages+0x92/0x320
Aug  2 21:34:48 blaze kernel:  [<0229767c>] proc_scsi_read+0x3c/0x60
Aug  2 21:34:48 blaze kernel:  [<02297640>] proc_scsi_read+0x0/0x60
Aug  2 21:34:48 blaze kernel:  [<0218d942>] proc_file_read+0xc2/0x250
Aug  2 21:34:48 blaze kernel:  [<02157e1e>] vfs_read+0xbe/0x130
Aug  2 21:34:48 blaze kernel:  [<021580f2>] sys_read+0x42/0x70
Aug  2 21:34:48 blaze kernel: invalid operand: 0000 [#1]
Aug  2 21:34:48 blaze kernel: CPU:    0
Aug  2 21:34:48 blaze kernel: EIP:    0060:[<0211a910>]    Not tainted VLI
Aug  2 21:34:48 blaze kernel: EFLAGS: 00010006
Aug  2 21:34:48 blaze kernel: eax: 00000001   ebx: 00000400   ecx: 00000001=
   edx: 02379798
Aug  2 21:34:48 blaze kernel: esi: 00000000   edi: 0211a8a0   ebp: 0000004c=
   esp: 2964fdf4
Aug  2 21:34:48 blaze kernel: ds: 007b   es: 007b   ss: 0068
Aug  2 21:34:48 blaze kernel: Stack: 2964fea8 00000000 0000004c 022ab7a8 00=
001184 2964e000 00000000 00001184=20
Aug  2 21:34:48 blaze kernel:        41fdee00 02173274 2d3c8390 03b10540 41=
fdee00 0218b3a7 2964fe30 3f2c66b8=20
Aug  2 21:34:48 blaze kernel:        02173c9f 2d3c8390 0218b6d3 2d3c8390 00=
001184 00000000 00000ffc 36485900=20
Aug  2 21:34:48 blaze kernel: Call Trace:
Aug  2 21:34:48 blaze kernel:  [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
Aug  2 21:34:48 blaze kernel:  [<02173274>] iget_locked+0x94/0xc0
Aug  2 21:34:48 blaze kernel:  [<0218b3a7>] proc_read_inode+0x17/0x40
Aug  2 21:34:48 blaze kernel:  [<02173c9f>] wake_up_inode+0xf/0x30
Aug  2 21:34:48 blaze kernel:  [<0218b6d3>] proc_get_inode+0x113/0x140
Aug  2 21:34:48 blaze kernel:  [<02147428>] follow_page+0xc8/0x120
Aug  2 21:34:48 blaze kernel:  [<02155274>] rw_vm+0x134/0x330
Aug  2 21:34:48 blaze kernel:  [<0211a8a0>] do_page_fault+0x0/0x48e
Aug  2 21:34:48 blaze kernel:  [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
Aug  2 21:34:48 blaze kernel:  [<0213dbd2>] __alloc_pages+0x92/0x320
Aug  2 21:34:48 blaze kernel:  [<0229767c>] proc_scsi_read+0x3c/0x60
Aug  2 21:34:48 blaze kernel:  [<02297640>] proc_scsi_read+0x0/0x60
Aug  2 21:34:48 blaze kernel:  [<0218d942>] proc_file_read+0xc2/0x250
Aug  2 21:34:48 blaze kernel:  [<02157e1e>] vfs_read+0xbe/0x130
Aug  2 21:34:48 blaze kernel:  [<021580f2>] sys_read+0x42/0x70
Aug  2 21:34:48 blaze kernel: Code:  Bad EIP value.


>>EIP; 022ab7a8 <aic7xxx_proc_info+c28/c80>   <=3D=3D=3D=3D=3D

>>EAX; 32cbb000 <_end+308772f0/fdba72f0>
>>ECX; 03b64400 <_end+17206f0/fdba72f0>
>>EDX; 03b64400 <_end+17206f0/fdba72f0>
>>ESI; 32cbb000 <_end+308772f0/fdba72f0>

Trace; 0213dbd2 <__alloc_pages+92/320>
Trace; 0229767c <proc_scsi_read+3c/60>
Trace; 02297640 <proc_scsi_read+0/60>
Trace; 0218d942 <proc_file_read+c2/250>
Trace; 02157e1e <vfs_read+be/130>
Trace; 021580f2 <sys_read+42/70>

>>EIP; 0211a910 <do_page_fault+70/48e>   <=3D=3D=3D=3D=3D

>>edx; 02379798 <log_wait+0/8>
>>edi; 0211a8a0 <do_page_fault+0/48e>
>>esp; 2964fdf4 <_end+2720c0e4/fdba72f0>

Trace; 022ab7a8 <aic7xxx_proc_info+c28/c80>
Trace; 02173274 <iget_locked+94/c0>
Trace; 0218b3a7 <proc_read_inode+17/40>
Trace; 02173c9f <wake_up_inode+f/30>
Trace; 0218b6d3 <proc_get_inode+113/140>
Trace; 02147428 <follow_page+c8/120>
Trace; 02155274 <rw_vm+134/330>
Trace; 0211a8a0 <do_page_fault+0/48e>
Trace; 022ab7a8 <aic7xxx_proc_info+c28/c80>
Trace; 0213dbd2 <__alloc_pages+92/320>
Trace; 0229767c <proc_scsi_read+3c/60>
Trace; 02297640 <proc_scsi_read+0/60>
Trace; 0218d942 <proc_file_read+c2/250>
Trace; 02157e1e <vfs_read+be/130>
Trace; 021580f2 <sys_read+42/70>


2 warnings and 1 error issued.  Results may not be reliable.

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
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
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_4G=y
CONFIG_X86_SWITCH_PAGETABLES=y
CONFIG_X86_4G_VM_LAYOUT=y
CONFIG_X86_UACCESS_INDIRECT=y
CONFIG_X86_HIGH_ENTRY=y
CONFIG_HUGETLB_PAGE=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

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
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
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
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=m
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC7XXX_OLD=y
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_FERAL_ISP is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_IOCTL_V4 is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
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

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=m
# CONFIG_NETFILTER is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
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

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
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
# CONFIG_ISDN_BOOL is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_ACPI is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
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
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=m
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
# CONFIG_VIDEO_PROC_FS is not set

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
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

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

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
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
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
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

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
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.0-test2-mm3.txt"
Content-Transfer-Encoding: quoted-printable

 pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17, disabled)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16, disabled)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22, disabled)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0x020fb780
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb7b0, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:0)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:0)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:0)
00:01:06[D] -> 2-17 -> IRQ 17
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
pty: 512 Unix98 ptys configured
Machine check exception polling timer started.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 control=
ler on pci0000:00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-372200, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=3D43800/16/63
 /dev/ide/host0/bus0/target0/lun0: p1
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
  Vendor:           Model:                   Rev:    =20
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id=
 1 lun 0
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 4, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
XFS mounting filesystem sda3
Starting XFS recovery on filesystem: sda3 (dev: 8/3)
Ending XFS recovery on filesystem: sda3 (dev: 8/3)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 344k freed
Adding 248968k swap on /dev/sda10.  Priority:-1 extents:1
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.0.
XFS mounting filesystem sda5
Starting XFS recovery on filesystem: sda5 (dev: 8/5)
Ending XFS recovery on filesystem: sda5 (dev: 8/5)
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
XFS mounting filesystem sda7
Starting XFS recovery on filesystem: sda7 (dev: 8/7)
Ending XFS recovery on filesystem: sda7 (dev: 8/7)
XFS mounting filesystem sda8
Ending clean XFS mount for filesystem: sda8
XFS mounting filesystem sda9
Starting XFS recovery on filesystem: sda9 (dev: 8/9)
Ending XFS recovery on filesystem: sda9 (dev: 8/9)
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
Real Time Clock Driver v1.11
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Intel(R) PRO/1000 Network Driver - version 5.1.13-k2
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
ohci1394: $Rev: 1011 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D[22]  MMIO=3D[ce084000-ce0847ff]  Ma=
x Packet=3D[2048]
ohci1394_0: SelfID received outside of bus reset sequence
PCI: Setting latency timer of device 0000:00:06.0 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
intel8x0_measure_ac97_clock: measured 49394 usecs
intel8x0: clocking to 47419
ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem 428ad000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:02.0: PCI device 10de:0067 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci-hcd 0000:00:02.0: irq 20, pci mem 42903000
ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
ohci-hcd 0000:00:02.1: PCI device 10de:0067 (nVidia Corporation)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci-hcd 0000:00:02.1: irq 22, pci mem 42905000
ohci-hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 512M @ 0xa0000000
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
hub 2-1:0: USB hub found
hub 2-1:0: 3 ports detected
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 2, assigned address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with Intelli=
Eye(TM)] on usb-0000:00:02.0-2
hub 2-1:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-1:0: new USB device on port 1, assigned address 4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000:=
00:02.0-1.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:00=
:02.0-1.1
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 1x mode
[drm] Loading R200 Microcode
invalid kernel-mode pagefault 0! [addr:0000004c, eip:022ab7a8]

Pid: 4678, comm:                  cat
EIP: 0060:[<022ab7a8>] CPU: 0
EIP is at aic7xxx_proc_info+0xc28/0xc80
 EFLAGS: 00010246    Not tainted
EAX: 32cbb000 EBX: 00000400 ECX: 03b64400 EDX: 03b64400
ESI: 32cbb000 EDI: 00000400 EBP: 00000000 DS: 007b ES: 007b
CR0: 8005003b CR2: 0000004c CR3: 00101000 CR4: 000006d0
Call Trace:
 [<0213dbd2>] __alloc_pages+0x92/0x320
 [<0229767c>] proc_scsi_read+0x3c/0x60
 [<02297640>] proc_scsi_read+0x0/0x60
 [<0218d942>] proc_file_read+0xc2/0x250
 [<02157e1e>] vfs_read+0xbe/0x130
 [<021580f2>] sys_read+0x42/0x70

invalid operand: 0000 [#1]
PREEMPT=20
CPU:    0
EIP:    0060:[<0211a910>]    Not tainted VLI
EFLAGS: 00010006
EIP is at do_page_fault+0x70/0x48e
eax: 00000001   ebx: 00000400   ecx: 00000001   edx: 02379798
esi: 00000000   edi: 0211a8a0   ebp: 0000004c   esp: 2964fdf4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 4678, threadinfo=3D2964e000 task=3D37452d40)
Stack: 2964fea8 00000000 0000004c 022ab7a8 00001184 2964e000 00000000 00001=
184=20
       41fdee00 02173274 2d3c8390 03b10540 41fdee00 0218b3a7 2964fe30 3f2c6=
6b8=20
       02173c9f 2d3c8390 0218b6d3 2d3c8390 00001184 00000000 00000ffc 36485=
900=20
Call Trace:
 [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
 [<02173274>] iget_locked+0x94/0xc0
 [<0218b3a7>] proc_read_inode+0x17/0x40
 [<02173c9f>] wake_up_inode+0xf/0x30
 [<0218b6d3>] proc_get_inode+0x113/0x140
 [<02147428>] follow_page+0xc8/0x120
 [<02155274>] rw_vm+0x134/0x330
 [<0211a8a0>] do_page_fault+0x0/0x48e
 [<022ab7a8>] aic7xxx_proc_info+0xc28/0xc80
 [<0213dbd2>] __alloc_pages+0x92/0x320
 [<0229767c>] proc_scsi_read+0x3c/0x60
 [<02297640>] proc_scsi_read+0x0/0x60
 [<0218d942>] proc_file_read+0xc2/0x250
 [<02157e1e>] vfs_read+0xbe/0x130
 [<021580f2>] sys_read+0x42/0x70

Code:  Bad EIP value.
=20

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mount.txt"

/dev/scsi/host0/bus0/target0/lun0/part3 on / type xfs (rw,noatime,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part1 on /boot type xfs (rw,noatime,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part2 on /win2000 type ntfs (rw)
/dev/scsi/host0/bus0/target0/lun0/part5 on /home type xfs (rw,noatime,quota,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part6 on /usr type xfs (rw,noatime,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part7 on /tmp type xfs (rw,noatime,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part8 on /usr/src type xfs (rw,noatime,logbufs=8)
/dev/scsi/host0/bus0/target0/lun0/part9 on /var type xfs (rw,noatime,logbufs=8)
/dev/ide/host0/bus0/target0/lun0/part1 on /mnt/hd type xfs (rw,noatime,logbufs=8)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
proc on /proc type proc (rw)
usbfs on /proc/bus/usb type usbfs (rw)
sysfs on /sys type sysfs (rw)

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod.txt"
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by
radeon                111768  2=20
parport_pc             24968  1=20
lp                      8288  0=20
parport                36160  2 parport_pc,lp
nfsd                  157664  8=20
exportfs                5184  1 nfsd
lockd                  59184  2 nfsd
sunrpc                120068  2 nfsd,lockd
nvidia_agp              5468  1=20
agpgart                25768  2 nvidia_agp
ohci_hcd               15808  0=20
ehci_hcd               22272  0=20
snd_intel8x0           21700  0=20
snd_ac97_codec         51076  1 snd_intel8x0
snd_pcm                85888  1 snd_intel8x0
snd_timer              21120  1 snd_pcm
snd_page_alloc          9028  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6080  1 snd_intel8x0
snd_rawmidi            20352  1 snd_mpu401_uart
snd_seq_device          6468  1 snd_rawmidi
snd                    43012  7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_tim=
er,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7168  1 snd
ohci1394               30400  0=20
ieee1394              210700  1 ohci1394
e1000                  68736  0=20
evdev                   7616  0=20
hid                    23424  0=20
rtc                    10340  0=20
nls_iso8859_1           3712  1=20
ntfs                   90644  1=20

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=512M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at dc00 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ce087000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at ce082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at ce083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Giga-byte Technology: Unknown device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ce086000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: nVidia Corporation: Unknown device 4144
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at d000 [size=128]
	Region 2: Memory at ce080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00008000-0000afff
	Memory behind bridge: cc000000-cdffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology: Unknown device 5002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at ce084000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ce085000 (32-bit, non-prefetchable) [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ca000000-cbffffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
	Subsystem: Adaptec AHA-2940U2W SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 18
	BIST result: 00
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at cd020000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 3013
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at cd000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 8400 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at cb000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at c4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at cb010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Fba/0zbH8Xs+Fj9o--

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LGt+IymMQsXoRDARAqvHAJ4zcJPvxUh7RuctyppZERRnolToaACeMc6w
WvC+99+GspPVMCIu0jeL/vo=
=Dvla
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
