Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRKHRif>; Thu, 8 Nov 2001 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276709AbRKHRi1>; Thu, 8 Nov 2001 12:38:27 -0500
Received: from ltspc67.epfl.ch ([128.178.121.34]:18560 "EHLO ltspc67.epfl.ch")
	by vger.kernel.org with ESMTP id <S276576AbRKHRiO>;
	Thu, 8 Nov 2001 12:38:14 -0500
Message-ID: <3BEAC2FF.20109@epfl.ch>
Date: Thu, 08 Nov 2001 18:38:07 +0100
From: Diego Santa Cruz <Diego.SantaCruz@epfl.ch>
Organization: Ecole Polytechnique Federale de Lausanne
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: en, es, fr
MIME-Version: 1.0
To: andre@suse.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: OOPS in ide and/or ide-cd (2.4.9)
Content-Type: multipart/mixed;
 boundary="------------080101000407090709070308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101000407090709070308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

I got an OOPS (report attached raw and decoded with ksymoops) on the ide 
or ide-cd module (sorry don't really know) while trying to mount a CD 
after doing an IDE register/unregister/register cycle (using hdparm). 
Kernel is 2.2.9-13 (RedHat's, but I think it basically is 2.4.9-ac10 with 
many other bugfixes).

My machine is a HP OmniBook 4150 laptop, with the IDE hardrive on ide0 and 
a pluggable CD-ROM drive on ide1. I used hdparm -R to register the CD-ROM 
drive after booting (I booted without the drive and inserted it after the 
machine was up):

# hdparm -R 0x170 0x376 15 /dev/hda

Then I mounted a CD-ROM to test. Everything appeared to work fine. Then I 
unmounted the CD-ROM, unloaded the cdrom and ide-cd modules, and 
deregistered the ide1 interface.

# mount /mnt/cdrom
# ls /mnt/cdrom
# umount /mnt/cdrom
# modprobe -r ide-cd
# hdparm U 1 /dev/hda

The I registered the CD-ROM drive again. That appeared to go fine (got 
message "ide1 at 0x170-0x177,0x376 on irq 15" from kernel). Lastly I 
attempted to mount a CD again, and that caused the kernel to OOPS (and 
froze the harddisk on hda for a few seconds).

# hdparm -R 0x170 0x376 15 /dev/hda
# mount /mnt/cdrom

After a reboot I tried inserting and removing the CD-ROM modules (ide-cd 
and cdrom) several times and that did not cause any problems. It is 
probably the combination with the registration/unregistration that causes 
some problem. I also noted that after the unregistration ide1 still shows 
up in proc (/proc/ide/ide1) although not hdc. Don't know if that is normal.

I would like to be able to plug unplug my CD-ROM, since I often exhange it 
for the 2nd battery or floppy disk.

I attach the (decoded) OOPS, run just after the OOPS, on the same running 
kernel.

I'm not subscribed to lkml (sorry couldn't keep up with the volume) so 
please CC me if further details are required.

Best,

	Diego

-- 
-------------------------------------------------------
Diego Santa Cruz
PhD. student
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)
EPFL - DE - LTS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz@epfl.ch
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------

--------------080101000407090709070308
Content-Type: text/plain;
 name="oops-cdrom.ksym"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-cdrom.ksym"

ksymoops 2.4.1 on i686 2.4.9-13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-13/ (default)
     -m /boot/System.map-2.4.9-13 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01b5c80, System.map says c0156ea0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says d096fad4, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d096ef3c.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d096fad0, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d096ef38.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says d096fad8, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d096ef40.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d092ed20, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092ea00.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d092ed24, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092ea04.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d092ed28, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092ea08.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d092ed1c, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9fc.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says d092ecfc, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9dc.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says d092ecec, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9cc.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says d092ed00, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9e0.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says d092ece4, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9c4.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says d092ece8, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9c8.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says d092ece0, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d092e9c0.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol proc_irda  , irda says d090ad5c, /lib/modules/2.4.9-13/kernel/net/irda/irda.o says d090a3dc.  Ignoring /lib/modules/2.4.9-13/kernel/net/irda/irda.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d086ba00, /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o says d086b520.  Ignoring /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c019758c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c019758c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c0f830e0   ecx: 00000006   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c6effbdc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 4533, stackpage=c6eff000)
Stack: 00000000 00000000 00000000 c034f964 c17f08c0 00000000 c0197722 c034f964 
       c17f08c0 c013c9d5 c17f08c0 00000000 c034f964 00000000 c034f9a4 00000000 
       c0197d21 c034f9a4 00000000 00000001 00000008 0034f9a4 00000001 c62c4400 
