Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVIIP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVIIP0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVIIP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:26:34 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54169 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751396AbVIIP0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:26:33 -0400
Subject: [PATCH] i386: fix broken highmem
To: akpm@osdl.org
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 09 Sep 2005 08:26:27 -0700
Message-Id: <20050909152627.8899F624@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is in response to:
Subject: Re: 2.6.13-mm2 high memory support borken?

This should fix it.  It was simply missing the call to free_new_highpage.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/init.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/i386/mm/init.c~highmem-debug arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~highmem-debug	2005-09-09 08:22:30.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2005-09-09 08:22:30.000000000 -0700
@@ -278,6 +278,7 @@ void __init add_one_highpage_init(struct
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		free_new_highpage(page);
 	} else
 		SetPageReserved(page);
 }
_
