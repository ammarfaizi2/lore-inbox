Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbUKLCbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUKLCbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 21:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKLCbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 21:31:10 -0500
Received: from ozlabs.org ([203.10.76.45]:42952 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262402AbUKLCbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 21:31:08 -0500
Date: Fri, 12 Nov 2004 13:29:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [TRIVIAL] ppc64: Kill unused KRANGE_{START,END} macros
Message-ID: <20041112022913.GE25274@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Remove KRANGE_{START,END} macros from ppc64 code.  These were not used
anywhere.  Further KRANGE_END was misleading, since it implied a limit
on the linear mapping range based on the pagetable structure, whereas
in fact the linear mapping does not use a (Linux) pagetable at all.

Index: working-2.6/include/asm-ppc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable.h	2004-10-29 13:17:44.000000000 +1000
+++ working-2.6/include/asm-ppc64/pgtable.h	2004-11-12 13:20:42.941952600 +1100
@@ -67,12 +67,6 @@
 #define IMALLOC_END       (IMALLOC_BASE + PGTABLE_EA_MASK)
 
 /*
- * Define the address range mapped virt <-> physical
- */
-#define KRANGE_START KERNELBASE
-#define KRANGE_END   (KRANGE_START + PGTABLE_EA_MASK)
-
-/*
  * Define the user address range
  */
 #define USER_START (0UL)


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
