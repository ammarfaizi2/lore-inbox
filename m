Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUBZWBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUBZV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:59:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:29845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261168AbUBZV7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:59:22 -0500
Date: Thu, 26 Feb 2004 14:04:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
In-Reply-To: <Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402261403240.7830@ppc970.osdl.org>
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
 <Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Linus Torvalds wrote:
> 
> Btw, the "xor_pII_mmx_5()" thing just uses "+r" for the line count, so why 
> doesn't that work for this case?

In other words, shouldn't this work for all compilers also? I don't see 
why this shouldn't compile if the pII version compiles? 

Yes, it's pushing the register pressure a bit, but it would seem to be
the simplest fix..

		Linus

===== include/asm-i386/xor.h 1.14 vs edited =====
--- 1.14/include/asm-i386/xor.h	Tue Mar 11 18:15:03 2003
+++ edited/include/asm-i386/xor.h	Thu Feb 26 14:03:17 2004
@@ -489,7 +489,7 @@
 	"       jnz 1b               ;\n"
 	"	popl %5\n"
 	"	popl %4\n"
-	: "+g" (lines),
+	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5)
 	: "memory");
