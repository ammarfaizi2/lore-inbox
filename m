Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWJYGpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWJYGpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423064AbWJYGpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:45:55 -0400
Received: from web18607.mail.tpe.yahoo.com ([203.84.195.104]:57993 "HELO
	web18607.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id S1423028AbWJYGpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:45:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.tw;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fFIFGh6FxE1/wQlM0XVHrMVl1p/g1zLwoM41DXWUb3OA2Ch4Bl5zLWsuY9ZI6GAQVKjRAAb/7UO4N9BLd+B34NBGIfr6XTHZrD8K9VWQZNMzrDQ5EaJPYfRIdZ1xdBcm2HCfuBOM3Hx5Z/wo4fD8NNc3CT0rXeEqs4bPEbd6ZwY=  ;
Message-ID: <20061025064552.4324.qmail@web18607.mail.tpe.yahoo.com>
Date: Wed, 25 Oct 2006 14:45:52 +0800 (CST)
From: hippo5329 <hippo5329@yahoo.com.tw>
Subject: [PATCH] initramfs : handle more than one source dir or file
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Chou <hippo5329@yahoo.com.tw>

Handle more than one source dir or filelist to the initramfs gen scripts.

Signed-off-by: Thomas Chou <hippo5329@yahoo.com.tw>
---
Bug ID 7401, updated

diff -uprN -X linux-2.6.19-rc3-vanilla/Documentation/dontdiff linux-2.6.19-rc3-vanilla/scripts/gen_initramfs_list.sh linux-2.6.19-rc3/scripts/gen_initramfs_list.sh
--- linux-2.6.19-rc3-vanilla/scripts/gen_initramfs_list.sh    2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.19-rc3/scripts/gen_initramfs_list.sh    2006-10-25 09:59:28.000000000 +0800
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
diff -uprN -X linux-2.6.19-rc3-vanilla/Documentation/dontdiff linux-2.6.19-rc3-vanilla/usr/Makefile linux-2.6.19-rc3/usr/Makefile
--- linux-2.6.19-rc3-vanilla/usr/Makefile    2006-10-25 09:53:54.000000000 +0800
+++ linux-2.6.19-rc3/usr/Makefile    2006-10-25 09:58:41.000000000 +0800
@@ -20,7 +20,7 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 hostprogs-y := gen_init_cpio
 initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
-                    $(CONFIG_INITRAMFS_SOURCE),-d)
+                    $(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))







___________________________________________________ 
 您的生活即時通 － 溝通、娛樂、生活、工作一次搞定！ 
 http://messenger.yahoo.com.tw/




___________________________________________________ 
 您的生活即時通 － 溝通、娛樂、生活、工作一次搞定！ 
 http://messenger.yahoo.com.tw/
