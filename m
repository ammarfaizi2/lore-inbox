Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbUKEAlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUKEAlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUKEAlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:41:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42919 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262505AbUKEAkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:40:55 -0500
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1099612923.1022.10.camel@localhost>
References: <4187FA6D.3070604@us.ibm.com>
	 <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com>
	 <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random>
	 <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random>
	 <418846E9.1060906@us.ibm.com>  <20041103030558.GK3571@dualathlon.random>
	 <1099612923.1022.10.camel@localhost>
Content-Type: multipart/mixed; boundary="=-qpSuqkGakgG19YBwJKiG"
Message-Id: <1099615248.5819.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 04 Nov 2004 16:40:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qpSuqkGakgG19YBwJKiG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I attached the wrong patch.

Here's what I meant to send.

-- Dave

--=-qpSuqkGakgG19YBwJKiG
Content-Disposition: attachment; filename=Z0-leaks_only_on_negative.patch
Content-Type: text/x-patch; name=Z0-leaks_only_on_negative.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 memhotplug1-dave/arch/i386/mm/pageattr.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/mm/pageattr.c~Z0-leaks_only_on_negative arch/i386/mm/pageattr.c
--- memhotplug1/arch/i386/mm/pageattr.c~Z0-leaks_only_on_negative	2004-11-04 15:57:28.000000000 -0800
+++ memhotplug1-dave/arch/i386/mm/pageattr.c	2004-11-04 15:58:50.000000000 -0800
@@ -135,7 +135,7 @@ __change_page_attr(struct page *page, pg
 		BUG();
 
 	/* memleak and potential failed 2M page regeneration */
-	BUG_ON(!page_count(kpte_page));
+	BUG_ON(page_count(kpte_page) < 0);
 
 	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
 		list_add(&kpte_page->lru, &df_list);
_

--=-qpSuqkGakgG19YBwJKiG--

