Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUACPRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUACPRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:17:13 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:49281 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263526AbUACPRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:17:12 -0500
Date: Sat, 3 Jan 2004 16:18:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5isms
Message-ID: <20040103151821.GA543@elf.ucw.cz>
References: <20030703200134.GA18459@andromeda> <20031230213050.GA3301@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230213050.GA3301@andromeda>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems I've found another 2.5ism.  2.6.0, arch/i386/kernel/dmi_scan.c
> has
> 
> #ifdef CONFIG_SIMNOW
>         /*
>          *      Skip on x86/64 with simnow. Will eventually go away
>          *      If you see this ifdef in 2.6pre mail me !
>          */
>         return -1;
> #endif
> 
> I don't know whose file this is ..
> 
> Also, 2.6.0 still has the previously mentioned problem in
> include/asm/io.h.
> 
> Not subscribed, CC me.

This is obsolete x86-64 code... Please apply,
								Pavel

--- tmp/linux/arch/i386/kernel/dmi_scan.c	2004-01-03 16:12:43.000000000 +0100
+++ linux/arch/i386/kernel/dmi_scan.c	2004-01-03 16:12:17.000000000 +0100
@@ -108,15 +108,7 @@
 	u8 buf[15];
 	u32 fp=0xF0000;
 
-#ifdef CONFIG_SIMNOW
-	/*
- 	 *	Skip on x86/64 with simnow. Will eventually go away
- 	 *	If you see this ifdef in 2.6pre mail me !
- 	 */
-	return -1;
-#endif
- 	
-	while( fp < 0xFFFFF)
+	while (fp < 0xFFFFF)
 	{
 		isa_memcpy_fromio(buf, fp, 15);
 		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
