Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUDHXs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUDHXs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:48:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:10723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261822AbUDHXsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:48:55 -0400
Date: Thu, 8 Apr 2004 16:48:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <kirillx@7ka.mipt.ru>
Subject: [PATCH] fix load_elf_binary error path on unshare_files error
Message-ID: <20040408164851.K22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to return proper retval on unshare_files() error in
load_elf_binary.  Patch against 2.4.26-rc2.

Error noted by Kirill Korotaev <kirillx@7ka.mipt.ru>.

===== fs/binfmt_elf.c 1.28 vs edited =====
--- 1.28/fs/binfmt_elf.c	Thu Jan 29 15:08:42 2004
+++ edited/fs/binfmt_elf.c	Thu Apr  8 15:12:15 2004
@@ -479,7 +479,8 @@
 		goto out_free_ph;
 		
 	files = current->files;		/* Refcounted so ok */
-	if(unshare_files() < 0)
+	retval = unshare_files();
+	if (retval < 0)
 		goto out_free_ph;
 	if (files == current->files) {
 		put_files_struct(files);
