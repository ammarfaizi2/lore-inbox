Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281256AbRKLFJX>; Mon, 12 Nov 2001 00:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281253AbRKLFJM>; Mon, 12 Nov 2001 00:09:12 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:20206 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S281246AbRKLFI7>;
	Mon, 12 Nov 2001 00:08:59 -0500
Subject: [PATCH] 2.4.15-pre3 non-modular compile breakage
To: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Date: Sun, 11 Nov 2001 21:09:29 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011112050929.589FB89980@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that Al Viro's patch to support large /proc/mounts, etc., has a
small mistake that broke (at least some) compiles where CONFIG_MODULES is
not defined... (That's the bug I reported to the list earlier tonight
FWIW.)

Here's a tested (on two systems, one with modules and one without) patch
against 2.4.15-pre3. The patch also seems to apply to 2.4.13-ac8, although
I have not tested it with that kernel version.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.15-pre3/fs/proc/proc_misc.c linux-2.4.15-pre3-bkn1/fs/proc/proc_misc.c
--- linux-2.4.15-pre3/fs/proc/proc_misc.c	Sun Nov 11 16:43:57 2001
+++ linux-2.4.15-pre3-bkn1/fs/proc/proc_misc.c	Sun Nov 11 20:32:11 2001
@@ -568,9 +568,11 @@
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
