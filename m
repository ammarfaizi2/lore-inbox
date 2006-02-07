Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWBGJob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWBGJob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBGJob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:44:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38829 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932460AbWBGJoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:44:30 -0500
Date: Tue, 7 Feb 2006 10:44:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: kill unneeded/unbalanced bio_get (try 2)
Message-ID: <20060207094418.GE1742@elf.ucw.cz>
References: <20060205114646.GA3138@elf.ucw.cz> <s5h1wyg9yan.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1wyg9yan.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I messed the first attempt up, it only moved leak to error path. Could
you replace it with this?

---

Takashi pointed out that I don't bio_put in non-error cases, and says
bio_get is not neccessary. It still works so I hope he's ok.
 
Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 59c91c1..c91275e 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -743,7 +743,6 @@ static int submit(int rw, pgoff_t page_o
 	if (!bio)
 		return -ENOMEM;
 	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_get(bio);
 	bio->bi_bdev = resume_bdev;
 	bio->bi_end_io = end_io;
 


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
