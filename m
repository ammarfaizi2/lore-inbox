Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbREYUYv>; Fri, 25 May 2001 16:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbREYUYl>; Fri, 25 May 2001 16:24:41 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:9511
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261840AbREYUY1>; Fri, 25 May 2001 16:24:27 -0400
Date: Fri, 25 May 2001 22:24:19 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: gadio@netvision.net.il
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __idetape_kmalloc_stage return code check in ide-tape.c (244-ac16)
Message-ID: <20010525222419.G851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This trivial patch adds a kmalloc check to ide-tape.c::
idetape_onstream_read_back_buffer as per the Stanford team's report
way back. It applies against 244ac16.

Reading the code I was not sure if it was OK to just return
or more should be done. Please sanity check this.

--- linux-244-ac11-clean/drivers/ide/ide-tape.c	Sat May 19 21:06:35 2001
+++ linux-244-ac11/drivers/ide/ide-tape.c	Sun May 20 14:58:44 2001
@@ -3472,6 +3472,11 @@
 	printk(KERN_INFO "ide-tape: %s: reading back %d frames from the drive's internal buffer\n", tape->name, frames);
 	for (i = 0; i < frames; i++) {
 		stage = __idetape_kmalloc_stage(tape, 0, 0);
+                if(!stage) {
+                        printk(KERN_WARNING "(idetape:) Failed to allocate memory for buffer\n");
+                        return;
+                }
+                        
 		if (!first)
 			first = stage;
 		aux = stage->aux;
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

'Xenix is the pinnacle of modern UNIX design, and will be used for many
years to come' -Xenix OS API manual 
