Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVBXWHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVBXWHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVBXWHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:07:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15111 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262506AbVBXWHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:07:35 -0500
Date: Thu, 24 Feb 2005 23:07:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark BLK_DEV_PS2 as BROKEN
Message-ID: <20050224220732.GM8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer proposed this patch with the following comment:

<--  snip  -->

As observed earlier, ps2esdi was broken as a module,
and the passing of geometry boot parameters is broken.
But does it still work with kernels 2.3 or later?
I think it does, but failed to verify that.

I found an IBM PS/2 model 70-A21 with 8 MB and 120 MB ESDI disk.
Tried a few distribution boot floppies to see whether they would boot.

Slackware has special ibmmca bootdisks.
SW 3.3 - Linux 2.1.43 - boots fine
SW 4.0 - Linux 2.2.6 - hangs
SW 7.0 - Linux 2.2.13 - boots fine
SW 8.1 - Linux 2.4.18 - boots, but every single command is killed by OOM
SW 10.0 - Linux 2.4.26 - kernel panic: no 386 supported

Then Debian:
Woody - Linux 2.2.10 - boots fine, but the rootdisk hangs
Sarge - Linux 2.4.27 - does not recognize the ESDI disk, and the rootdisk
 crashes by OOM.

So, good luck with 2.1 and 2.2 kernels, only failures with later kernels.

What about other people? The two major Linux/MCA sites were
http://glycerine.itsmm.uni.edu/mca (also referenced in Documentation/mca.txt)
but it doesnt exist any longer, and http://www.dgmicro.com/mca/,
which still exists ("last update: Jan 28 1999"), but the binaries
it refers to live on ftp.dgmicro.com, which isn't there anymore.

Concerning the speed:
I measured this ESDI disk under Linux as transferring 50 kB/s,
that is 4% of the speed the IBM specs claim. Also other Linux users
complained that the disk is much faster under DOS.

<--  snip  -->


My proposal for this patch would be to get it into one 2.6 kernel (is it 
too late for 2.6.11?) and wait if anyone was still using it and screams, 
and remove it a few months later otherwise.


--- a/drivers/block/Kconfig	2004-12-29 03:39:44.000000000 +0100
+++ b/drivers/block/Kconfig	2005-01-11 12:35:25.000000000 +0100
@@ -42,7 +42,7 @@ config MAC_FLOPPY
 
 config BLK_DEV_PS2
 	tristate "PS/2 ESDI hard disk support"
-	depends on MCA && MCA_LEGACY
+	depends on MCA && MCA_LEGACY && BROKEN
 	help
 	  Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
 	  hard disk.

