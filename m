Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUE2KwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUE2KwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 06:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUE2KwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 06:52:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17064 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264256AbUE2KwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 06:52:07 -0400
Date: Sat, 29 May 2004 12:53:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: [patch] md.c message during quiet boot
Message-ID: <20040529105322.GA3694@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below gets rid of a message that gets printed during FC2's
quiet bootup.

	Ingo

--- linux/drivers/md/md.c.orig	
+++ linux/drivers/md/md.c	
@@ -1607,7 +1607,7 @@ static int do_md_run(mddev_t * mddev)
 	spin_lock(&pers_lock);
 	if (!pers[pnum] || !try_module_get(pers[pnum]->owner)) {
 		spin_unlock(&pers_lock);
-		printk(KERN_ERR "md: personality %d is not loaded!\n",
+		printk(KERN_WARNING "md: personality %d is not loaded!\n",
 		       pnum);
 		return -EINVAL;
 	}
