Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWEBL3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWEBL3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWEBL3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:29:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13778 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964773AbWEBL3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:29:31 -0400
Date: Tue, 2 May 2006 13:28:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>, Matt Mackall <mpm@selenic.com>
Subject: Re: initcall warnings in 2.6.17
Message-ID: <20060502112827.GA1677@elf.ucw.cz>
References: <200604281406.34217.ak@suse.de> <20060428105403.250eb2d6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428105403.250eb2d6.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix

> > initcall at 0xffffffff80249307: software_resume+0x0/0xcf(): returned with error code -2

warning.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 81d4d98..1019aca 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -168,7 +168,7 @@ static int software_resume(void)
 	if (!swsusp_resume_device) {
 		if (!strlen(resume_file)) {
 			up(&pm_sem);
-			return -ENOENT;
+			return 0;
 		}
 		swsusp_resume_device = name_to_dev_t(resume_file);
 		pr_debug("swsusp: Resume From Partition %s\n", resume_file);

-- 
Thanks for all the (sleeping) penguins.
