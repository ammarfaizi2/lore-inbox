Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDSHen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDSHen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDSHen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:34:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55766 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750724AbWDSHem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:34:42 -0400
Date: Wed, 19 Apr 2006 08:30:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch] x86_64-enable-large-bzImage.patch
Message-ID: <20060419063056.GA32425@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

enable large bzImages on x86_64. (fix is from x86's build.c) Using this 
patch i have successfully built and booted an allyesconfig 13MB+ bzImage 
on x86_64 too:

 $ size64 vmlinux
    text    data     bss     dec     hex filename
 23444831        8202642 3439360 35086833        21761f1 vmlinux

 -rw-rw-r--  1 mingo mingo 13121740 Apr 19 09:32 arch/x86_64/boot/bzImage

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/x86_64/boot/tools/build.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Index: linux/arch/x86_64/boot/tools/build.c
===================================================================
--- linux.orig/arch/x86_64/boot/tools/build.c
+++ linux/arch/x86_64/boot/tools/build.c
@@ -149,10 +150,8 @@ int main(int argc, char ** argv)
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
+	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
+		die("System is too big. Try using bzImage or modules.");
 	while (sz > 0) {
 		int l, n;
 
