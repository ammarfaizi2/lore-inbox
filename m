Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbTAVSLr>; Wed, 22 Jan 2003 13:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAVSLr>; Wed, 22 Jan 2003 13:11:47 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:7724 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S262392AbTAVSLq>;
	Wed, 22 Jan 2003 13:11:46 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH]: rd_block & devblocks are unsigned long
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Wed, 22 Jan 2003 19:20:53 +0100
Message-ID: <86hec1cagq.fsf@trasno.mitica>
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Resent to marcelo with corret subject ]

Hi
        rd_blocks, and devblocks are unsigned longs, print them as
        unsigned longs.

Please, apply.

Later, Juan.

diff -uNp t1/init/do_mounts.c.orig t1/init/do_mounts.c
--- t1/init/do_mounts.c.orig	2003-01-22 18:39:05.000000000 +0100
+++ t1/init/do_mounts.c	2003-01-22 18:40:46.000000000 +0100
@@ -593,7 +593,7 @@ static int __init rd_load_image(char *fr
 		rd_blocks >>= 1;
 
 	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%d/%d blocks)\n",
+		printk("RAMDISK: image too big! (%d/%lu blocks)\n",
 		       nblocks, rd_blocks);
 		goto done;
 	}
@@ -620,23 +620,23 @@ static int __init rd_load_image(char *fr
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%d disk%s] into ram disk... ", 
+	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%lu disk%s] into ram disk... ", 
 		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
 	for (i=0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
-			printk("done disk #%d.\n", i/devblocks);
+			printk("done disk #%lu.\n", i/devblocks);
 			rotate = 0;
 			if (close(in_fd)) {
 				printk("Error closing the disk.\n");
 				goto noclose_input;
 			}
-			change_floppy("disk #%d", i/devblocks+1);
+			change_floppy("disk #%lu", i/devblocks+1);
 			in_fd = open(from, O_RDONLY, 0);
 			if (in_fd < 0)  {
 				printk("Error opening disk.\n");
 				goto noclose_input;
 			}
-			printk("Loading disk #%d... ", i/devblocks+1);
+			printk("Loading disk #%lu... ", i/devblocks+1);
 		}
 		read(in_fd, buf, BLOCK_SIZE);
 		write(out_fd, buf, BLOCK_SIZE);



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
