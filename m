Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUDHX6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUDHX6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:58:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:23529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261791AbUDHX6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:58:06 -0400
Date: Thu, 8 Apr 2004 16:57:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <kirillx@7ka.mipt.ru>
Subject: [PATCH] fix another load_elf_binary error path
Message-ID: <20040408165759.W21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Protect against cases where interpreter is NULL.  Patch against 2.4.26-rc2.

Error noted by Kirill Korotaev <kirillx@7ka.mipt.ru>.

--- a/fs/binfmt_elf.c~unshare	2004-04-08 15:13:55.654720832 -0700
+++ b/fs/binfmt_elf.c	2004-04-08 15:23:52.788942632 -0700
@@ -821,7 +821,8 @@
 	/* error cleanup */
 out_free_dentry:
 	allow_write_access(interpreter);
-	fput(interpreter);
+	if (interpreter)
+		fput(interpreter);
 out_free_interp:
 	if (elf_interpreter)
 		kfree(elf_interpreter);
