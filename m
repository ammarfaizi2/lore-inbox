Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTEZUVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTEZUVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:21:37 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23814 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262211AbTEZUVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:21:36 -0400
Date: Mon, 26 May 2003 22:34:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Paulo Andre'" <fscked@iol.pt>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] [PATCH] Add 'make' with no target as preferred build command
Message-ID: <20030526203443.GA1209@mars.ravnborg.org>
Mail-Followup-To: Paulo Andre' <fscked@iol.pt>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <20030526182907.108fd71e.fscked@iol.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526182907.108fd71e.fscked@iol.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:29:07PM +0100, Paulo Andre' wrote:
> Hello,
> 
> It seems for 2.5/2.6 'make' is the preferred command for building the
> kernel tree (also stated in davej's 2.6 "what to expect" document). That
> scenario however isn't even presented when the user finishes the kernel
> configuration. This is a simple patch to scripts/kconfig/mconf.c which
> tackles that, perhaps not in the best fashion but certainly in the
> simplest.

If we really want this boilerplate text then bzImage should not be
present. It is i386 centric.
Revised patch below. Also made it a bit more readable by wrapping
a long line.

Roman Zippel cc:ed as he is the kconfig maintainer.

	Sam

===== scripts/kconfig/mconf.c 1.5 vs edited =====
--- 1.5/scripts/kconfig/mconf.c	Sat Mar 15 18:25:55 2003
+++ edited/scripts/kconfig/mconf.c	Mon May 26 22:30:47 2003
@@ -780,10 +780,12 @@
 		conf_write(NULL);
 		printf("\n\n"
 			"*** End of Linux kernel configuration.\n"
-			"*** Check the top-level Makefile for additional configuration.\n"
-			"*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'.\n\n");
+			"*** Execute 'make' to build the kernel"
+		        " or try 'make help'.\n\n");
 	} else
-		printf("\n\nYour kernel configuration changes were NOT saved.\n\n");
+		printf("\n\n"
+			"*** Your kernel configuration changes were NOT saved."
+			"\n\n");
 
 	return 0;
 }
