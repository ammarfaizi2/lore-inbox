Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281240AbRKLEc5>; Sun, 11 Nov 2001 23:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281242AbRKLEcr>; Sun, 11 Nov 2001 23:32:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:7442 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281240AbRKLEcj>;
	Sun, 11 Nov 2001 23:32:39 -0500
Subject: [PATCH] Re: [BUG] 2.4.15-pre3 compile failure
From: Robert Love <rml@tech9.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112042413.39000898E3@pobox.com>
In-Reply-To: <20011112042413.39000898E3@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 11 Nov 2001 23:32:46 -0500
Message-Id: <1005539566.816.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-11 at 23:24, Barry K. Nathan wrote:
> proc_misc.c: In function `proc_misc_init':
> proc_misc.c:573: `proc_ksyms_operations' undeclared (first use in this function)proc_misc.c:573: (Each undeclared identifier is reported only once
> proc_misc.c:573: for each function it appears in.)

Hm, this was a bug in 2.4.13-ac8.  I guess Linus merged it into pre3.  I
sent Alan a patch, here it is:

--- linux-2.4.13-ac8/fs/proc/proc_misc.c	Mon Nov  5 17:34:08 2001
+++ linux/fs/proc/proc_misc.c	Mon Nov  5 18:29:55 2001
@@ -619,9 +619,11 @@
 	entry = create_proc_entry("mounts", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_mounts_operations;
+#ifdef CONFIG_MODULES
 	entry = create_proc_entry("ksyms", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_ksyms_operations;
+#endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;

	Robert Love

