Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTKUGUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 01:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTKUGUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 01:20:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:8677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264311AbTKUGU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 01:20:29 -0500
Date: Thu, 20 Nov 2003 22:26:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4: page allocation failure. order 3, mode 0x20
Message-Id: <20031120222616.6028d321.akpm@osdl.org>
In-Reply-To: <20031121060545.GA6847@middle.of.nowhere>
References: <20031121060545.GA6847@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
>  After several runs of cdda2wav I get this message:
> 
>  Nov 21 07:03:34 middle kernel: cdda2wav: page allocation failure. order:3, mode:0x20
>  Nov 21 07:03:34 middle last message repeated 36 times
> 
> ...
> 
>  I ran cdda2wav a lot more under 2.9.0-test9-mm3 and didn't see this
>  message.

Are you sure you were running -mm4 and not Linus's kernel?  -mm has a tweak
for this, and it was present in -mm4.

It would help to add this patch; maybe the allocation is coming from
somewhere else.


diff -puN mm/page_alloc.c~a mm/page_alloc.c
--- 25/mm/page_alloc.c~a	2003-11-20 22:25:23.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2003-11-20 22:25:38.000000000 -0800
@@ -672,6 +672,7 @@ nopage:
 		printk("%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);
+		dump_stack();
 	}
 	return NULL;
 got_pg:

_

