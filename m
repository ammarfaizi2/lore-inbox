Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVFFLj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVFFLj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFFLj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:39:26 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:4620 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261181AbVFFLjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:39:20 -0400
Message-ID: <42A435DE.50302@tu-harburg.de>
Date: Mon, 06 Jun 2005 13:39:10 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] don't allow sys_readahead() on files opened with O_DIRECT
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------030807050500060506080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807050500060506080702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030807050500060506080702
Content-Type: text/x-patch;
 name="filemap.c_direct_IO_readahead.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filemap.c_direct_IO_readahead.diff"

do_readahead() doesn't make sense if the file is opened with O_DIRECT, 
since only the page cache is stuffed but never used.

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 mm/filemap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: experimental-um/mm/filemap.c
===================================================================
--- experimental-um.orig/mm/filemap.c
+++ experimental-um/mm/filemap.c
@@ -1110,7 +1110,8 @@ static ssize_t
 do_readahead(struct address_space *mapping, struct file *filp,
 	     unsigned long index, unsigned long nr)
 {
-	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
+	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage
+	    || mapping->a_ops->direct_IO)
 		return -EINVAL;
 
 	force_page_cache_readahead(mapping, filp, index,

--------------030807050500060506080702--
