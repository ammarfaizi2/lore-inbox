Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030620AbWBIDoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbWBIDoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWBIDoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:44:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23527 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030620AbWBIDoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:44:06 -0500
Date: Wed, 8 Feb 2006 19:43:59 -0800
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc2-mm1 patches don't apply
Message-Id: <20060208194359.bd1c1a4b.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The patchset for 2.6.16-rc2-mm1 seems borked.

It contains patches in linus.patch that are already in 2.6.16-rc2.

Hence, this *-mm patch set cannot be applied on top of 2.6.16-rc2.


For example, consider the following.

Linus tagged v2.6.16-rc2 at this revision (hg log format):

	changeset:   19933:6a79f5a2de38
	tag:         v2.6.16-rc2
	user:        Linus Torvalds <torvalds@g5.osdl.org>
	date:        Fri Feb  3 14:03:08 2006 +0800
	summary:     Linux v2.6.16-rc2

The following patch is included earlier in v2.6.16-rc2:

	changeset:   19738:81ca7cda8d38
	user:        Lucas Correia Villa Real <lucasvr@gobolinux.org>
	date:        Wed Feb  1 21:24:23 2006 +0000
	summary:     [ARM] 3284/1: S3C2400 - adds support to GPIO

It affects a few files, including the following change, obtained using
the command hg diff -r 19737 -r 19738 arch/arm/mach-s3c2410/Makefile:

	diff -r 03e77bf674ae -r 81ca7cda8d38 arch/arm/mach-s3c2410/Makefile
	--- a/arch/arm/mach-s3c2410/Makefile    Wed Feb  1 21:07:28 2006 +0000
	+++ b/arch/arm/mach-s3c2410/Makefile    Wed Feb  1 21:24:23 2006 +0000
	@@ -10,9 +10,13 @@
	 obj-n                  :=
	 obj-                   :=

	+# S3C2400 support files
	+obj-$(CONFIG_CPU_S3C2400)  += s3c2400-gpio.o
	+
	 # S3C2410 support files

	 obj-$(CONFIG_CPU_S3C2410)  += s3c2410.o
	+obj-$(CONFIG_CPU_S3C2410)  += s3c2410-gpio.o
	 obj-$(CONFIG_S3C2410_DMA)  += dma.o

	 # Power Management support
	@@ -25,6 +29,7 @@
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440.o s3c2440-dsc.o
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-irq.o
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-clock.o
	+obj-$(CONFIG_CPU_S3C2440)  += s3c2410-gpio.o

	 # bast extras



The linus.patch in the broken out patch set:

	2.6/2.6.16-rc2/2.6.16-rc2-mm1/2.6.16-rc2-mm1-broken-out.tar.bz2

from below:

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/

contains the lines:

	diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
	index b4f1e05..1217bf0 100644
	--- a/arch/arm/mach-s3c2410/Makefile
	+++ b/arch/arm/mach-s3c2410/Makefile
	@@ -10,9 +10,13 @@ obj-m                        :=
	 obj-n                  :=
	 obj-                   :=

	+# S3C2400 support files
	+obj-$(CONFIG_CPU_S3C2400)  += s3c2400-gpio.o
	+
	 # S3C2410 support files

	 obj-$(CONFIG_CPU_S3C2410)  += s3c2410.o
	+obj-$(CONFIG_CPU_S3C2410)  += s3c2410-gpio.o
	 obj-$(CONFIG_S3C2410_DMA)  += dma.o

	 # Power Management support
	@@ -25,6 +29,7 @@ obj-$(CONFIG_PM_SIMTEC)          += pm-simtec.
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440.o s3c2440-dsc.o
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-irq.o
	 obj-$(CONFIG_CPU_S3C2440)  += s3c2440-clock.o
	+obj-$(CONFIG_CPU_S3C2440)  += s3c2410-gpio.o

	 # bast extras


Looks familiar, huh?

That's the same change, in both linus.patch of 2.6.16-rc2-mm1, and
in what Linus marked as 2.6.16-rc2.

I think that there are some more, perhaps dozens, of such
duplicated patches.  See my earlier lkml post Message-Id:
<20060208131708.f81b025e.pj@sgi.com> in response to Andrew's
2.6.16-rc2-mm1 announcement, for circumstantial evidence of more such
damage to this patch set.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
