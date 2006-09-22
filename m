Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWIVFFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWIVFFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIVFFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:05:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932275AbWIVFFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:05:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UpRksCmrUjB+/Nxl10c0xAIv+FuxyqHV7+CtylAwupVwdvRkoasYtnBOnpUFqzNSs5J8ITZapxKQ76KavXMbc962qPbT7zZUVsc1i2aoBm7wWm7wqxBiimLVJLCMcUzBB/rCevSeH64xwNl8z23wde5MQj3nbWLFtn4KeR1qAlA=
Message-ID: <489ecd0c0609212205j6b2004acj9f89966b7c56d9a0@mail.gmail.com>
Date: Fri, 22 Sep 2006 13:05:09 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
Subject: [PATCH 3/3] [BFIN] Blackfin documents and MAINTAINER patch
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_377_2773843.1158901509162"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_377_2773843.1158901509162
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Fixed some issues and resend the patch now.

 This is the documents patche for Blackfin arch, also includes the
MAINTAINERS file change.

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>

 Documentation/blackfin/00-INDEX          |   11 ++
 Documentation/blackfin/Filesystems       |  169 +++++++++++++++++++++++++++++++
 Documentation/blackfin/cache-lock.txt    |   48 ++++++++
 Documentation/blackfin/cachefeatures.txt |   65 +++++++++++
 MAINTAINERS                              |   40 +++++++
 5 files changed, 333 insertions(+)

