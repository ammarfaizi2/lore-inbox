Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTEIIUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEIIUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:20:12 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:5604 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262361AbTEIIUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:20:08 -0400
Date: Fri, 9 May 2003 10:32:51 +0200
From: norbert_wolff@t-online.de (Norbert Wolff)
To: lkml <linux-kernel@vger.kernel.org>
Subject: Bug in arch/i386/mm/hugetlbpage.c
Message-Id: <20030509103251.34f33d98.norbert_wolff@t-online.de>
X-Mailer: Sylpheed version 0.8.11
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo !

In arch/i386/mm/hugetlbpage.c htlbzone_pages and htlbpage_freelist
are declared static at the Top of the File and later
in set_hugetlb_mem_size() as extern.

gcc-3.4 does not accept this conflict.

Fix below.

Bye,

	Norbert


--- hugetlbpage.c.orig	2003-05-05 01:53:41.%N +0200
+++ hugetlbpage.c	2003-05-09 09:32:43.%N +0200
@@ -398,8 +398,6 @@ int set_hugetlb_mem_size(int count)
 {
 	int lcount;
 	struct page *page;
-	extern long htlbzone_pages;
-	extern struct list_head htlbpage_freelist;
 
 	if (count < 0)
 		lcount = count;


--
 Norbert Wolff
 OpenPGP-Key:
   http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xF13BD6F6
