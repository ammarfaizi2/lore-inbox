Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbRF3Mon>; Sat, 30 Jun 2001 08:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbRF3Moe>; Sat, 30 Jun 2001 08:44:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263480AbRF3MoP>;
	Sat, 30 Jun 2001 08:44:15 -0400
Date: Sat, 30 Jun 2001 13:44:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Patch: numa.c broke in 2.4.6-pre8
Message-ID: <20010630134413.E12788@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When building 2.4.6-pre8 with CONFIG_DISCONTIGMEM=y, I get the following
error:

numa.c:96: conflicting types for `_alloc_pages'
/usr/src/v2.4/linux-assabet/include/linux/mm.h:383: previous declaration of `_alloc_pages'

The following patch fixes this problem.  Please apply.

--- orig/mm/numa.c	Sat Jun 30 11:09:05 2001
+++ linux/mm/numa.c	Sat Jun 30 13:40:37 2001
@@ -92,7 +92,7 @@
  * This can be refined. Currently, tries to do round robin, instead
  * should do concentratic circle search, starting from current node.
  */
-struct page * _alloc_pages(int gfp_mask, unsigned long order)
+struct page * _alloc_pages(unsigned int gfp_mask, unsigned long order)
 {
 	struct page *ret = 0;
 	pg_data_t *start, *temp;


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