diff -urN linux-2.6.18.patch3/Documentation/blackfin/00-INDEX
linux-2.6.18.patch4/Documentation/blackfin/00-INDEX
--- linux-2.6.18.patch3/Documentation/blackfin/00-INDEX	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/00-INDEX	2006-09-22
12:03:11.000000000 +0800
@@ -0,0 +1,11 @@
+00-INDEX
+	- This file
+
+cache-lock.txt
+	- HOWTO for blackfin cache locking.
+
+cachefeatures.txt
+	- Supported cache features.
+
+Filesystems
+	- Requirements for mounting the root file system.
diff -urN linux-2.6.18.patch3/Documentation/blackfin/Filesystems
linux-2.6.18.patch4/Documentation/blackfin/Filesystems
--- linux-2.6.18.patch3/Documentation/blackfin/Filesystems	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/Filesystems	2006-09-22
12:03:11.000000000 +0800
@@ -0,0 +1,169 @@
+/*
+ * File:         Documentation/blackfin/Filesystems
+ * Based on:
+ * Author:
+ *
+ * Created:
+ * Description:  This file contains the simple DMA Implementation for Blackfin
+ *
+ * Rev:          $Id: Filesystems,v 1.17 2006/08/08 20:46:13 vapier Exp $
+ *
+ * Modified:
+ *               Copyright 2004-2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ */
+
+		How to mount the root file system in uClinux/Blackfin
+		-----------------------------------------------------
+
+1	Mounting EXT3 File system.
+	------------------------
+
+	Creating an EXT3 File system for uClinux/Blackfin:
+
+
+Please follow the steps to form the EXT3 File system and mount the same as root
+file system.
+
+a	Make an ext3 file system as large as you want the final root file
+	system.
+
+		mkfs.ext3  /dev/ram0 <your-rootfs-size-in-1k-blocks>
+
+b	Mount this Empty file system on a free directory as:
+
+		mount -t ext3 /dev/ram0  ./test
+			where ./test is the empty directory.
+
+c	Copy your root fs directory that you have so carefully made over.
+
+		cp -af  /tmp/my_final_rootfs_files/* ./test
+
+		(For ex: cp -af uClinux-dist/romfs/* ./test)
+
+d	If you have done everything right till now you should be able to see
+	the required "root" dir's (that's etc, root, bin, lib, sbin...)
+
+e	Now unmount the file system
+
+		umount  ./test
+
+f	Create the root file system image.
+
+		dd if=/dev/ram0 bs=1k count=<your-rootfs-size-in-1k-blocks> \
+		> ext3fs.img
+
+
+Now you have to tell the kernel that will be mounting this file system as
+rootfs.
+So do a make menuconfig under kernel and select the Ext3 journaling file system
+support under File system --> submenu.
+
+
+2.	Mounting EXT2 File system.
+	-------------------------
+
+By default the ext2 file system image will be created if you invoke make from
+the top uClinux-dist directory.
+
+
+3.	Mounting CRAMFS File System
+	----------------------------
+
+To create a CRAMFS file system image execute the command
+
+	mkfs.cramfs ./test cramfs.img
+
+	where ./test is the target directory.
+
+
+4.	Mounting ROMFS File System
+	--------------------------
+
+To create a ROMFS file system image execute the command
+
+	genromfs -v -V "ROMdisk" -f romfs.img -d ./test
+
+	where ./test is the target directory
+
+
+5.	Mounting the JFFS2 Filesystem
+	-----------------------------
+
+To create a compressed JFFS filesystem (JFFS2), please execute the command
+
+	mkfs.jffs2 -d ./test -o jffs2.img
+
+	where ./test is the target directory.
+
+However, please make sure the following is in your kernel config.
+
+/*
+ * RAM/ROM/Flash chip drivers
+ */
+#define CONFIG_MTD_CFI 1
+#define CONFIG_MTD_ROM 1
+/*
+ * Mapping drivers for chip access
+ */
+#define CONFIG_MTD_COMPLEX_MAPPINGS 1
+#define CONFIG_MTD_BF533 1
+#undef CONFIG_MTD_UCLINUX
+
+Through the u-boot boot loader, use the jffs2.img in the corresponding
+partition made in linux-2.6.x/drivers/mtd/maps/bf533_flash.c.
+
+NOTE - 	Currently the Flash driver is available only for EZKIT. Watch out for a
+	STAMP driver soon.
+
+
+6. 	Mounting the NFS File system
+	-----------------------------
+
+	For mounting the NFS please do the following in the kernel config.
+
+	In Networking Support --> Networking options --> TCP/IP networking -->
+		IP: kernel level autoconfiguration
+
+	Enable BOOTP Support.
+
+	In Kernel hacking --> Compiled-in kernel boot parameter add the following
+
+		root=/dev/nfs rw ip=bootp
+
+	In File system --> Network File system, Enable
+
+		NFS file system support --> NFSv3 client support
+		Root File system on NFS
+
+	in uClibc menuconfig, do the following
+	In Networking Support
+		enable Remote Procedure Call (RPC) support
+			Full RPC Support
+
+	On the Host side, ensure that /etc/dhcpd.conf looks something like this
+
+		ddns-update-style ad-hoc;
+		allow bootp;
+		subnet 10.100.4.0 netmask 255.255.255.0 {
+		default-lease-time 122209600;
+		max-lease-time 31557600;
+		group {
+			host bf533 {
+				hardware ethernet 00:CF:52:49:C3:01;
+				fixed-address 10.100.4.50;
+				option root-path "/home/nfsmount";
+			}
+		}
+
+	ensure that /etc/exports looks something like this
+		/home/nfsmount *(rw,no_root_squash,no_all_squash)
+
+	 run the following commands as root (may differ depending on your
+	 distribution) :
+		-  service nfs start
+		-  service portmap start
+		-  service dhcpd start
+		-  /usr/sbin/exportfs
diff -urN linux-2.6.18.patch3/Documentation/blackfin/cache-lock.txt
linux-2.6.18.patch4/Documentation/blackfin/cache-lock.txt
--- linux-2.6.18.patch3/Documentation/blackfin/cache-lock.txt	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/cache-lock.txt	2006-09-22
12:03:11.000000000 +0800
@@ -0,0 +1,48 @@
+/*
+ * File:         Documentation/blackfin/cache-lock.txt
+ * Based on:
+ * Author:
+ *
+ * Created:
+ * Description:  This file contains the simple DMA Implementation for Blackfin
+ *
+ * Rev:          $Id: cache-lock.txt,v 1.17 2006/08/08 20:46:13 vapier Exp $
+ *
+ * Modified:
+ *               Copyright 2004-2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ */
+
+How to lock your code in cache in uClinux/blackfin
+--------------------------------------------------
+
+There are only a few steps required to lock your code into the cache.
+Currently you can lock the code by Way.
+
+Below are the interface provided for locking the cache.
+
+
+1. cache_grab_lock(int Ways);
+
+This function grab the lock for locking your code into the cache specified
+by Ways.
+
+
+2. cache_lock(int Ways);
+
+This function should be called after your critical code has been executed.
+Once the critical code exits, the code is now loaded into the cache. This
+function locks the code into the cache.
+
+
+So, the example sequence will be:
+
+	cache_grab_lock(WAY0_L);	/* Grab the lock */
+
+	critical_code();		/* Execute the code of interest */
+
+	cache_lock(WAY0_L);		/* Lock the cache */
+
+Where WAY0_L signifies WAY0 locking.
diff -urN linux-2.6.18.patch3/Documentation/blackfin/cachefeatures.txt
linux-2.6.18.patch4/Documentation/blackfin/cachefeatures.txt
--- linux-2.6.18.patch3/Documentation/blackfin/cachefeatures.txt	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/cachefeatures.txt	2006-09-22
12:03:11.000000000 +0800
@@ -0,0 +1,65 @@
+/*
+ * File:         Documentation/blackfin/cachefeatures.txt
+ * Based on:
+ * Author:
+ *
+ * Created:
+ * Description:  This file contains the simple DMA Implementation for Blackfin
+ *
+ * Rev:          $Id: cachefeatures.txt,v 1.17 2006/08/08 20:46:13 vapier Exp $
+ *
+ * Modified:
+ *               Copyright 2004-2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ */
+
+	- Instruction and Data cache initialization.
+		icache_init();
+		dcache_init();
+
+	-  Instruction and Data cache Invalidation Routines, when flushing the
+	   same is not required.
+		_icache_invalidate();
+		_dcache_invalidate();
+
+	Also, for invalidating the entire instruction and data cache, the below
+	routines are provided (another method for invalidation, refer page
no 267 and 287 of
+	ADSP-BF533 Hardware Reference manual)
+
+		invalidate_entire_dcache();
+		invalidate_entire_icache();
+
+	-External Flushing of Instruction and data cache routines.
+
+		flush_instruction_cache();
+		flush_data_cache();
+
+	- Internal Flushing of Instruction and Data Cache.
+
+		icplb_flush();
+		dcplb_flush();
+
+	- Locking the cache.
+
+		cache_grab_lock();
+		cache_lock();
+
+	Please refer linux-2.6.x/Documentation/blackfin/cache-lock.txt for how to
+	lock the cache.
+
+	Locking the cache is optional feature.
+
+	- Miscellaneous cache functions.
+
+		flush_cache_all();
+		flush_cache_mm();
+		invalidate_dcache_range();
+		flush_dcache_range();
+		flush_dcache_page();
+		flush_cache_range();
+		flush_cache_page();
+		invalidate_dcache_range();
+		flush_page_to_ram();
+
diff -urN linux-2.6.18.patch3/MAINTAINERS linux-2.6.18.patch4/MAINTAINERS
--- linux-2.6.18.patch3/MAINTAINERS	2006-09-21 16:03:37.000000000 +0800
+++ linux-2.6.18.patch4/MAINTAINERS	2006-09-22 12:09:32.000000000 +0800
@@ -481,6 +481,46 @@
 T:	git kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
 S:	Maintained

+BLACKFIN ARCHITECTURE
+P:     Aubrey Li
+M:     aubrey.li@analog.com
+P:     Bernd Schmidt
+M:     bernd.schmidt@analog.com
+P:     Grace Pan
+M:     grace.pan@analog.com
+P:     Michael Hennerich
+M:     michael.hennerich@analog.com
+P:     Mike Frysinger
+M:     michael.frysinger@analog.com
+P:     Jean Lv
+M:     jean.lv@analog.com
+P:     Jerry Zeng
+M:     jerry.zeng@analog.com
+P:     Jie Zhang
+M:     jie.zhang@analog.com
+P:     Luke Yang
+M:     luke.adi@gmail.com
+P:     Robin Getz
+M:     robin.getz@analog.com
+P:     Roy Huang
+M:     roy.huang@analog.com
+P:     Sonic Zhang
+M:     sonic.zhang@analog.com
+P:     Yi Li
+M:     yi.li@analog.com
+L:     linux-kernel@vger.kernel.org
+L:     uclinux533-devel@blackfin.uclinux.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
+BLACKFIN SERIAL DRIVER
+P:     Aubrey Li
+M:     aubrey.li@analog.com
+L:     linux-kernel@vger.kernel.org
+L:     uclinux533-devel@blackfin.uclinux.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
 BLUETOOTH SUBSYSTEM
 P:	Marcel Holtmann
 M:	marcel@holtmann.org

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_377_2773843.1158901509162
Content-Type: text/x-patch; name=blackfin_documents_maintainer.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ese3w9mt
Content-Disposition: attachment; filename="blackfin_documents_maintainer.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFja2Zpbi8wMC1J
TkRFWCBsaW51eC0yLjYuMTgucGF0Y2g0L0RvY3VtZW50YXRpb24vYmxhY2tmaW4vMDAtSU5ERVgK
LS0tIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFja2Zpbi8wMC1JTkRFWAkx
OTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNo
NC9Eb2N1bWVudGF0aW9uL2JsYWNrZmluLzAwLUlOREVYCTIwMDYtMDktMjIgMTI6MDM6MTEuMDAw
MDAwMDAwICswODAwCkBAIC0wLDAgKzEsMTEgQEAKKzAwLUlOREVYCisJLSBUaGlzIGZpbGUKKwor
Y2FjaGUtbG9jay50eHQKKwktIEhPV1RPIGZvciBibGFja2ZpbiBjYWNoZSBsb2NraW5nLgorCitj
YWNoZWZlYXR1cmVzLnR4dAorCS0gU3VwcG9ydGVkIGNhY2hlIGZlYXR1cmVzLgorCitGaWxlc3lz
dGVtcworCS0gUmVxdWlyZW1lbnRzIGZvciBtb3VudGluZyB0aGUgcm9vdCBmaWxlIHN5c3RlbS4K
ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFja2Zpbi9GaWxl
c3lzdGVtcyBsaW51eC0yLjYuMTgucGF0Y2g0L0RvY3VtZW50YXRpb24vYmxhY2tmaW4vRmlsZXN5
c3RlbXMKLS0tIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFja2Zpbi9GaWxl
c3lzdGVtcwkxOTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42
LjE4LnBhdGNoNC9Eb2N1bWVudGF0aW9uL2JsYWNrZmluL0ZpbGVzeXN0ZW1zCTIwMDYtMDktMjIg
MTI6MDM6MTEuMDAwMDAwMDAwICswODAwCkBAIC0wLDAgKzEsMTY5IEBACisvKgorICogRmlsZTog
ICAgICAgICBEb2N1bWVudGF0aW9uL2JsYWNrZmluL0ZpbGVzeXN0ZW1zCisgKiBCYXNlZCBvbjoK
KyAqIEF1dGhvcjoKKyAqCisgKiBDcmVhdGVkOgorICogRGVzY3JpcHRpb246ICBUaGlzIGZpbGUg
Y29udGFpbnMgdGhlIHNpbXBsZSBETUEgSW1wbGVtZW50YXRpb24gZm9yIEJsYWNrZmluCisgKgor
ICogUmV2OiAgICAgICAgICAkSWQ6IEZpbGVzeXN0ZW1zLHYgMS4xNyAyMDA2LzA4LzA4IDIwOjQ2
OjEzIHZhcGllciBFeHAgJAorICoKKyAqIE1vZGlmaWVkOgorICogICAgICAgICAgICAgICBDb3B5
cmlnaHQgMjAwNC0yMDA2IEFuYWxvZyBEZXZpY2VzIEluYy4KKyAqCisgKiBCdWdzOiAgICAgICAg
IEVudGVyIGJ1Z3MgYXQgaHR0cDovL2JsYWNrZmluLnVjbGludXgub3JnLworICoKKyAqLworCisJ
CUhvdyB0byBtb3VudCB0aGUgcm9vdCBmaWxlIHN5c3RlbSBpbiB1Q2xpbnV4L0JsYWNrZmluCisJ
CS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisK
KzEJTW91bnRpbmcgRVhUMyBGaWxlIHN5c3RlbS4KKwktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
KworCUNyZWF0aW5nIGFuIEVYVDMgRmlsZSBzeXN0ZW0gZm9yIHVDbGludXgvQmxhY2tmaW46CisK
KworUGxlYXNlIGZvbGxvdyB0aGUgc3RlcHMgdG8gZm9ybSB0aGUgRVhUMyBGaWxlIHN5c3RlbSBh
bmQgbW91bnQgdGhlIHNhbWUgYXMgcm9vdAorZmlsZSBzeXN0ZW0uCisKK2EJTWFrZSBhbiBleHQz
IGZpbGUgc3lzdGVtIGFzIGxhcmdlIGFzIHlvdSB3YW50IHRoZSBmaW5hbCByb290IGZpbGUKKwlz
eXN0ZW0uCisKKwkJbWtmcy5leHQzICAvZGV2L3JhbTAgPHlvdXItcm9vdGZzLXNpemUtaW4tMWst
YmxvY2tzPgorCitiCU1vdW50IHRoaXMgRW1wdHkgZmlsZSBzeXN0ZW0gb24gYSBmcmVlIGRpcmVj
dG9yeSBhczoKKworCQltb3VudCAtdCBleHQzIC9kZXYvcmFtMCAgLi90ZXN0CisJCQl3aGVyZSAu
L3Rlc3QgaXMgdGhlIGVtcHR5IGRpcmVjdG9yeS4KKworYwlDb3B5IHlvdXIgcm9vdCBmcyBkaXJl
Y3RvcnkgdGhhdCB5b3UgaGF2ZSBzbyBjYXJlZnVsbHkgbWFkZSBvdmVyLgorCisJCWNwIC1hZiAg
L3RtcC9teV9maW5hbF9yb290ZnNfZmlsZXMvKiAuL3Rlc3QKKworCQkoRm9yIGV4OiBjcCAtYWYg
dUNsaW51eC1kaXN0L3JvbWZzLyogLi90ZXN0KQorCitkCUlmIHlvdSBoYXZlIGRvbmUgZXZlcnl0
aGluZyByaWdodCB0aWxsIG5vdyB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gc2VlCisJdGhlIHJlcXVp
cmVkICJyb290IiBkaXIncyAodGhhdCdzIGV0Yywgcm9vdCwgYmluLCBsaWIsIHNiaW4uLi4pCisK
K2UJTm93IHVubW91bnQgdGhlIGZpbGUgc3lzdGVtCisKKwkJdW1vdW50ICAuL3Rlc3QKKworZglD
cmVhdGUgdGhlIHJvb3QgZmlsZSBzeXN0ZW0gaW1hZ2UuCisKKwkJZGQgaWY9L2Rldi9yYW0wIGJz
PTFrIGNvdW50PTx5b3VyLXJvb3Rmcy1zaXplLWluLTFrLWJsb2Nrcz4gXAorCQk+IGV4dDNmcy5p
bWcKKworCitOb3cgeW91IGhhdmUgdG8gdGVsbCB0aGUga2VybmVsIHRoYXQgd2lsbCBiZSBtb3Vu
dGluZyB0aGlzIGZpbGUgc3lzdGVtIGFzCityb290ZnMuCitTbyBkbyBhIG1ha2UgbWVudWNvbmZp
ZyB1bmRlciBrZXJuZWwgYW5kIHNlbGVjdCB0aGUgRXh0MyBqb3VybmFsaW5nIGZpbGUgc3lzdGVt
CitzdXBwb3J0IHVuZGVyIEZpbGUgc3lzdGVtIC0tPiBzdWJtZW51LgorCisKKzIuCU1vdW50aW5n
IEVYVDIgRmlsZSBzeXN0ZW0uCisJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCitCeSBkZWZh
dWx0IHRoZSBleHQyIGZpbGUgc3lzdGVtIGltYWdlIHdpbGwgYmUgY3JlYXRlZCBpZiB5b3UgaW52
b2tlIG1ha2UgZnJvbQordGhlIHRvcCB1Q2xpbnV4LWRpc3QgZGlyZWN0b3J5LgorCisKKzMuCU1v
dW50aW5nIENSQU1GUyBGaWxlIFN5c3RlbQorCS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
KworVG8gY3JlYXRlIGEgQ1JBTUZTIGZpbGUgc3lzdGVtIGltYWdlIGV4ZWN1dGUgdGhlIGNvbW1h
bmQKKworCW1rZnMuY3JhbWZzIC4vdGVzdCBjcmFtZnMuaW1nCisKKwl3aGVyZSAuL3Rlc3QgaXMg
dGhlIHRhcmdldCBkaXJlY3RvcnkuCisKKworNC4JTW91bnRpbmcgUk9NRlMgRmlsZSBTeXN0ZW0K
KwktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCitUbyBjcmVhdGUgYSBST01GUyBmaWxlIHN5
c3RlbSBpbWFnZSBleGVjdXRlIHRoZSBjb21tYW5kCisKKwlnZW5yb21mcyAtdiAtViAiUk9NZGlz
ayIgLWYgcm9tZnMuaW1nIC1kIC4vdGVzdAorCisJd2hlcmUgLi90ZXN0IGlzIHRoZSB0YXJnZXQg
ZGlyZWN0b3J5CisKKworNS4JTW91bnRpbmcgdGhlIEpGRlMyIEZpbGVzeXN0ZW0KKwktLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCitUbyBjcmVhdGUgYSBjb21wcmVzc2VkIEpGRlMgZmls
ZXN5c3RlbSAoSkZGUzIpLCBwbGVhc2UgZXhlY3V0ZSB0aGUgY29tbWFuZAorCisJbWtmcy5qZmZz
MiAtZCAuL3Rlc3QgLW8gamZmczIuaW1nCisKKwl3aGVyZSAuL3Rlc3QgaXMgdGhlIHRhcmdldCBk
aXJlY3RvcnkuCisKK0hvd2V2ZXIsIHBsZWFzZSBtYWtlIHN1cmUgdGhlIGZvbGxvd2luZyBpcyBp
biB5b3VyIGtlcm5lbCBjb25maWcuCisKKy8qCisgKiBSQU0vUk9NL0ZsYXNoIGNoaXAgZHJpdmVy
cworICovCisjZGVmaW5lIENPTkZJR19NVERfQ0ZJIDEKKyNkZWZpbmUgQ09ORklHX01URF9ST00g
MQorLyoKKyAqIE1hcHBpbmcgZHJpdmVycyBmb3IgY2hpcCBhY2Nlc3MKKyAqLworI2RlZmluZSBD
T05GSUdfTVREX0NPTVBMRVhfTUFQUElOR1MgMQorI2RlZmluZSBDT05GSUdfTVREX0JGNTMzIDEK
KyN1bmRlZiBDT05GSUdfTVREX1VDTElOVVgKKworVGhyb3VnaCB0aGUgdS1ib290IGJvb3QgbG9h
ZGVyLCB1c2UgdGhlIGpmZnMyLmltZyBpbiB0aGUgY29ycmVzcG9uZGluZworcGFydGl0aW9uIG1h
ZGUgaW4gbGludXgtMi42LngvZHJpdmVycy9tdGQvbWFwcy9iZjUzM19mbGFzaC5jLgorCitOT1RF
IC0gCUN1cnJlbnRseSB0aGUgRmxhc2ggZHJpdmVyIGlzIGF2YWlsYWJsZSBvbmx5IGZvciBFWktJ
VC4gV2F0Y2ggb3V0IGZvciBhCisJU1RBTVAgZHJpdmVyIHNvb24uCisKKworNi4gCU1vdW50aW5n
IHRoZSBORlMgRmlsZSBzeXN0ZW0KKwktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCisJ
Rm9yIG1vdW50aW5nIHRoZSBORlMgcGxlYXNlIGRvIHRoZSBmb2xsb3dpbmcgaW4gdGhlIGtlcm5l
bCBjb25maWcuCisKKwlJbiBOZXR3b3JraW5nIFN1cHBvcnQgLS0+IE5ldHdvcmtpbmcgb3B0aW9u
cyAtLT4gVENQL0lQIG5ldHdvcmtpbmcgLS0+CisJCUlQOiBrZXJuZWwgbGV2ZWwgYXV0b2NvbmZp
Z3VyYXRpb24KKworCUVuYWJsZSBCT09UUCBTdXBwb3J0LgorCisJSW4gS2VybmVsIGhhY2tpbmcg
LS0+IENvbXBpbGVkLWluIGtlcm5lbCBib290IHBhcmFtZXRlciBhZGQgdGhlIGZvbGxvd2luZwor
CisJCXJvb3Q9L2Rldi9uZnMgcncgaXA9Ym9vdHAKKworCUluIEZpbGUgc3lzdGVtIC0tPiBOZXR3
b3JrIEZpbGUgc3lzdGVtLCBFbmFibGUKKworCQlORlMgZmlsZSBzeXN0ZW0gc3VwcG9ydCAtLT4g
TkZTdjMgY2xpZW50IHN1cHBvcnQKKwkJUm9vdCBGaWxlIHN5c3RlbSBvbiBORlMKKworCWluIHVD
bGliYyBtZW51Y29uZmlnLCBkbyB0aGUgZm9sbG93aW5nCisJSW4gTmV0d29ya2luZyBTdXBwb3J0
CisJCWVuYWJsZSBSZW1vdGUgUHJvY2VkdXJlIENhbGwgKFJQQykgc3VwcG9ydAorCQkJRnVsbCBS
UEMgU3VwcG9ydAorCisJT24gdGhlIEhvc3Qgc2lkZSwgZW5zdXJlIHRoYXQgL2V0Yy9kaGNwZC5j
b25mIGxvb2tzIHNvbWV0aGluZyBsaWtlIHRoaXMKKworCQlkZG5zLXVwZGF0ZS1zdHlsZSBhZC1o
b2M7CisJCWFsbG93IGJvb3RwOworCQlzdWJuZXQgMTAuMTAwLjQuMCBuZXRtYXNrIDI1NS4yNTUu
MjU1LjAgeworCQlkZWZhdWx0LWxlYXNlLXRpbWUgMTIyMjA5NjAwOworCQltYXgtbGVhc2UtdGlt
ZSAzMTU1NzYwMDsKKwkJZ3JvdXAgeworCQkJaG9zdCBiZjUzMyB7CisJCQkJaGFyZHdhcmUgZXRo
ZXJuZXQgMDA6Q0Y6NTI6NDk6QzM6MDE7CisJCQkJZml4ZWQtYWRkcmVzcyAxMC4xMDAuNC41MDsK
KwkJCQlvcHRpb24gcm9vdC1wYXRoICIvaG9tZS9uZnNtb3VudCI7CisJCQl9CisJCX0KKworCWVu
c3VyZSB0aGF0IC9ldGMvZXhwb3J0cyBsb29rcyBzb21ldGhpbmcgbGlrZSB0aGlzCisJCS9ob21l
L25mc21vdW50ICoocncsbm9fcm9vdF9zcXVhc2gsbm9fYWxsX3NxdWFzaCkKKworCSBydW4gdGhl
IGZvbGxvd2luZyBjb21tYW5kcyBhcyByb290IChtYXkgZGlmZmVyIGRlcGVuZGluZyBvbiB5b3Vy
CisJIGRpc3RyaWJ1dGlvbikgOgorCQktICBzZXJ2aWNlIG5mcyBzdGFydAorCQktICBzZXJ2aWNl
IHBvcnRtYXAgc3RhcnQKKwkJLSAgc2VydmljZSBkaGNwZCBzdGFydAorCQktICAvdXNyL3NiaW4v
ZXhwb3J0ZnMKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFj
a2Zpbi9jYWNoZS1sb2NrLnR4dCBsaW51eC0yLjYuMTgucGF0Y2g0L0RvY3VtZW50YXRpb24vYmxh
Y2tmaW4vY2FjaGUtbG9jay50eHQKLS0tIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9jdW1lbnRhdGlv
bi9ibGFja2Zpbi9jYWNoZS1sb2NrLnR4dAkxOTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAwMCAr
MDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoNC9Eb2N1bWVudGF0aW9uL2JsYWNrZmluL2NhY2hl
LWxvY2sudHh0CTIwMDYtMDktMjIgMTI6MDM6MTEuMDAwMDAwMDAwICswODAwCkBAIC0wLDAgKzEs
NDggQEAKKy8qCisgKiBGaWxlOiAgICAgICAgIERvY3VtZW50YXRpb24vYmxhY2tmaW4vY2FjaGUt
bG9jay50eHQKKyAqIEJhc2VkIG9uOgorICogQXV0aG9yOgorICoKKyAqIENyZWF0ZWQ6CisgKiBE
ZXNjcmlwdGlvbjogIFRoaXMgZmlsZSBjb250YWlucyB0aGUgc2ltcGxlIERNQSBJbXBsZW1lbnRh
dGlvbiBmb3IgQmxhY2tmaW4KKyAqCisgKiBSZXY6ICAgICAgICAgICRJZDogY2FjaGUtbG9jay50
eHQsdiAxLjE3IDIwMDYvMDgvMDggMjA6NDY6MTMgdmFwaWVyIEV4cCAkCisgKgorICogTW9kaWZp
ZWQ6CisgKiAgICAgICAgICAgICAgIENvcHlyaWdodCAyMDA0LTIwMDYgQW5hbG9nIERldmljZXMg
SW5jLgorICoKKyAqIEJ1Z3M6ICAgICAgICAgRW50ZXIgYnVncyBhdCBodHRwOi8vYmxhY2tmaW4u
dWNsaW51eC5vcmcvCisgKgorICovCisKK0hvdyB0byBsb2NrIHlvdXIgY29kZSBpbiBjYWNoZSBp
biB1Q2xpbnV4L2JsYWNrZmluCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQorCitUaGVyZSBhcmUgb25seSBhIGZldyBzdGVwcyByZXF1aXJlZCB0byBs
b2NrIHlvdXIgY29kZSBpbnRvIHRoZSBjYWNoZS4KK0N1cnJlbnRseSB5b3UgY2FuIGxvY2sgdGhl
IGNvZGUgYnkgV2F5LgorCitCZWxvdyBhcmUgdGhlIGludGVyZmFjZSBwcm92aWRlZCBmb3IgbG9j
a2luZyB0aGUgY2FjaGUuCisKKworMS4gY2FjaGVfZ3JhYl9sb2NrKGludCBXYXlzKTsKKworVGhp
cyBmdW5jdGlvbiBncmFiIHRoZSBsb2NrIGZvciBsb2NraW5nIHlvdXIgY29kZSBpbnRvIHRoZSBj
YWNoZSBzcGVjaWZpZWQKK2J5IFdheXMuCisKKworMi4gY2FjaGVfbG9jayhpbnQgV2F5cyk7CisK
K1RoaXMgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZCBhZnRlciB5b3VyIGNyaXRpY2FsIGNvZGUg
aGFzIGJlZW4gZXhlY3V0ZWQuCitPbmNlIHRoZSBjcml0aWNhbCBjb2RlIGV4aXRzLCB0aGUgY29k
ZSBpcyBub3cgbG9hZGVkIGludG8gdGhlIGNhY2hlLiBUaGlzCitmdW5jdGlvbiBsb2NrcyB0aGUg
Y29kZSBpbnRvIHRoZSBjYWNoZS4KKworCitTbywgdGhlIGV4YW1wbGUgc2VxdWVuY2Ugd2lsbCBi
ZToKKworCWNhY2hlX2dyYWJfbG9jayhXQVkwX0wpOwkvKiBHcmFiIHRoZSBsb2NrICovCisKKwlj
cml0aWNhbF9jb2RlKCk7CQkvKiBFeGVjdXRlIHRoZSBjb2RlIG9mIGludGVyZXN0ICovCisKKwlj
YWNoZV9sb2NrKFdBWTBfTCk7CQkvKiBMb2NrIHRoZSBjYWNoZSAqLworCitXaGVyZSBXQVkwX0wg
c2lnbmlmaWVzIFdBWTAgbG9ja2luZy4KZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDMvRG9j
dW1lbnRhdGlvbi9ibGFja2Zpbi9jYWNoZWZlYXR1cmVzLnR4dCBsaW51eC0yLjYuMTgucGF0Y2g0
L0RvY3VtZW50YXRpb24vYmxhY2tmaW4vY2FjaGVmZWF0dXJlcy50eHQKLS0tIGxpbnV4LTIuNi4x
OC5wYXRjaDMvRG9jdW1lbnRhdGlvbi9ibGFja2Zpbi9jYWNoZWZlYXR1cmVzLnR4dAkxOTcwLTAx
LTAxIDA4OjAwOjAwLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoNC9Eb2N1
bWVudGF0aW9uL2JsYWNrZmluL2NhY2hlZmVhdHVyZXMudHh0CTIwMDYtMDktMjIgMTI6MDM6MTEu
MDAwMDAwMDAwICswODAwCkBAIC0wLDAgKzEsNjUgQEAKKy8qCisgKiBGaWxlOiAgICAgICAgIERv
Y3VtZW50YXRpb24vYmxhY2tmaW4vY2FjaGVmZWF0dXJlcy50eHQKKyAqIEJhc2VkIG9uOgorICog
QXV0aG9yOgorICoKKyAqIENyZWF0ZWQ6CisgKiBEZXNjcmlwdGlvbjogIFRoaXMgZmlsZSBjb250
YWlucyB0aGUgc2ltcGxlIERNQSBJbXBsZW1lbnRhdGlvbiBmb3IgQmxhY2tmaW4KKyAqCisgKiBS
ZXY6ICAgICAgICAgICRJZDogY2FjaGVmZWF0dXJlcy50eHQsdiAxLjE3IDIwMDYvMDgvMDggMjA6
NDY6MTMgdmFwaWVyIEV4cCAkCisgKgorICogTW9kaWZpZWQ6CisgKiAgICAgICAgICAgICAgIENv
cHlyaWdodCAyMDA0LTIwMDYgQW5hbG9nIERldmljZXMgSW5jLgorICoKKyAqIEJ1Z3M6ICAgICAg
ICAgRW50ZXIgYnVncyBhdCBodHRwOi8vYmxhY2tmaW4udWNsaW51eC5vcmcvCisgKgorICovCisK
KwktIEluc3RydWN0aW9uIGFuZCBEYXRhIGNhY2hlIGluaXRpYWxpemF0aW9uLgorCQlpY2FjaGVf
aW5pdCgpOworCQlkY2FjaGVfaW5pdCgpOworCisJLSAgSW5zdHJ1Y3Rpb24gYW5kIERhdGEgY2Fj
aGUgSW52YWxpZGF0aW9uIFJvdXRpbmVzLCB3aGVuIGZsdXNoaW5nIHRoZQorCSAgIHNhbWUgaXMg
bm90IHJlcXVpcmVkLgorCQlfaWNhY2hlX2ludmFsaWRhdGUoKTsKKwkJX2RjYWNoZV9pbnZhbGlk
YXRlKCk7CisKKwlBbHNvLCBmb3IgaW52YWxpZGF0aW5nIHRoZSBlbnRpcmUgaW5zdHJ1Y3Rpb24g
YW5kIGRhdGEgY2FjaGUsIHRoZSBiZWxvdworCXJvdXRpbmVzIGFyZSBwcm92aWRlZCAoYW5vdGhl
ciBtZXRob2QgZm9yIGludmFsaWRhdGlvbiwgcmVmZXIgcGFnZSBubyAyNjcgYW5kIDI4NyBvZgor
CUFEU1AtQkY1MzMgSGFyZHdhcmUgUmVmZXJlbmNlIG1hbnVhbCkKKworCQlpbnZhbGlkYXRlX2Vu
dGlyZV9kY2FjaGUoKTsKKwkJaW52YWxpZGF0ZV9lbnRpcmVfaWNhY2hlKCk7CisKKwktRXh0ZXJu
YWwgRmx1c2hpbmcgb2YgSW5zdHJ1Y3Rpb24gYW5kIGRhdGEgY2FjaGUgcm91dGluZXMuCisKKwkJ
Zmx1c2hfaW5zdHJ1Y3Rpb25fY2FjaGUoKTsKKwkJZmx1c2hfZGF0YV9jYWNoZSgpOworCisJLSBJ
bnRlcm5hbCBGbHVzaGluZyBvZiBJbnN0cnVjdGlvbiBhbmQgRGF0YSBDYWNoZS4KKworCQlpY3Bs
Yl9mbHVzaCgpOworCQlkY3BsYl9mbHVzaCgpOworCisJLSBMb2NraW5nIHRoZSBjYWNoZS4KKwor
CQljYWNoZV9ncmFiX2xvY2soKTsKKwkJY2FjaGVfbG9jaygpOworCisJUGxlYXNlIHJlZmVyIGxp
bnV4LTIuNi54L0RvY3VtZW50YXRpb24vYmxhY2tmaW4vY2FjaGUtbG9jay50eHQgZm9yIGhvdyB0
bworCWxvY2sgdGhlIGNhY2hlLgorCisJTG9ja2luZyB0aGUgY2FjaGUgaXMgb3B0aW9uYWwgZmVh
dHVyZS4KKworCS0gTWlzY2VsbGFuZW91cyBjYWNoZSBmdW5jdGlvbnMuCisKKwkJZmx1c2hfY2Fj
aGVfYWxsKCk7CisJCWZsdXNoX2NhY2hlX21tKCk7CisJCWludmFsaWRhdGVfZGNhY2hlX3Jhbmdl
KCk7CisJCWZsdXNoX2RjYWNoZV9yYW5nZSgpOworCQlmbHVzaF9kY2FjaGVfcGFnZSgpOworCQlm
bHVzaF9jYWNoZV9yYW5nZSgpOworCQlmbHVzaF9jYWNoZV9wYWdlKCk7CisJCWludmFsaWRhdGVf
ZGNhY2hlX3JhbmdlKCk7CisJCWZsdXNoX3BhZ2VfdG9fcmFtKCk7CisKZGlmZiAtdXJOIGxpbnV4
LTIuNi4xOC5wYXRjaDMvTUFJTlRBSU5FUlMgbGludXgtMi42LjE4LnBhdGNoNC9NQUlOVEFJTkVS
UwotLS0gbGludXgtMi42LjE4LnBhdGNoMy9NQUlOVEFJTkVSUwkyMDA2LTA5LTIxIDE2OjAzOjM3
LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoNC9NQUlOVEFJTkVSUwkyMDA2
LTA5LTIyIDEyOjA5OjMyLjAwMDAwMDAwMCArMDgwMApAQCAtNDgxLDYgKzQ4MSw0NiBAQAogVDoJ
Z2l0IGtlcm5lbC5vcmc6L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9heGJvZS9saW51eC0yLjYt
YmxvY2suZ2l0CiBTOglNYWludGFpbmVkCiAKK0JMQUNLRklOIEFSQ0hJVEVDVFVSRQorUDogICAg
IEF1YnJleSBMaQorTTogICAgIGF1YnJleS5saUBhbmFsb2cuY29tCitQOiAgICAgQmVybmQgU2No
bWlkdAorTTogICAgIGJlcm5kLnNjaG1pZHRAYW5hbG9nLmNvbQorUDogICAgIEdyYWNlIFBhbgor
TTogICAgIGdyYWNlLnBhbkBhbmFsb2cuY29tCitQOiAgICAgTWljaGFlbCBIZW5uZXJpY2gKK006
ICAgICBtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tCitQOiAgICAgTWlrZSBGcnlzaW5nZXIK
K006ICAgICBtaWNoYWVsLmZyeXNpbmdlckBhbmFsb2cuY29tCitQOiAgICAgSmVhbiBMdgorTTog
ICAgIGplYW4ubHZAYW5hbG9nLmNvbQorUDogICAgIEplcnJ5IFplbmcKK006ICAgICBqZXJyeS56
ZW5nQGFuYWxvZy5jb20KK1A6ICAgICBKaWUgWmhhbmcKK006ICAgICBqaWUuemhhbmdAYW5hbG9n
LmNvbQorUDogICAgIEx1a2UgWWFuZworTTogICAgIGx1a2UuYWRpQGdtYWlsLmNvbQorUDogICAg
IFJvYmluIEdldHoKK006ICAgICByb2Jpbi5nZXR6QGFuYWxvZy5jb20KK1A6ICAgICBSb3kgSHVh
bmcKK006ICAgICByb3kuaHVhbmdAYW5hbG9nLmNvbQorUDogICAgIFNvbmljIFpoYW5nCitNOiAg
ICAgc29uaWMuemhhbmdAYW5hbG9nLmNvbQorUDogICAgIFlpIExpCitNOiAgICAgeWkubGlAYW5h
bG9nLmNvbQorTDogICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKK0w6ICAgICB1Y2xp
bnV4NTMzLWRldmVsQGJsYWNrZmluLnVjbGludXgub3JnCitXOiAgICAgaHR0cDovL2JsYWNrZmlu
LnVjbGludXgub3JnCitTOiAgICAgU3VwcG9ydGVkCisKK0JMQUNLRklOIFNFUklBTCBEUklWRVIK
K1A6ICAgICBBdWJyZXkgTGkKK006ICAgICBhdWJyZXkubGlAYW5hbG9nLmNvbQorTDogICAgIGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKK0w6ICAgICB1Y2xpbnV4NTMzLWRldmVsQGJsYWNr
ZmluLnVjbGludXgub3JnCitXOiAgICAgaHR0cDovL2JsYWNrZmluLnVjbGludXgub3JnCitTOiAg
ICAgU3VwcG9ydGVkCisKIEJMVUVUT09USCBTVUJTWVNURU0KIFA6CU1hcmNlbCBIb2x0bWFubgog
TToJbWFyY2VsQGhvbHRtYW5uLm9yZwo=
------=_Part_377_2773843.1158901509162--
