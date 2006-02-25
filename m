Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWBYBuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWBYBuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBYBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:50:32 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:51636 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964846AbWBYBub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:50:31 -0500
Date: Fri, 24 Feb 2006 20:45:49 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: don't use early_printk() during memory init
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602242049_MC3-1-B938-400B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

printk is working by the time this memory init message prints.
As it stands, output jumps to the top of the screen and prints
this message, then back to normal boot messages, overwriting
a line at the top.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

This bug was introduced 5 weeks ago and should be fixed before 2.6.16.

--- 2.6.16-rc4-64.orig/arch/x86_64/mm/init.c
+++ 2.6.16-rc4-64/arch/x86_64/mm/init.c
@@ -312,7 +312,7 @@ static void __init find_early_table_spac
 	table_start >>= PAGE_SHIFT;
 	table_end = table_start;
 
-	early_printk("kernel direct mapping tables up to %lx @ %lx-%lx\n",
+	printk("kernel direct mapping tables up to %lx @ %lx-%lx\n",
 		end, table_start << PAGE_SHIFT, table_end << PAGE_SHIFT);
 }
 
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
