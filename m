Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUGDHJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUGDHJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 03:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUGDHJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 03:09:00 -0400
Received: from ozlabs.org ([203.10.76.45]:64646 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265431AbUGDHI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 03:08:59 -0400
Date: Sun, 4 Jul 2004 17:07:02 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-ID: <20040704070702.GC4923@krispykreme>
References: <20040704065811.GA4923@krispykreme> <20040704070144.GB4923@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704070144.GB4923@krispykreme>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.5 ICEd on the ppc64 version of __ptep_set_access_flags, but it does
look like we want to use *ptep here.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -ur /root/toolchain/linux-2.5-bk/include/asm-ppc64/pgtable.h linux-2.5-bk/include/asm-ppc64/pgtable.h
--- /root/toolchain/linux-2.5-bk/include/asm-ppc64/pgtable.h	2004-06-13 14:37:00.000000000 +0000
+++ linux-2.5-bk/include/asm-ppc64/pgtable.h	2004-07-03 12:01:10.522949800 +0000
@@ -424,7 +424,7 @@
 		stdcx.	%0,0,%4\n\
 		bne-	1b"
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (bits), "r" (ptep), "m" (ptep), "i" (_PAGE_BUSY)
+	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
 	:"cc");
 }
 #define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
