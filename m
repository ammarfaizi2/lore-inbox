Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUGDB1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUGDB1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 21:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUGDB1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 21:27:38 -0400
Received: from holomorphy.com ([207.189.100.168]:7879 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265310AbUGDB1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 21:27:35 -0400
Date: Sat, 3 Jul 2004 18:27:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: ak@muc.de
Subject: x86_64 KBUILD_IMAGE
Message-ID: <20040704012732.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, ak@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 doesn't set KBUILD_IMAGE, and hence defaults to vmlinux. This
confuses make rpm in such a manner that it copies a raw ELF executable
to /boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION instead of
the expected bzImage, which is surprisingly unbootable and not what's
normally expected to be placed in /boot/ with that filename.

Just setting the variable is enough to convince it to use bzImage properly.


-- wli


Index: mm5-2.6.7/arch/x86_64/Makefile
===================================================================
--- mm5-2.6.7.orig/arch/x86_64/Makefile	2004-07-02 20:43:26.000000000 -0700
+++ mm5-2.6.7/arch/x86_64/Makefile	2004-07-03 18:10:06.390377824 -0700
@@ -77,6 +77,7 @@
 all: bzImage
 
 BOOTIMAGE                     := arch/x86_64/boot/bzImage
+KBUILD_IMAGE                  := $(BOOTIMAGE)
 
 bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