Call Trace: [<c0197722>] ide_build_dmatable [kernel] 0x32 
[<c013c9d5>] ioctl_by_bdev [kernel] 0x95 
[<c0197d21>] ide_dmaproc [kernel] 0x131 
[<d0a6a823>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x7c3 
[<d0a6b2f7>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x1297 
[<d0a6aef0>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0xe90 
[<d0a6bab9>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x1a59 
[<c018e500>] start_request [kernel] 0x1a0 
[<c018e863>] ide_do_request [kernel] 0x293 
[<c018e8ff>] do_ide_request [kernel] 0xf 
[<c018119e>] generic_unplug_device [kernel] 0x1e 
[<c011b8d9>] __run_task_queue [kernel] 0x49 
[<c01372a6>] __wait_on_buffer [kernel] 0x56 
[<c016da63>] batch_entropy_process [kernel] 0xb3 
[<c0138566>] bread [kernel] 0x46 
[<c011f0b7>] run_all_timers [kernel] 0x17 
[<c015fe48>] isofs_read_inode [kernel] 0x48 
[<c01497fa>] get_new_inode [kernel] 0xca 
[<c0161dbe>] find_nls [kernel] 0x3e 
[<c0149a72>] iget4 [kernel] 0xd2 
[<c022eb5e>] .rodata.str1.1 [kernel] 0x32f9 
[<c015f6da>] isofs_read_super [kernel] 0x52a 
[<d0a6c9fa>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x299a 
[<d0a6756e>] cdrom_get_next_writable_R3dbfcfc5 [cdrom] 0x18ae 
[<d0a62d00>] cdrom_select_disc_Rc5afb6d4 [cdrom] 0x100 
[<c013b533>] get_sb_bdev [kernel] 0x203 
[<c013bac4>] do_kern_mount [kernel] 0xe4 
[<c014bd43>] do_add_mount [kernel] 0x23 
[<c014bfcb>] do_mount [kernel] 0x13b 
[<c013013f>] __alloc_pages [kernel] 0xf 
[<c014be3c>] copy_mount_options [kernel] 0x4c 
[<c014c06c>] sys_mount [kernel] 0x7c 
[<c0106f3b>] system_call [kernel] 0x33 
Code: f3 ab 8b 43 38 85 c0 89 46 04 74 0d 8b 43 34 25 ff 0f 00 00 

>>EIP; c019758c <ide_build_sglist+bc/220>   <=====
Trace; c0197722 <ide_build_dmatable+32/180>
Trace; c013c9d5 <ioctl_by_bdev+95/b0>
Trace; c0197d21 <ide_dmaproc+131/270>
Trace; d0a6a823 <[ide-cd]cdrom_start_packet_command+63/160>
Trace; d0a6b2f7 <[ide-cd]cdrom_start_read+a7/b0>
Trace; d0a6aef0 <[ide-cd]cdrom_start_read_continuation+0/120>
Trace; d0a6bab9 <[ide-cd]ide_do_rw_cdrom+f9/170>
Trace; c018e500 <start_request+1a0/210>
Trace; c018e863 <ide_do_request+293/2e0>
Trace; c018e8ff <do_ide_request+f/20>
Trace; c018119e <generic_unplug_device+1e/30>
Trace; c011b8d9 <__run_task_queue+49/60>
Trace; c01372a6 <__wait_on_buffer+56/90>
Trace; c016da63 <batch_entropy_process+b3/c0>
Trace; c0138566 <bread+46/70>
Trace; c011f0b7 <run_all_timers+17/20>
Trace; c015fe48 <isofs_read_inode+48/400>
Trace; c01497fa <get_new_inode+ca/170>
Trace; c0161dbe <find_nls+3e/50>
Trace; c0149a72 <iget4+d2/e0>
Trace; c022eb5e <IRQ0x0f_interrupt+1cade/21ca0>
Trace; c015f6da <isofs_read_super+52a/6a0>
Trace; d0a6c9fa <[ide-cd]ide_cdrom_check_media_change_real+1a/50>
Trace; d0a6756e <[cdrom].text.end+f2f/1a91>
Trace; d0a62d00 <[cdrom]media_changed+40/80>
Trace; c013b533 <get_sb_bdev+203/2b0>
Trace; c013bac4 <do_kern_mount+e4/1b0>
Trace; c014bd43 <do_add_mount+23/d0>
Trace; c014bfcb <do_mount+13b/160>
Trace; c013013f <__alloc_pages+f/a0>
Trace; c014be3c <copy_mount_options+4c/a0>
Trace; c014c06c <sys_mount+7c/c0>
Trace; c0106f3b <system_call+33/38>
Code;  c019758c <ide_build_sglist+bc/220>
00000000 <_EIP>:
Code;  c019758c <ide_build_sglist+bc/220>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c019758e <ide_build_sglist+be/220>
   2:   8b 43 38                  mov    0x38(%ebx),%eax
Code;  c0197591 <ide_build_sglist+c1/220>
   5:   85 c0                     test   %eax,%eax
Code;  c0197593 <ide_build_sglist+c3/220>
   7:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c0197596 <ide_build_sglist+c6/220>
   a:   74 0d                     je     19 <_EIP+0x19> c01975a5 <ide_build_sglist+d5/220>
Code;  c0197598 <ide_build_sglist+c8/220>
   c:   8b 43 34                  mov    0x34(%ebx),%eax
Code;  c019759b <ide_build_sglist+cb/220>
   f:   25 ff 0f 00 00            and    $0xfff,%eax


18 warnings and 2 errors issued.  Results may not be reliable.

--------------080101000407090709070308
Content-Type: text/plain;
 name="oops-cdrom"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-cdrom"

hdc: MATSHITADVD-ROM SR-8171, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.97.sv
ide-floppy driver 0.97.sv
hdc: ATAPI 20X DVD-ROM DVD-RAM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ISO 9660 Extensions: Microsoft Joliet Level 1
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c019758c
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c019758c>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c0f830e0   ecx: 00000006   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c6effbdc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 4533, stackpage=c6eff000)
Stack: 00000000 00000000 00000000 c034f964 c17f08c0 00000000 c0197722 c034f964 
       c17f08c0 c013c9d5 c17f08c0 00000000 c034f964 00000000 c034f9a4 00000000 
       c0197d21 c034f9a4 00000000 00000001 00000008 0034f9a4 00000001 c62c4400 
Call Trace: [<c0197722>] ide_build_dmatable [kernel] 0x32 
[<c013c9d5>] ioctl_by_bdev [kernel] 0x95 
[<c0197d21>] ide_dmaproc [kernel] 0x131 
[<d0a6a823>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x7c3 
[<d0a6b2f7>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x1297 
[<d0a6aef0>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0xe90 
[<d0a6bab9>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x1a59 
[<c018e500>] start_request [kernel] 0x1a0 
[<c018e863>] ide_do_request [kernel] 0x293 
[<c018e8ff>] do_ide_request [kernel] 0xf 
[<c018119e>] generic_unplug_device [kernel] 0x1e 
[<c011b8d9>] __run_task_queue [kernel] 0x49 
[<c01372a6>] __wait_on_buffer [kernel] 0x56 
[<c016da63>] batch_entropy_process [kernel] 0xb3 
[<c0138566>] bread [kernel] 0x46 
[<c011f0b7>] run_all_timers [kernel] 0x17 
[<c015fe48>] isofs_read_inode [kernel] 0x48 
[<c01497fa>] get_new_inode [kernel] 0xca 
[<c0161dbe>] find_nls [kernel] 0x3e 
[<c0149a72>] iget4 [kernel] 0xd2 
[<c022eb5e>] .rodata.str1.1 [kernel] 0x32f9 
[<c015f6da>] isofs_read_super [kernel] 0x52a 
[<d0a6c9fa>] __insmod_ide-cd_S.text_L14880 [ide-cd] 0x299a 
[<d0a6756e>] cdrom_get_next_writable_R3dbfcfc5 [cdrom] 0x18ae 
[<d0a62d00>] cdrom_select_disc_Rc5afb6d4 [cdrom] 0x100 
[<c013b533>] get_sb_bdev [kernel] 0x203 
[<c013bac4>] do_kern_mount [kernel] 0xe4 
[<c014bd43>] do_add_mount [kernel] 0x23 
[<c014bfcb>] do_mount [kernel] 0x13b 
[<c013013f>] __alloc_pages [kernel] 0xf 
[<c014be3c>] copy_mount_options [kernel] 0x4c 
[<c014c06c>] sys_mount [kernel] 0x7c 
[<c0106f3b>] system_call [kernel] 0x33 


Code: f3 ab 8b 43 38 85 c0 89 46 04 74 0d 8b 43 34 25 ff 0f 00 00 
 hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
blk: queue c034f660, I/O limit 4095Mb (mask 0xffffffff)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

--------------080101000407090709070308--

