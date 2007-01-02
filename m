Return-Path: <linux-kernel-owner+w=401wt.eu-S1753153AbXABLG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbXABLG4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbXABLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:06:56 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:55780 "EHLO
	smtpq3.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbXABLGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:06:55 -0500
Message-ID: <459A3C6E.7060503@gmail.com>
Date: Tue, 02 Jan 2007 12:05:18 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@in.ibm.com>
CC: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_PHYSICAL_ALIGN limited to 4M?
Content-Type: multipart/mixed;
 boundary="------------060201010809000800010100"
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201010809000800010100
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

A while ago it was remarked on list here that keeping the kernel 4M 
aligned physically might be a performance win if the added 1M (it 
normally loads at 1M) meant it would fit on one 4M aligned hugepage 
instead of 2 and since that time I've been doing such.

In fact, while I was at it, I ran the kernel at 16M; while admittedly a 
bit of a non-issue, having never experienced ZONE_DMA shortage, I am an 
ISA user on a >16M machine so this seemed to make sense -- no kernel 
eating up "precious" ISA-DMAable memory.

Recently CONFIG_PHYSICAL_START was replaced by CONFIG_PHYSICAL_ALIGN 
(commit e69f202d0a1419219198566e1c22218a5c71a9a6) and while 4M alignment 
is still possible, that's also the strictest alignment allowed meaning I 
can't load my (non-relocatable) kernel at 16M anymore.

If I just apply the following and set it to 16M, things seem to be 
working for me. Was there an important reason to limit the alignment to 
4M, and if so, even on non relocatable kernels?

Rene.


--------------060201010809000800010100
Content-Type: text/plain;
 name="config_physical_align_16m.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config_physical_align_16m.diff"

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 0d67a0a..aeadec2 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -793,7 +793,7 @@ config RELOCATABLE
 config PHYSICAL_ALIGN
 	hex "Alignment value to which kernel should be aligned"
 	default "0x100000"
-	range 0x2000 0x400000
+	range 0x2000 0x1000000
 	help
 	  This value puts the alignment restrictions on physical address
  	  where kernel is loaded and run from. Kernel is compiled for an

--------------060201010809000800010100--
