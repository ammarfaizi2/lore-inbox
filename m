Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTHQQXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTHQQXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:23:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7685 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270326AbTHQQXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:23:13 -0400
Date: Sun, 17 Aug 2003 17:23:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-ID: <20030817172310.B24478@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030806231519.H16116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806231519.H16116@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Aug 06, 2003 at 11:15:19PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 11:15:19PM +0100, Russell King wrote:
> I'm trying to test out APM on my laptop (in order to test some PCMCIA
> changes), but I'm hitting a brick wall.  I've added the device_suspend()
> calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> calls into apm's suspend() function.  (this is needed so that PCI
> devices receive their notifications.)
> 
> However, APM is refusing to suspend.  I'm seeing the following kernel
> messages:

I've just been doing further testing.

The kernel test setup consists of booting a kernel with init=/bin/sh,
and after the shell prompt appears, hitting the BIOS-magic "suspend to
RAM" key combination.

I can suspend to RAM under these circumstances:

- from LILO
- under RH7.2 2.4.9-31 kernel (with custom hacks to the APM code to allow
  NFS mounts to be unmounted before we shut down CardBus - search LKML
  for details on this)

I can't suspend under these circumstances:

- under a 2.6 kernel running any configuration, even with every driver
  including CONFIG_INPUT turned off (Kconfig hacked to allow that)
  leaving only IDE enabled, with the IDE power management disabled.
  I've even tried without IDE.

I've tried all the steps from a full configuration down to nothing with
2.6, turning off one driver or subsystem at a time.

Please note that this is my only x86 system, so I'm currently unable
to test my PCMCIA/Cardbus changes as fully as I would like to under
2.6 kernels.

The machine is an IBM Thinkpad 380XD, 64MB.  The BIOS does not have
the necessary ACPI tables so ACPI is of no use.  lspci output:

00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
00:02.0 CardBus bridge: Texas Instruments PCI1250 (rev 02)
00:02.1 CardBus bridge: Texas Instruments PCI1250 (rev 02)
00:03.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01)
00:06.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:06.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:06.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:06.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)

The last config I tried (with no drivers) is below.

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_M586MMX=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
# Token Ring devices (depends on LLC=y)
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_UNIX98_PTYS=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_BIOS_REBOOT=y


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

