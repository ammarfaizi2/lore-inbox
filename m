Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTEMDAB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEMC67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:58:59 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:35825 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263177AbTEMC54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:57:56 -0400
Date: Mon, 12 May 2003 20:09:53 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Cc: davidm@hpl.hp.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030512200953.N19432@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, hch@infradead.org,
	gregkh@kroah.com, linux-security-module@wirex.com,
	davidm@hpl.hp.com
References: <20030512200309.C20068@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030512200309.C20068@figure1.int.wirex.com>; from chris@wirex.com on Mon, May 12, 2003 at 08:03:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chris@wirex.com) wrote:
> As discussed before, here is a simple patch to allow for early
> initialization of security modules when compiled statically into the
> kernel.  The standard do_initcalls is too late for complete coverage of
> all filesystems and threads for example.  If this looks OK, I'd like to
> push it on to Linus.  Patch is against 2.5.69-bk.  It is tested on i386,
> and various arch maintainers are copied on relevant bits of patch.

This is just the arch specific linker bits for the early initialization
for security modules patch.  Does this look sane for this arch?

--- 1.29/arch/ia64/vmlinux.lds.S	Wed Apr  2 00:42:56 2003
+++ edited/arch/ia64/vmlinux.lds.S	Mon May 12 16:16:55 2003
@@ -141,6 +141,10 @@
   .con_initcall.init : AT(ADDR(.con_initcall.init) - PAGE_OFFSET)
 	{ *(.con_initcall.init) }
   __con_initcall_end = .;
+  __security_initcall_start = .;
+  .security_initcall.init : AT(ADDR(.security_initcall.init) - PAGE_OFFSET)
+	{ *(.security_initcall.init) }
+  __security_initcall_end = .;
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
