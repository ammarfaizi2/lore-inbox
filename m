Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCSUqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUCSUqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:46:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44037 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262007AbUCSUqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:46:00 -0500
Date: Fri, 19 Mar 2004 20:45:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fix "optimize  &&  ?"
Message-ID: <20040319204556.H14431@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch prevents the "optimize  &&  ?" message appearing when the
kernel configuration tool is run.  The message could be eliminated
from the tool, but I'd rather fix the needlessly over-complicated
expression:

--- orig/drivers/block/Kconfig	Fri Mar 19 11:55:32 2004
+++ linux/drivers/block/Kconfig	Fri Mar 19 20:39:25 2004
@@ -330,7 +330,7 @@ config BLK_DEV_RAM_SIZE
 
 config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
-	depends on BLK_DEV_RAM && BLK_DEV_RAM!=m
+	depends on BLK_DEV_RAM=y
 	help
 	  The initial RAM disk is a RAM disk that is loaded by the boot loader
 	  (loadlin or lilo) and that is mounted as root before the normal boot

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
