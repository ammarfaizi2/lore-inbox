Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUCWWSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUCWWSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:18:23 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:42061 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262877AbUCWWSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:18:20 -0500
Date: Wed, 24 Mar 2004 09:17:25 +1100
From: Nathan Scott <nathans@sgi.com>
To: Meelis Roos <mroos@linux.ee>, paulus@samba.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.26-pre5: XFS module link errors on PPC
Message-ID: <20040323221725.GA733@frodo>
References: <Pine.GSO.4.44.0403231854160.14177-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403231854160.14177-100000@math.ut.ee>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 07:20:05PM +0200, Meelis Roos wrote:
> I tried to make enamble a modular XFS on my PPC using current linux-2.4
> bitkeeper snaphot. Unfortunately, there are unresolved symbols in xfs
> module:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.26-pre5/kernel/fs/xfs/xfs.o
> depmod:         ioremap_bot
> depmod:         vmalloc_start
> 
> XFS works fine when compiled in statically.
> 

Looks like XFS is picking them up via VMALLOC_START and VMALLOC_END
which are usually constants, but looks like these map to a couple
of global variables on PPC.  This should fix it, but I haven't got
a machine handy to test with...

cheers.

-- 
Nathan


--- arch/ppc/kernel/ppc_ksyms.c.orig	2004-03-24 09:04:15.000000000 +1100
+++ arch/ppc/kernel/ppc_ksyms.c	2004-03-24 09:07:20.000000000 +1100
@@ -161,6 +161,8 @@
 EXPORT_SYMBOL(_outsl_ns);
 EXPORT_SYMBOL(iopa);
 EXPORT_SYMBOL(mm_ptov);
+EXPORT_SYMBOL(vmalloc_start);
+EXPORT_SYMBOL(ioremap_bot);
 EXPORT_SYMBOL(ioremap);
 #ifdef CONFIG_PTE_64BIT
 EXPORT_SYMBOL(ioremap64);
