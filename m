Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTEMDCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTEMDBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:01:16 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:20210 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263184AbTEMDBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:01:07 -0400
Date: Mon, 12 May 2003 20:13:04 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Cc: anton@samba.org
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030512201304.S19432@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, hch@infradead.org,
	gregkh@kroah.com, linux-security-module@wirex.com, anton@samba.org
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

--- 1.14/arch/ppc64/vmlinux.lds.S	Wed Apr  2 00:42:56 2003
+++ edited/arch/ppc64/vmlinux.lds.S	Mon May 12 16:16:59 2003
@@ -104,6 +104,9 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  __security_initcall_start = .;
+  .security_initcall.init : { *(.security_initcall.init) }
+  __security_initcall_end = .;
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
