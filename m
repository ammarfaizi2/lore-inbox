Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTAOH2u>; Wed, 15 Jan 2003 02:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAOH2t>; Wed, 15 Jan 2003 02:28:49 -0500
Received: from dp.samba.org ([66.70.73.150]:41419 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265777AbTAOH2t>;
	Wed, 15 Jan 2003 02:28:49 -0500
Date: Wed, 15 Jan 2003 18:38:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Squash warnings in init/do_mounts.c
Message-ID: <20030115073846.GG9789@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, please apply: this patch squashes some incorrect format
designator warnings in init/do_mounts.c.  These seem to have been
fixed already in 2.5.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/init/do_mounts.c linux-bartholomew/init/do_mounts.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/init/do_mounts.c	2002-12-04 10:44:51.000000000 +1100
+++ linux-bartholomew/init/do_mounts.c	2003-01-15 17:42:29.000000000 +1100
@@ -593,7 +593,7 @@
 		rd_blocks >>= 1;
 
 	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%d/%d blocks)\n",
+		printk("RAMDISK: image too big! (%d/%lu blocks)\n",
 		       nblocks, rd_blocks);
 		goto done;
 	}
@@ -620,11 +620,11 @@
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%d disk%s] into ram disk... ", 
+	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%ld disk%s] into ram disk... ", 
 		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
 	for (i=0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
-			printk("done disk #%d.\n", i/devblocks);
+			printk("done disk #%ld.\n", i/devblocks);
 			rotate = 0;
 			if (close(in_fd)) {
 				printk("Error closing the disk.\n");
@@ -636,7 +636,7 @@
 				printk("Error opening disk.\n");
 				goto noclose_input;
 			}
-			printk("Loading disk #%d... ", i/devblocks+1);
+			printk("Loading disk #%ld... ", i/devblocks+1);
 		}
 		read(in_fd, buf, BLOCK_SIZE);
 		write(out_fd, buf, BLOCK_SIZE);


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
