Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUGCS4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUGCS4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 14:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUGCS4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 14:56:24 -0400
Received: from verein.lst.de ([212.34.189.10]:14035 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265236AbUGCS4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 14:56:22 -0400
Date: Sat, 3 Jul 2004 20:56:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: current BK compilation failure on ppc32
Message-ID: <20040703185606.GA4718@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org, pavel@ucw.cz,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/smp.c: In function `smp_pause':
kernel/power/smp.c:24: error: storage size of `ctxt' isn't known
kernel/power/smp.c:24: warning: unused variable `ctxt'

kernel/power/smp.c seems to be inherently swsusp-specific but is
compiled for CONFIG_PM. (Same seems to be true for amny other files
in kernel/power/, but as they compile it only causes bloat..)


--- 1.10/kernel/power/Makefile	2004-07-02 07:23:47 +02:00
+++ edited/kernel/power/Makefile	2004-07-03 22:07:29 +02:00
@@ -1,5 +1,7 @@
 obj-y				:= main.o process.o console.o pm.o
+ifeq ($(CONFIG_SOFTWARE_SUSPEND), y)
 obj-$(CONFIG_SMP)		+= smp.o
+endif
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
