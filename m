Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUJVVNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUJVVNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUJVVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:13:26 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:19426 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S267566AbUJVVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:10:06 -0400
Message-Id: <200410222110.i9ML9xvp032081@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <1098384222.2389.22.camel@duffman> 
To: Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org.sun.com
Subject: [PATCH] Re: 2.6.9-bk6 initramfs build failure with separate object dir 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Oct 2004 16:09:59 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Oct 2004 11:43:42 PDT, Tom Duffy wrote:
>
>[tduffy@duffman linux-2.6.9-bk-openib]$ make O=/build1/tduffy/openib-work/build/bk/3.4/x86_64/
>  Using /build1/tduffy/openib-work/linux-2.6.9-bk-openib as source for kernel
>  CHK     include/linux/version.h
>make[2]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
>  CHK     include/asm-x86_64/offset.h
>  CHK     include/linux/compile.h
>  GEN_INITRAMFS_LIST usr/initramfs_list
>Using shipped usr/initramfs_list
>  CPIO    usr/initramfs_data.cpio
>ERROR: unable to open 'usr/initramfs_list': No such file or directory
...

Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

Should apply to all 2.6.9.

--- lk-2.6.9-mm1/usr/Makefile	2004-10-22 15:10:37.762298752 -0500
+++ lk-2.6.9-mm1.edit/usr/Makefile	2004-10-22 15:57:49.322317968 -0500
@@ -8,7 +8,7 @@ clean-files := initramfs_data.cpio.gz
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
 # or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST := $(obj)/initramfs_list
+INITRAMFS_LIST := $(srctree)/$(obj)/initramfs_list
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not

