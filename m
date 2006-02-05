Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWBELq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWBELq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWBELq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:46:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5065 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751719AbWBELq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:46:58 -0500
Date: Sun, 5 Feb 2006 12:46:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [patch] swsusp: kill unneeded/unbalanced bio_get
Message-ID: <20060205114646.GA3138@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Takashi pointed out that I don't bio_put in non-error cases, and says
bio_get is not neccessary. It still works so I hope he's ok.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -743,7 +743,6 @@ static int submit(int rw, pgoff_t page_o
 	if (!bio)
 		return -ENOMEM;
 	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_get(bio);
 	bio->bi_bdev = resume_bdev;
 	bio->bi_end_io = end_io;
 
@@ -762,7 +761,6 @@ static int submit(int rw, pgoff_t page_o
 		yield();
 
  Done:
-	bio_put(bio);
 	return error;
 }
 

-- 
Thanks, Sharp!
