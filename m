Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJaQFs>; Thu, 31 Oct 2002 11:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSJaQEg>; Thu, 31 Oct 2002 11:04:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20488 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262841AbSJaQEZ>; Thu, 31 Oct 2002 11:04:25 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21559.295852.205720@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:03:03 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: Does someone from PEORIA have a SHORTER ATTENTION span than me?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    Following patch exports remove_from_page_cache(). reiser4 stores all
    meta-data in the page cache. When piece of meta-data is removed,
    corresponding page has to be removed from the page cache (this is
    similar to truncate, but for meta-data), explicit call to
    remove_from_page_cache() is required at this point.

Please apply.
Nikita.
diff -rup -X dontdiff linus-bk-2.5/mm/filemap.c linux-2.5-reiser4/mm/filemap.c
--- linus-bk-2.5/mm/filemap.c   Fri Oct 18 03:00:41 2002
+++ linux-2.5-reiser4/mm/filemap.c      Tue Oct 29 17:16:22 2002
@@ -97,6 +97,7 @@ void remove_from_page_cache(struct page 
 	__remove_from_page_cache(page);
 	write_unlock(&mapping->page_lock);
 }
+EXPORT_SYMBOL(remove_from_page_cache);
 
 static inline int sync_page(struct page *page)
 {
