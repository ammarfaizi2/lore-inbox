Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbUKQQIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbUKQQIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUKQQIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:08:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:23429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbUKQQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:08:10 -0500
Date: Wed, 17 Nov 2004 08:07:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] i386: always enable REGPARM
In-Reply-To: <20041117043223.GF4943@stusta.de>
Message-ID: <Pine.LNX.4.58.0411170804550.2222@ppc970.osdl.org>
References: <20041117043223.GF4943@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Adrian Bunk wrote:
> 
> Is there still a known reason to disable CONFIG_REGPARM on i386 with
> gcc 3?

I wouldn't want to remove the config option, but we _can_ turn it around, 
and just force it to 'y'. And if nobody reports any strange problems in 
a few months, _then_ we can remove it.

I just make the diff be something like the appended.

		Linus

----
===== arch/i386/Kconfig 1.134 vs edited =====
--- 1.134/arch/i386/Kconfig	2004-10-21 18:35:11 -07:00
+++ edited/arch/i386/Kconfig	2004-11-17 08:07:06 -08:00
@@ -862,17 +862,8 @@
 	default y
 
 config REGPARM
-	bool "Use register arguments (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	default n
-	help
-	Compile the kernel with -mregparm=3. This uses an different ABI
-	and passes the first three arguments of a function call in registers.
-	This will probably break binary only modules.
-
-	This feature is only enabled for gcc-3.0 and later - earlier compilers
-	generate incorrect output with certain kernel constructs when
-	-mregparm=3 is used.
+	bool
+	default y
 
 endmenu
 
