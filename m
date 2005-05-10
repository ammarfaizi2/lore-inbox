Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVEJVpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVEJVpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVEJVpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:45:41 -0400
Received: from graphe.net ([209.204.138.32]:34314 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261825AbVEJVpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:45:06 -0400
Date: Tue, 10 May 2005 14:44:47 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, axboe@suse.de, alexn@dsv.su.se,
       lnxluv@yahoo.com
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
 [update]
In-Reply-To: <20050510211121.GO25612@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0505101443140.23713@graphe.net>
References: <200505092239.37834.rjw@sisk.pl> <20050509145424.6ffba49a.akpm@osdl.org>
 <200505101443.31229.rjw@sisk.pl> <20050510112224.761f5d68.akpm@osdl.org>
 <20050510211121.GO25612@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Andi Kleen wrote:

> Better just add the section to x86-64. Should be easy by copying the
> change from the i386 patch.

Something like this?

Index: linux-2.6.11/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.11.orig/arch/x86_64/kernel/vmlinux.lds.S	2005-05-10 13:35:24.000000000 -0700
+++ linux-2.6.11/arch/x86_64/kernel/vmlinux.lds.S	2005-05-10 13:44:26.000000000 -0700
@@ -42,6 +42,13 @@ SECTIONS
 	CONSTRUCTORS
 	}

+  . = ALIGN(32);
+  .data.cacheline_aligned : { (.data.cacheline_aligned) }
+
+  /* Rarely changed data like cpu maps */
+  . = ALIGN(4096);
+  .data.mostly_readonly : { *(.data.mostly_readonly) }
+
   _edata = .;			/* End of data section */

   __bss_start = .;		/* BSS */

> Ideally it would be asm-generic/vmlinux.lds and cover everybody...

Hmm.. Add a definition for ALIGNED_DATA ?

