Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTFYGFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTFYGFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:05:25 -0400
Received: from dp.samba.org ([66.70.73.150]:56466 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262525AbTFYGFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:05:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] fix in-kernel genksyms for parisc symbols 
In-reply-to: Your message of "23 Jun 2003 18:27:43 EST."
             <1056410864.1826.57.camel@mulgrave> 
Date: Wed, 25 Jun 2003 16:02:31 +1000
Message-Id: <20030625061924.3D1272C28B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1056410864.1826.57.camel@mulgrave> you write:
> The problem is that the parisc libgcc.a library contains symbols that
> look like $$mulI and the like, but genksyms doesn't think $ is legal for
> a function symbol, so they all get dropped from the output.  This means
> that inserting almost any module on parisc taints the kernel because
> these symbols have no version.
> 
> The fix (attached below) was to allow $ in an identifier in lex.l (and
> obviously to update the _shipped files as well, but my flex/bison seem
> to be rather different from the one they were generated with, so I'll
> leave that to whomever has the correct versions).

Looks fine, but my flex is different, too.  Kai?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

===== scripts/genksyms/lex.l 1.2 vs edited =====
--- 1.2/scripts/genksyms/lex.l	Wed Feb 19 16:42:13 2003
+++ edited/scripts/genksyms/lex.l	Mon Jun 23 17:17:17 2003
@@ -37,7 +37,7 @@
 
 %}
 
-IDENT			[A-Za-z_][A-Za-z0-9_]*
+IDENT			[A-Za-z_\$][A-Za-z0-9_\$]*
 
 O_INT			0[0-7]*
 D_INT			[1-9][0-9]*
