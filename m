Return-Path: <linux-kernel-owner+w=401wt.eu-S1752525AbWLSFRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbWLSFRh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWLSFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:17:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:48523 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbWLSFRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:17:36 -0500
Date: Tue, 19 Dec 2006 10:47:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Sam Ravnborg <sam@ravnborg.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH 5/5] i386: Fix memory hotplug related MODPOST generated warning
Message-ID: <20061219051722.GE26052@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Fix modpost generated warning.

WARNING: vmlinux - Section mismatch: reference to .init.text: from .text
between 'add_one_highpage_hotplug' (at offset 0xc0113d3f) and 'online_page'

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/mm/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/init.c~i386-memory-hotplug-related-warnings arch/i386/mm/init.c
--- linux-2.6.19-rc1-reloc/arch/i386/mm/init.c~i386-memory-hotplug-related-warnings	2006-12-15 14:09:05.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/arch/i386/mm/init.c	2006-12-15 14:09:05.000000000 +0530
@@ -283,7 +283,7 @@ void __init add_one_highpage_init(struct
 		SetPageReserved(page);
 }
 
-static int add_one_highpage_hotplug(struct page *page, unsigned long pfn)
+static int __meminit add_one_highpage_hotplug(struct page *page, unsigned long pfn)
 {
 	free_new_highpage(page);
 	totalram_pages++;
@@ -300,7 +300,7 @@ static int add_one_highpage_hotplug(stru
  * has been added dynamically that would be
  * onlined here is in HIGHMEM
  */
-void online_page(struct page *page)
+void __meminit online_page(struct page *page)
 {
 	ClearPageReserved(page);
 	add_one_highpage_hotplug(page, page_to_pfn(page));
_
