Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUHSVSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUHSVSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHSVSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:18:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267414AbUHSVSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:18:13 -0400
Date: Thu, 19 Aug 2004 17:17:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: filemap_fdatawait() wait_on_page_writeback_range(mapping, 0, -1)?
Message-ID: <20040819201729.GC5278@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I dont understand why we do call wait_on_page_writeback_range() with -1 
as the "end" argument.

Is there a good reason for that? I bet so...

-1 sounds pretty stupid at first, it does unnecessary calls to 
the radix lookup code.

--- a/mm/filemap.c.orig      2004-08-19 14:36:02.000000000 -0300
+++ b/mm/filemap.c.isize     2004-08-19 18:17:14.000000000 -0300
@@ -231,7 +231,7 @@
  */
 int filemap_fdatawait(struct address_space *mapping)
 
-       return wait_on_page_writeback_range(mapping, 0, -1);
+       return wait_on_page_writeback_range(mapping, 0, i_size_read(mapping->host));
 }
  
 EXPORT_SYMBOL(filemap_fdatawait);

