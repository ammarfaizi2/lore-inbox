Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUCBFS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCBFS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:18:27 -0500
Received: from citi.umich.edu ([141.211.133.111]:37455 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261565AbUCBFSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:18:25 -0500
Date: Tue, 2 Mar 2004 00:18:24 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <1078166466.4444.3.camel@localhost.localdomain>
Message-ID: <Pine.BSO.4.33.0403020009220.971-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo-

this patch seems to address the extra read at the end of files or devices
that end exactly on a page boundary, while retaining the good readahead
characteristics of my original patch.  i'd like to hear about any testing
from folks who have one of:

  mpt fusion
  ips (ibm serveraid)
  promise ata (and maybe sata too)

this patch is against 2.4.26-pre1.


diff -X ../dont-diff -Naurp 00-stock/mm/filemap.c 01-readahead/mm/filemap.c
--- 00-stock/mm/filemap.c	2004-02-18 08:36:32.000000000 -0500
+++ 01-readahead/mm/filemap.c	2004-03-02 00:07:59.000000000 -0500
@@ -1285,7 +1285,8 @@ static void generic_file_readahead(int r
 	unsigned long raend;
 	int max_readahead = get_max_readahead(inode);

-	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	end_index = ((inode->i_size + ~PAGE_CACHE_MASK) >>
+						PAGE_CACHE_SHIFT) - 1;

 	raend = filp->f_raend;
 	max_ahead = 0;


	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

