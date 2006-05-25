Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWEYQhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWEYQhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWEYQhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:37:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44692 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030258AbWEYQhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:37:34 -0400
Date: Thu, 25 May 2006 18:37:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle McMartin <kyle@mcmartin.ca>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to
 like Lordi...)
In-Reply-To: <20060525141714.GA31604@skunkworks.cabal.ca>
Message-ID: <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If we're going to have release code names for the kernel, might as well
>advertise them somewhere. :)
>
>--- a/init/version.c
>+++ b/init/version.c
>@@ -29,5 +29,6 @@ struct new_utsname system_utsname = {
> EXPORT_SYMBOL(system_utsname);
> 
> const char linux_banner[] =
>-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
>+	"Linux version " UTS_RELEASE " \"" LINUX_CODE_NAME "\" (" 
>+	LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") "
>+	UTS_VERSION "\n";
>-

As for extending the linux_banner, here's a real patch in my line...

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc5~/arch/i386/boot/setup.S linux-2.6.17-rc5+/arch/i386/boot/setup.S
--- linux-2.6.17-rc5~/arch/i386/boot/setup.S	2006-05-25 03:50:17.000000000 +0200
+++ linux-2.6.17-rc5+/arch/i386/boot/setup.S	2006-05-25 18:35:04.661512000 +0200
@@ -862,6 +862,8 @@ kernel_version:	.ascii	UTS_RELEASE
 		.ascii	LINUX_COMPILE_BY
 		.ascii	"@"
 		.ascii	LINUX_COMPILE_HOST
+                .ascii  "."
+                .ascii  LINUX_COMPILE_DOMAIN
 		.ascii	") "
 		.ascii	UTS_VERSION
 		.byte	0
diff --fast -Ndpru linux-2.6.17-rc5~/arch/x86_64/boot/setup.S linux-2.6.17-rc5+/arch/x86_64/boot/setup.S
--- linux-2.6.17-rc5~/arch/x86_64/boot/setup.S	2006-05-25 03:50:17.000000000 +0200
+++ linux-2.6.17-rc5+/arch/x86_64/boot/setup.S	2006-05-25 18:35:04.661512000 +0200
@@ -748,6 +748,8 @@ kernel_version:	.ascii	UTS_RELEASE
 		.ascii	LINUX_COMPILE_BY
 		.ascii	"@"
 		.ascii	LINUX_COMPILE_HOST
+                .ascii  "."
+                .ascii  LINUX_COMPILE_DOMAIN
 		.ascii	") "
 		.ascii	UTS_VERSION
 		.byte	0
diff --fast -Ndpru linux-2.6.17-rc5~/init/version.c linux-2.6.17-rc5+/init/version.c
--- linux-2.6.17-rc5~/init/version.c	2006-05-25 03:50:17.000000000 +0200
+++ linux-2.6.17-rc5+/init/version.c	2006-05-25 18:35:26.321512000 +0200
@@ -30,4 +30,5 @@ EXPORT_SYMBOL(system_utsname);
 
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+	LINUX_COMPILE_HOST "." LINUX_COMPILE_DOMAIN ") ("
+	LINUX_COMPILER ") " UTS_VERSION "\n";
#<<eof>>


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
