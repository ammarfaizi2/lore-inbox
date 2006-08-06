Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWHFRXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWHFRXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWHFRXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 13:23:18 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:37068 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751236AbWHFRXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 13:23:18 -0400
Date: Sun, 6 Aug 2006 18:22:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm2 early_param mem= fix
Message-ID: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Aug 2006 17:22:46.0331 (UTC) FILETIME=[EEFD78B0:01C6B97C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
until I noticed that my "mem=512M" boot option was doing nothing.  The
two fixes below got it working, but I wonder how many other early_param
"option=" args are wrong (e.g. "memmap=" in the same file): x86_64
shows many such, i386 shows only one, I've not followed it up further.

Hugh

--- 2.6.18-rc3-mm2/arch/x86_64/kernel/e820.c	2006-08-06 12:25:35.000000000 +0100
+++ linux/arch/x86_64/kernel/e820.c	2006-08-06 18:05:33.000000000 +0100
@@ -646,11 +646,11 @@ static int __init parse_memopt(char *p)
 {
 	if (!p)
 		return -EINVAL;
-	end_user_pfn = memparse(p, NULL);
+	end_user_pfn = memparse(p, &p);
 	end_user_pfn >>= PAGE_SHIFT;	
 	return 0;
 } 
-early_param("mem=", parse_memopt);
+early_param("mem", parse_memopt);
 
 static int userdef __initdata;
 
