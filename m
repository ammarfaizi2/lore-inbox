Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269760AbUJALaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269760AbUJALaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUJALaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:30:05 -0400
Received: from gprs214-247.eurotel.cz ([160.218.214.247]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269760AbUJAL3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:29:00 -0400
Date: Fri, 1 Oct 2004 13:28:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: fix highmem corruption in -rc3
Message-ID: <20041001112846.GA1489@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

-rc3 swsusp breaks badly with highmem, because patch from -mm is
missing. Please apply this patch from -mm to vanilla.

Otherwise -rc3 swsusp seems to work here... Quite good result for so
big merge. Thanks. (But this certainly scared me a lot).
								Pavel

--- clean/kernel/power/swsusp.c	2004-10-01 00:30:32.000000000 +0200
+++ clean-mm/kernel/power/swsusp.c	2004-09-26 01:34:27.000000000 +0200
@@ -856,7 +860,9 @@
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
 	restore_processor_state();
+	restore_highmem();
 	local_irq_enable();
 	return error;
 }
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
