Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbRFNNf0>; Thu, 14 Jun 2001 09:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbRFNNfQ>; Thu, 14 Jun 2001 09:35:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:14087 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S262611AbRFNNfL>;
	Thu, 14 Jun 2001 09:35:11 -0400
Date: Thu, 14 Jun 2001 14:34:29 +0100 (IST)
From: Stephen Shirley <diamond@skynet.ie>
X-X-Sender: <diamond@skynet>
To: <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Some error checking on kmalloc()'s in ide-probe.c
Message-ID: <Pine.LNX.4.32.0106141428530.3530-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mornin,
	This patch adds error checking to the return value of kmalloc() in
2 places in ide-probe.c. It's against 2.4.5.y

Steve

--- ide-probe.c.orig    Thu Jun 14 14:05:31 2001
+++ ide-probe.c Thu Jun 14 14:15:12 2001
@@ -58,6 +58,11 @@
        struct hd_driveid *id;

        id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);  /* called with interrupts disabled! */
+       if(id == NULL)
+       {
+               printk(KERN_ERR "ide-probe: Failed to allocate memory for hd_driveid struct, aborting\n");
+               return;
+       }
        ide_input_data(drive, id, SECTOR_WORDS);                /* read 512 bytes of id info */
        ide__sti();     /* local CPU only */
        ide_fix_driveid(id);
@@ -623,6 +628,11 @@
        /* Allocate the buffer and potentially sleep first */

        new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
+       if(new_hwgroup == NULL)
+       {
+               printk(KERN_ERR "ide-probe: Failed to allocate memory for hwgroup, aborting\n");
+               return 1;
+       }

        save_flags(flags);      /* all CPUs */
        cli();                  /* all CPUs */


-- 
"My mom had Windows at work and it hurt her eyes real bad"

