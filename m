Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBQBr1>; Sun, 16 Feb 2003 20:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTBQBr0>; Sun, 16 Feb 2003 20:47:26 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:36537 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262201AbTBQBr0>; Sun, 16 Feb 2003 20:47:26 -0500
Date: Sun, 16 Feb 2003 19:57:04 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Move __this_module to xxx.mod.c
In-Reply-To: <3E50016B.1080908@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0302161946220.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Brian Gerst wrote:

> This patch moves the module structure to the generated .mod.c file, 
> instead of compiling it into each object and relying on the linker to 
> include it only once.

Yeah, it's something I though about doing, but I was not sure. I think 
it's up to Rusty to comment ;)

It will need an associated change to module_init_tools.

Another comment:

diff -urN linux-2.5.61-bk1/scripts/modpost.c linux/scripts/modpost.c
--- linux-2.5.61-bk1/scripts/modpost.c	2003-02-16 10:06:35.000000000 -0500
+++ linux/scripts/modpost.c	2003-02-16 14:10:19.000000000 -0500
@@ -287,6 +287,10 @@
 		/* undefined symbol */
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
 			break;
+
+		/* ignore __this_module */
+		if (!strcmp(symname, "__this_module"))
+			break;
 		
 		s = alloc_symbol(symname);
 		/* add to list */

Is that necessary? __this_module shouldn't be unresolved, so this case 
should never be hit AFAICS.

--Kai


