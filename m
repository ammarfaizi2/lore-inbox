Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262376AbSJLISN>; Sat, 12 Oct 2002 04:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262386AbSJLISN>; Sat, 12 Oct 2002 04:18:13 -0400
Received: from chunk.voxel.net ([207.99.115.133]:3508 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S262376AbSJLISM>;
	Sat, 12 Oct 2002 04:18:12 -0400
Date: Sat, 12 Oct 2002 04:24:05 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] sparc64 makefile dep fix for uart_console_init
Message-ID: <20021012082405.GB10000@chunk.voxel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers/serial/Config.in defines the following:
if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
	define_bool CONFIG_SERIAL_SUNCORE y
	define_bool CONFIG_SERIAL_CORE_CONSOLE y

There are no deps for CONFIG_SERIAL_CORE_CONSOLE in
drivers/serial/Makefile, so core.o isn't built on sparc32/64, and
linking gives an undefined reference to uart_console_init() error.  Not
sure if this is the desired way to deal w/ such deps, but it gets the
job done.

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="serialmake.diff"

--- drivers/serial/Makefile.orig	2002-10-12 04:01:19.000000000 -0400
+++ drivers/serial/Makefile	2002-10-12 04:02:29.000000000 -0400
@@ -10,6 +10,7 @@
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_ISAPNP) += 8250_pnp.o
 obj-$(CONFIG_SERIAL_CORE) += core.o
+obj-$(CONFIG_SERIAL_CORE_CONSOLE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
 obj-$(CONFIG_SERIAL_8250_CS) += 8250_cs.o

--mxv5cy4qt+RJ9ypb--
