Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWDCJOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWDCJOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWDCJOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:14:34 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:56129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751683AbWDCJOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:14:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:importance;
        b=W9ZV3omp3M0lzxtlejKw7tA+udipBBxuBI0i1NvHgyGMg9GOvDHeoSPKufbsKcTBi3zaF8+Tro+wvCilps6BCTiywMsxpIO61yY2SR06zEzcMx/BTt/H7G0gM90hWFjNhJOOMCN8X/b/kwcMfZfPOyXMC6Vakc/06Pjs96E9nro=
From: "Will L Givens" <wlgivens@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Summary: kernel/built-in.o: In function `do_exit':: undefined reference to `exit_io_context'
Date: Mon, 3 Apr 2006 04:12:32 -0500
Message-ID: <000301c656fe$bdfd3dd0$6401a8c0@zephyr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was attempting to build Kernel-2.6.16.1 and received the following error:

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `do_exit':
: undefined reference to `exit_io_context'
kernel/built-in.o: In function `do_exit':
: undefined reference to `exit_io_context'
mm/built-in.o: In function `generic_write_checks':
: undefined reference to `bdev_read_only'
mm/built-in.o: In function `generic_write_checks':
: undefined reference to `bdev_read_only'

>>>> CONTINUE <<<<

I ran the the following:

[root@jericho linux-2.6.16.1]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jericho.southkc.net 2.6.14.3 #2 Mon Mar 20 17:35:40 CST 2006 alpha
unknown unknown GNU/Linux
 
Gnu C                  4.0.1
Gnu make               3.80
binutils               2.16.90.0.3
util-linux             2.11f
mount                  2.11g
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          2001------------->
reiser4progs           fsck.reiser4:
quota-tools            3.01.
PPP                    2.4.1
isdn4k-utils           3.1pre1
nfs-utils              0.3.1
awk: cmd. line:2: (FILENAME=- FNR=1) fatal: attempt to access field -1
Dynamic linker (ldd)   2.3.2
Linux C++ Library      6.0.3
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               5.2.1
Modules Loaded

I created a patch in order to include the 'block/' directory and everything
appears to run fine. 

--- arch/alpha/Makefile-orig    Mon Apr  3 03:58:00 2006
+++ arch/alpha/Makefile Mon Apr  3 04:03:08 2006
@@ -88,7 +88,7 @@
 
 head-y := arch/alpha/kernel/head.o
 
-core-y                         += arch/alpha/kernel/ arch/alpha/mm/
+core-y                         += arch/alpha/kernel/ arch/alpha/mm/ block/
 core-$(CONFIG_MATHEMU)         += arch/alpha/math-emu/
 drivers-$(CONFIG_OPROFILE)     += arch/alpha/oprofile/
 libs-y                         += arch/alpha/lib/

If you like, could you please include the following patch in your later
kernel releases? Thank you for you time... Will L Givens
[wlgivens@southkc.net]

