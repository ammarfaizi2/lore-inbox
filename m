Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbTFAO6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbTFAO6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:58:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:51077 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264641AbTFAO6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:58:30 -0400
Date: Sun, 01 Jun 2003 08:11:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 762] New: cs4232, cs4236 module loading problem
Message-ID: <57260000.1054480300@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: cs4232, cs4236 module loading problem
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: feketga@delfin.klte.hu


Distribution: Debian testing/unstable
Hardware Environment: IBM ThinkPad 600E (PII 366Mhz, 256MB RAM, 6GBHDD)
Software Environment: gcc 3.3

Problem Description:
When trying to load the module for the soundcard it produces some nasty things.
But see below for a full detail.

Steps to reproduce:
After a fresh boot and login :

root@b24a:/lib/modules/2.5.70/kernel/sound/isa/cs423x# lsmod
Module                  Size  Used by
apm                    15976  1 
af_packet              12392  0 
rtc                    10260  0 
unix                   21808  16 

root@b24a:/lib/modules/2.5.70/kernel/sound/isa/cs423x# modprobe snd-cs4232
CS4232 soundcard not found or device busy
FATAL: Error inserting snd_cs4232
(/lib/modules/2.5.70/kernel/sound/isa/cs423x/snd-cs4232.ko): No such device

root@b24a:/lib/modules/2.5.70/kernel/sound/isa/cs423x# lsmod
Module                  Size  Used by
snd_opl3_lib            8768  0
snd_hwdep               6336  1 snd_opl3_lib
snd_cs4231_lib         22976  0
snd_pcm                83840  1 snd_cs4231_lib
snd_timer              21188  3 snd_opl3_lib,snd_cs4231_lib,snd_pcm
snd_page_alloc          7748  2 snd_cs4231_lib,snd_pcm
snd_mpu401_uart         5856  0
snd_rawmidi            18400  1 snd_mpu401_uart
snd_seq_device          6632  2 snd_opl3_lib,snd_rawmidi
snd                    40636  8
snd_opl3_lib,snd_hwdep,snd_cs4231_lib,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmi
di,snd_seq_device
apm                    15976  1
af_packet              12392  0
rtc                    10260  0
unix                   21808  16

root@b24a:/lib/modules/2.5.70/kernel/sound/isa/cs423x# modprobe snd-cs4236
Unable to handle kernel paging request at virtual address ce8ee520
 printing eip:
 c0217f6b
 *pde = 0de6e067
 *pte = 00000000
 Oops: 0002 [#1]
 CPU:    0
 EIP:    0060:[<c0217f6b>]    Not tainted
 EFLAGS: 00010202
 EIP is at pnp_register_card_driver+0x4b/0xb0
 eax: cc164000   ebx: 00000008   ecx: c0332630   edx: ce8ee520
 esi: ce935020   edi: 00000000   ebp: cc165f80   esp: cc165f6c
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 270, threadinfo=cc164000 task=cbf79960)
 Stack: 00000000 00000000 00000008 00000000 ce9350c0 cc165f9c ce8ec02d ce935020
        ce929f08 c0332630 c0332630 cc164000 cc165fbc c012f412 c03c1108 00000001
        ce9350c0 0804f450 00000000 0804e080 cc164000 c01092fb 0804f450 000045e1
 Call Trace:
        [<ce9350c0>] +0x0/0xe0 [snd_cs4236]
        [<ce8ec02d>] +0x2d/0x7d [snd_cs4236]
        [<ce935020>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
        [<c012f412>] sys_init_module+0x132/0x270
        [<ce9350c0>] +0x0/0xe0 [snd_cs4236]
        [<c01092fb>] syscall_call+0x7/0xb

 Code: 89 32 89 56 04 ff 48 14 8b 40 08 a8 08 75 4e 8d 46 1c 89 04
     <6>note: modprobe[260] exited with preempt_count 1
     bad: scheduling while atomic!
 Call Trace:
        [<c01172c6>] schedule+0x3a6/0x3b0
        [<c013bdbe>] unmap_page_range+0x4e/0x80
        [<c013bfb7>] unmap_vmas+0x1c7/0x220
        [<c013fe26>] exit_mmap+0x76/0x190
        [<c0118c54>] mmput+0x54/0xb0
        [<c011c8b6>] do_exit+0xd6/0x470
        [<c0115860>] do_page_fault+0x0/0x4ed
        [<c0109b21>] die+0xe1/0xf0
        [<c011598f>] do_page_fault+0x12f/0x4ed
        [<c012da41>] use_module+0xa1/0x140
        [<ce92d000>] +0x0/0x40 [snd_cs4236_lib]
        [<c0145527>] unmap_vm_area+0x47/0x90
        [<c01458a9>] vfree+0x29/0x40
        [<c012f0d2>] load_module+0x662/0x870
        [<c0115860>] do_page_fault+0x0/0x4ed
        [<c01094a5>] error_code+0x2d/0x38
        [<ce935020>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
        [<c0217f6b>] pnp_register_card_driver+0x4b/0xb0
        [<ce9350c0>] +0x0/0xe0 [snd_cs4236]
        [<ce8ec02d>] +0x2d/0x7d [snd_cs4236]
        [<ce935020>] cs423x_pnpc_driver+0x0/0xa0 [snd_cs4236]
        [<c012f412>] sys_init_module+0x132/0x270
        [<ce9350c0>] +0x0/0xe0 [snd_cs4236]
        [<c01092fb>] syscall_call+0x7/0xb

 Segmentation fault

my .config is :
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_MCA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_CS4232=m
CONFIG_SND_CS4236=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_BIOS_REBOOT=y


