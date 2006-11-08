Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754351AbWKHGTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbWKHGTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 01:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbWKHGTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 01:19:52 -0500
Received: from www.wytron.com.tw ([211.75.82.101]:12776 "EHLO
	fc4.wytron.com.tw") by vger.kernel.org with ESMTP id S1754354AbWKHGTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 01:19:51 -0500
Message-ID: <455176F9.4080903@wytron.com.tw>
Date: Wed, 08 Nov 2006 14:19:37 +0800
From: Thomas Chou <thomas@wytron.com.tw>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060425)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs : handle more than one source dir or file list
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Chou <thomas@wytron.com.tw>

Handle more than one source dir or file list to the initramfs gen scripts.

Signed-off-by: Thomas Chou <thomas@wytron.com.tw>
---
Bug ID 7401, updated

diff -uprN -X linux-2.6.19-rc3-vanilla/Documentation/dontdiff 
linux-2.6.19-rc3-vanilla/scripts/gen_initramfs_list.sh 
linux-2.6.19-rc3/scripts/gen_initramfs_list.sh
--- linux-2.6.19-rc3-vanilla/scripts/gen_initramfs_list.sh    2006-09-20 
11:42:06.000000000 +0800
+++ linux-2.6.19-rc3/scripts/gen_initramfs_list.sh    2006-10-25 
09:59:28.000000000 +0800
@@ -158,7 +158,7 @@ unknown_option() {
 }
 
 list_header() {
-    echo "deps_initramfs := \\"
+       :
 }
 
 header() {
@@ -227,6 +227,7 @@ arg="$1"
 case "$arg" in
     "-l")    # files included in initramfs - used by kbuild
         dep_list="list_"
+        echo "deps_initramfs := \\"
         shift
         ;;
     "-o")    # generate gzipped cpio image named $1
diff -uprN -X linux-2.6.19-rc3-vanilla/Documentation/dontdiff 
linux-2.6.19-rc3-vanilla/usr/Makefile linux-2.6.19-rc3/usr/Makefile
--- linux-2.6.19-rc3-vanilla/usr/Makefile    2006-10-25 
09:53:54.000000000 +0800
+++ linux-2.6.19-rc3/usr/Makefile    2006-10-25 09:58:41.000000000 +0800
@@ -20,7 +20,7 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 hostprogs-y := gen_init_cpio
 initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
-                    $(CONFIG_INITRAMFS_SOURCE),-d)
+                    $(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u 
$(CONFIG_INITRAMFS_ROOT_UID)) \
         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))

