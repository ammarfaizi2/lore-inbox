Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUKEPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUKEPcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbUKEPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:32:10 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:1803 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261169AbUKEP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:28:45 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 5 Nov 2004 09:28:30 -0600
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory requirements and BK
Message-ID: <20041105152830.GD7724@artsapartment.org>
References: <20041105144621.GC7724@artsapartment.org> <Pine.LNX.4.60.0411051554290.3255@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0411051554290.3255@alpha.polcom.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 03:55:53PM +0100, Grzegorz Kulewski wrote:
> On Fri, 5 Nov 2004, Art Haas wrote:
> 
> >Hi.
> >
> >I've been having problems with 'bk pull' execution when using kernels
> >after the 2.6.8/2.6.8.1 releases. My machine has 192M of memory and 100M
> >of swap, so I believe that the memory requirements for using BK to keep
> >up with the kernel is sufficient, and when the machine is running with a
> >2.6.8.1 kernel I can 'bk pull' even if X windows is running. With the
> >2.6.9 and 2.6.10-rc kernels, BK bombs out with out-of-memory errors once
> >the repository checking begins. I've run the 'bk pull' under the newer
> >kernels without X running, as well as shutting down various daemons, and
> >still things fail with memory errors.
> 
> Maybe you have some kernel debuging options set? Some of them can eat your 
> RAM very fast with fs heavy load.

My current configuration does have a few debug options, but these options
are also in my configure for the 2.6.8.1 kernel as well:

$ grep -i debug ./art_config_2610
CONFIG_PNP_DEBUG=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
$ grep -i debug ./art_config_2681
CONFIG_PNP_DEBUG=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
$

I believe that the PnP, Netfilter, and sound debug statements have been
in my configuration for a long time, but I no longer have older copies
of my '.config' files to confirm that.

Here are the differences between the configuration files. Aside from a
few new configuration options only found in the new kernel, nothing
jumps out at me as being an option that would significantly increase the
memory usage.

$ diff -u ./art_config_2681 ./art_config_2610
--- ./art_config_2681	2004-08-20 08:20:02.000000000 -0500
+++ ./art_config_2610	2004-10-28 20:19:29.000000000 -0500
@@ -1,10 +1,13 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10-rc1-ajh
+# Thu Oct 28 20:19:01 2004
 #
 CONFIG_X86=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_IOMAP=y
 
 #
 # Code maturity level options
@@ -13,10 +16,12 @@
 # CONFIG_CLEAN_COMPILE is not set
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -26,17 +31,20 @@
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -46,6 +54,7 @@
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -74,6 +83,7 @@
 # CONFIG_MK7 is not set
 # CONFIG_MK8 is not set
 # CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
 # CONFIG_MWINCHIPC6 is not set
 # CONFIG_MWINCHIP2 is not set
 # CONFIG_MWINCHIP3D is not set
@@ -127,7 +137,7 @@
 # ACPI (Advanced Configuration and Power Interface) Support
 #
 # CONFIG_ACPI is not set
-CONFIG_ACPI_BOOT=y
+CONFIG_ACPI_BLACKLIST_YEAR=0
 
 #
 # CPU Frequency scaling
@@ -144,7 +154,6 @@
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
-CONFIG_PCI_MMCONFIG=y
 # CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
@@ -153,9 +162,13 @@
 # CONFIG_SCx200 is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
 #
-# CONFIG_PCMCIA is not set
 CONFIG_PCMCIA_PROBE=y
 
 #
@@ -227,7 +240,17 @@
 # CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -246,7 +269,6 @@
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
-CONFIG_IDE_TASKFILE_IO=y
 
 #
 # IDE chipset support/bugfixes
@@ -264,7 +286,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
 # CONFIG_WDC_ALI15X3 is not set
@@ -349,17 +370,13 @@
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
+CONFIG_INET_TUNNEL=m
 
 #
 # IP: Virtual Server Configuration
 #
 # CONFIG_IP_VS is not set
-CONFIG_IPV6=m
-CONFIG_IPV6_PRIVACY=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_TUNNEL=m
+# CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_DEBUG=y
 
@@ -367,6 +384,9 @@
 # IP: Netfilter Configuration
 #
 CONFIG_IP_NF_CONNTRACK=m
+# CONFIG_IP_NF_CT_ACCT is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set
 CONFIG_IP_NF_FTP=m
 CONFIG_IP_NF_IRC=m
 CONFIG_IP_NF_TFTP=m
@@ -391,8 +411,16 @@
 CONFIG_IP_NF_MATCH_STATE=m
 CONFIG_IP_NF_MATCH_CONNTRACK=m
 CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_MATCH_ADDRTYPE=m
+CONFIG_IP_NF_MATCH_REALM=m
+# CONFIG_IP_NF_MATCH_SCTP is not set
+CONFIG_IP_NF_MATCH_COMMENT=m
+# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
@@ -411,23 +439,12 @@
 CONFIG_IP_NF_TARGET_DSCP=m
 CONFIG_IP_NF_TARGET_MARK=m
 CONFIG_IP_NF_TARGET_CLASSIFY=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_IP_NF_TARGET_TCPMSS=m
+# CONFIG_IP_NF_RAW is not set
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
-# CONFIG_IP_NF_RAW is not set
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
-CONFIG_IP_NF_MATCH_REALM=m
-
-#
-# IPv6: Netfilter Configuration
-#
-# CONFIG_IP6_NF_QUEUE is not set
-# CONFIG_IP6_NF_IPTABLES is not set
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
 
@@ -447,7 +464,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -522,7 +538,6 @@
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
-# CONFIG_VIA_VELOCITY is not set
 # CONFIG_NET_POCKET is not set
 
 #
@@ -536,6 +551,7 @@
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 
 #
@@ -563,7 +579,7 @@
 # CONFIG_PLIP is not set
 CONFIG_PPP=m
 # CONFIG_PPP_MULTILINK is not set
-# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_FILTER=y
 CONFIG_PPP_ASYNC=m
 # CONFIG_PPP_SYNC_TTY is not set
 CONFIG_PPP_DEFLATE=m
@@ -611,6 +627,7 @@
 # CONFIG_SERIO_CT82C710 is not set
 # CONFIG_SERIO_PARKBD is not set
 # CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_RAW is not set
 
 #
 # Input Device Drivers
@@ -657,7 +674,6 @@
 # CONFIG_PRINTER is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
-# CONFIG_QIC02_TAPE is not set
 
 #
 # IPMI
@@ -797,6 +813,7 @@
 #
 # CONFIG_SND_ALI5451 is not set
 # CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
 # CONFIG_SND_AU8810 is not set
 # CONFIG_SND_AU8820 is not set
 # CONFIG_SND_AU8830 is not set
@@ -839,6 +856,8 @@
 # USB support
 #
 # CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
 
 #
 # USB Gadget Support
@@ -876,7 +895,8 @@
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
 CONFIG_ZISOFS_FS=m
-# CONFIG_UDF_FS is not set
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
@@ -896,6 +916,7 @@
 # CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -934,6 +955,7 @@
 CONFIG_SUNRPC=m
 CONFIG_SUNRPC_GSS=m
 CONFIG_RPCSEC_GSS_KRB5=m
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -999,14 +1021,14 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_EARLY_PRINTK=y
-# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_FRAME_POINTER is not set
+CONFIG_EARLY_PRINTK=y
 CONFIG_4KSTACKS=y
 
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
@@ -1020,6 +1042,7 @@
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
@@ -1043,5 +1066,7 @@
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_X86_BIOS_REBOOT=y
 CONFIG_PC=y

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
