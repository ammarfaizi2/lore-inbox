Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbVCDXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbVCDXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbVCDXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:39:12 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:2208 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263196AbVCDVmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:42:25 -0500
Subject: [PATCH] NFS can be selected without exportfs
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1109972635.3772.287.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 08:43:55 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

NFS depends on ExportFS, and could do with a SELECT in the Kconfig.
Without it compilation fails. Quote from Peter:

"I get an error while compiling, the same config worked for earlier 
releases for 2.6.11-rc2.
applied patches:
2.6.11-rc3
swsusp2 2.1.6 for 2.6.11-rc3
OS: debian unstable
gcc version: gcc (GCC) 3.3.5 (Debian 1:3.3.5-8)

   LD      init/built-in.o
   LD      .tmp_vmlinux1
fs/built-in.o(.text+0x7329f): In function `fh_verify':
: undefined reference to `export_op_default'
fs/built-in.o(.text+0x738b7): In function `fh_compose':
: undefined reference to `export_op_default'
fs/built-in.o(.text+0x73bb7): In function `fh_update':
: undefined reference to `export_op_default'
fs/built-in.o(.text+0x73e80): In function `_fh_update':
: undefined reference to `export_op_default'
fs/built-in.o(.text+0x78150): In function `check_export':
: undefined reference to `find_exported_dentry'
make[1]: *** [.tmp_vmlinux1] Error 1

thx
Peter"

Submitted-By: Peter Frühberger <Peter.Fruehberger@t-online.de>
Signed-Off-By: Nigel Cunningham <ncunningham@linuxmail.org>

diff -ruNp 990-select-exportfs-on-nfs-server-old/fs/Kconfig 990-select-exportfs-on-nfs-server-new/fs/Kconfig
--- 990-select-exportfs-on-nfs-server-old/fs/Kconfig	2005-02-03 22:33:40.000000000 +1100
+++ 990-select-exportfs-on-nfs-server-new/fs/Kconfig	2005-02-06 08:22:25.000000000 +1100
@@ -1400,6 +1400,7 @@ config NFSD
 	tristate "NFS server support"
 	depends on INET
 	select LOCKD
+	select EXPORTFS
 	select SUNRPC
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


