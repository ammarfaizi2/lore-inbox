Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUGDI3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUGDI3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 04:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUGDI3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 04:29:46 -0400
Received: from verein.lst.de ([212.34.189.10]:47838 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265474AbUGDI3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 04:29:45 -0400
Date: Sun, 4 Jul 2004 10:29:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: current BK compilation failure on ppc32
Message-ID: <20040704082938.GA14313@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>, pavel@ucw.cz,
	linux-kernel@vger.kernel.org
References: <20040703185606.GA4718@lst.de> <Pine.LNX.4.58.0407031439240.15998@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407031439240.15998@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't do it like that.
> 
> Instead, do something like
> 
> 	smp-power-$(CONFIG_SMP)	+= smp.o
> 	obj-$(CONFIG_SOFTWARE_SUSPEND) += $(smp-power-y)
> 
> which not only is shorter, but gets a _lot_ more readable after a while.

New patch below:


--- 1.10/kernel/power/Makefile	2004-07-02 07:23:47 +02:00
+++ edited/kernel/power/Makefile	2004-07-04 12:21:57 +02:00
@@ -1,6 +1,8 @@
+
+swsusp-smp-$(CONFIG_SMP)	+= smp.o
+
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y)
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
