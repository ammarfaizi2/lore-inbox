Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUJYLYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUJYLYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUJYLYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:24:43 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:63926 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261760AbUJYLYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:24:41 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16764.57958.975620.565173@wombat.chubb.wattle.id.au>
Date: Mon, 25 Oct 2004 21:24:22 +1000
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Can't build current 2.6 with separate output directory
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I see this:

   $ make O=../build/i386/linux-2.6.10-rc1 V=1
   ...
     CHK     include/linux/compile.h
   make -f /usr/src/linux-2.5-import/scripts/Makefile.build obj=usr
     echo Using shipped usr/initramfs_list
   Using shipped usr/initramfs_list
     ./usr/gen_init_cpio usr/initramfs_list > usr/initramfs_data.cpio
   ERROR: unable to open 'usr/initramfs_list': No such file or directory

because usr/Makefile is trying to access $(obj)/usr/initramfs_list
instead of  $(src)/usr/initramfs_list.

Here's a (probably incorrect) patch:

Signed-off-by: Peter Chubb.

===== usr/Makefile 1.12 vs edited =====
--- 1.12/usr/Makefile   2004-10-20 18:37:03 +10:00
+++ edited/usr/Makefile 2004-10-25 21:22:23 +10:00
@@ -8,7 +8,7 @@
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
 # or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST := $(obj)/initramfs_list
+INITRAMFS_LIST := $(KBUILD_SRC)/usr/initramfs_list
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
