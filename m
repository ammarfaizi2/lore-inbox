Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbUKDG2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUKDG2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUKDG2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:28:51 -0500
Received: from crianza.bmb.uga.edu ([128.192.34.109]:31126 "EHLO crianza")
	by vger.kernel.org with ESMTP id S262086AbUKDG2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:28:35 -0500
Date: Thu, 4 Nov 2004 01:28:34 -0500
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bad UDP checksums with 2.6.9
Message-ID: <20041104062834.GE12763@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20041104054838.GC12763@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104054838.GC12763@porto.bmb.uga.edu>
User-Agent: Mutt/1.5.6+20040818i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:48:38AM -0500, foo wrote:
> 'm seeing the same problem as in:
> Message-Id: 20041020191203.GA14356@merlin.emma.line.org
> or http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1310.html
> 
> I just upgraded a machine from 2.6.5 to 2.6.9, and when the amanda
> backup server contacts it, it sometimes replies with a UDP packet with a
> bad checksum.  I'm using e1000 here, so it seems to not be related to
> the ethernet driver.  I have a binary tcpdump if anyone's interested.

I don't know why I didn't think of this at first, but I have another
identical machine that I upgraded at the same time that doesn't have the
problem.

Here's a diff between their .configs - albarino is the one having
trouble.  Maybe CONFIG_PACKET_MMAP?  If someone can point me at a likely
config option to change I'll boot a new kernel for the next backup run
Friday night.

--- config-albarino     2004-10-28 18:31:57.000000000 -0400
+++ config-airen        2004-10-28 18:40:35.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.9
-# Thu Oct 28 18:31:48 2004
+# Thu Oct 28 18:40:27 2004
 #
 CONFIG_X86=y
 CONFIG_MMU=y
@@ -168,7 +168,7 @@
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_MMCONFIG=y
-CONFIG_PCI_LEGACY_PROC=y
+# CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
 # CONFIG_EISA is not set
@@ -252,7 +252,7 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_LBD=y
+# CONFIG_LBD is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -283,7 +283,7 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
-CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_RZ1000 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
@@ -437,7 +437,7 @@
 # Networking options
 #
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
+CONFIG_PACKET_MMAP=y
 # CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
@@ -453,58 +453,8 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-
-#
-# IP: Netfilter Configuration
-#
-CONFIG_IP_NF_CONNTRACK=y
-# CONFIG_IP_NF_CT_ACCT is not set
-# CONFIG_IP_NF_CT_PROTO_SCTP is not set
-CONFIG_IP_NF_FTP=y
-# CONFIG_IP_NF_IRC is not set
-# CONFIG_IP_NF_TFTP is not set
-CONFIG_IP_NF_AMANDA=y
-# CONFIG_IP_NF_QUEUE is not set
-CONFIG_IP_NF_IPTABLES=y
-# CONFIG_IP_NF_MATCH_LIMIT is not set
-CONFIG_IP_NF_MATCH_IPRANGE=y
-# CONFIG_IP_NF_MATCH_MAC is not set
-# CONFIG_IP_NF_MATCH_PKTTYPE is not set
-# CONFIG_IP_NF_MATCH_MARK is not set
-# CONFIG_IP_NF_MATCH_MULTIPORT is not set
-# CONFIG_IP_NF_MATCH_TOS is not set
-# CONFIG_IP_NF_MATCH_RECENT is not set
-# CONFIG_IP_NF_MATCH_ECN is not set
-# CONFIG_IP_NF_MATCH_DSCP is not set
-# CONFIG_IP_NF_MATCH_AH_ESP is not set
-# CONFIG_IP_NF_MATCH_LENGTH is not set
-# CONFIG_IP_NF_MATCH_TTL is not set
-# CONFIG_IP_NF_MATCH_TCPMSS is not set
-# CONFIG_IP_NF_MATCH_HELPER is not set
-CONFIG_IP_NF_MATCH_STATE=y
-# CONFIG_IP_NF_MATCH_CONNTRACK is not set
-# CONFIG_IP_NF_MATCH_OWNER is not set
-# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
-# CONFIG_IP_NF_MATCH_REALM is not set
-# CONFIG_IP_NF_MATCH_SCTP is not set
-# CONFIG_IP_NF_MATCH_COMMENT is not set
-CONFIG_IP_NF_FILTER=y
-# CONFIG_IP_NF_TARGET_REJECT is not set
-CONFIG_IP_NF_TARGET_LOG=y
-# CONFIG_IP_NF_TARGET_ULOG is not set
-# CONFIG_IP_NF_TARGET_TCPMSS is not set
-# CONFIG_IP_NF_NAT is not set
-# CONFIG_IP_NF_MANGLE is not set
-# CONFIG_IP_NF_RAW is not set
-# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
@@ -660,8 +610,8 @@
 #
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -719,8 +669,7 @@
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-CONFIG_PRINTER=y
-# CONFIG_LP_CONSOLE is not set
+# CONFIG_PRINTER is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
 
@@ -886,8 +835,8 @@
 # USB Host Controller Drivers
 #
 CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_SPLIT_ISO is not set
-# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+CONFIG_USB_EHCI_SPLIT_ISO=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_OHCI_HCD is not set
 CONFIG_USB_UHCI_HCD=y
 
@@ -1056,13 +1005,10 @@
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
-# CONFIG_NFSD_V4 is not set
-# CONFIG_NFSD_TCP is not set
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-CONFIG_EXPORTFS=y
+# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -1083,7 +1029,7 @@
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_437 is not set
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -1107,7 +1053,7 @@
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set

