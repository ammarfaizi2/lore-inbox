Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUGMX03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUGMX03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267227AbUGMX02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:26:28 -0400
Received: from gprs214-96.eurotel.cz ([160.218.214.96]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267231AbUGMXZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:25:30 -0400
Date: Wed, 14 Jul 2004 01:25:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: radeonfb badly broken on amd64 in 2.6.8-rc1
Message-ID: <20040713232507.GA1643@elf.ucw.cz>
References: <20040713212757.GA730@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713212757.GA730@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I do not know if it is new breakage or if it was broken before...
> 
> If I compile kernel for 32-bit, radeon is okay. If I compile it for
> 64-bit, I get very interesting effects. I never thought LCD can
> flicker like this...

And this fixes it. Please apply, [aty128fb.c part untested, but should
be obvious. Feel free to drop it.]
								Pavel

Index: drivers/video/aty/aty128fb.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/drivers/video/aty/aty128fb.c,v
retrieving revision 1.11
diff -u -r1.11 aty128fb.c
--- drivers/video/aty/aty128fb.c	18 Apr 2004 00:29:32 -0000	1.11
+++ drivers/video/aty/aty128fb.c	13 Jul 2004 23:20:59 -0000
@@ -924,7 +924,7 @@
 
 }           
 
-#ifdef __i386__
+#ifdef CONFIG_X86
 static void *  __devinit aty128_find_mem_vbios(struct aty128fb_par *par)
 {
 	/* I simplified this code as we used to miss the signatures in
@@ -946,7 +946,7 @@
         }
 	return rom_base;
 }
-#endif /* __i386__ */
+#endif
 #endif /* ndef(__sparc__) */
 
 /* fill in known card constants if pll_block is not available */
@@ -1950,7 +1950,7 @@
 
 #ifndef __sparc__
 	bios = aty128_map_ROM(par, pdev);
-#ifdef __i386__
+#ifdef CONFIG_X86
 	if (bios == NULL)
 		bios = aty128_find_mem_vbios(par);
 #endif
Index: drivers/video/aty/radeon_base.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/drivers/video/aty/radeon_base.c,v
retrieving revision 1.23
diff -u -r1.23 radeon_base.c
--- drivers/video/aty/radeon_base.c	28 Jun 2004 06:34:58 -0000	1.23
+++ drivers/video/aty/radeon_base.c	13 Jul 2004 23:15:47 -0000
@@ -386,7 +386,7 @@
 	return -ENXIO;
 }
 
-#ifdef __i386__
+#ifdef CONFIG_X86
 static int  __devinit radeon_find_mem_vbios(struct radeonfb_info *rinfo)
 {
 	/* I simplified this code as we used to miss the signatures in
@@ -415,7 +415,7 @@
 
 	return 0;
 }
-#endif /* __i386__ */
+#endif
 
 #ifdef CONFIG_PPC_OF
 /*
@@ -2277,13 +2277,13 @@
 	/*
 	 * On x86, the primary display on laptop may have it's BIOS
 	 * ROM elsewhere, try to locate it at the legacy memory hole.
-	 * We probably need to make sure this is the primary dispay,
+	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
-#ifdef __i386__
+#ifdef CONFIG_X86
 	if (rinfo->bios_seg == NULL)
 		radeon_find_mem_vbios(rinfo);
-#endif /* __i386__ */
+#endif
 
 	/* If both above failed, try the BIOS ROM again for mobility
 	 * chips

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
