Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSKZHjX>; Tue, 26 Nov 2002 02:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSKZHjX>; Tue, 26 Nov 2002 02:39:23 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:33983 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266271AbSKZHjW>; Tue, 26 Nov 2002 02:39:22 -0500
To: Greg Ungerer <gerg@snapgear.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Make some EXPORT_SYMBOLs dependent on CONFIG_MMU
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 26 Nov 2002 16:46:29 +0900
In-Reply-To: <20021015181609.A31647@infradead.org>
Message-ID: <buoisyk7oyy.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

[I'm not sure who to send this to, so I'm guessing.  Pointers appreciated!]

Hi,

A few symbols are only defined when CONFIG_MMU=y, but are exported (by
kernel/ksyms.c) unconditionally.  This patch makes them conditional.


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=nommu-exports-20021126.patch
Content-Description: nommu-exports-20021126.patch

diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/kernel/ksyms.c kernel/ksyms.c
--- ../orig/linux-2.5.49-uc0/kernel/ksyms.c	2002-11-25 10:30:10.000000000 +0900
+++ kernel/ksyms.c	2002-11-25 14:32:43.000000000 +0900
@@ -324,7 +324,9 @@
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);
 EXPORT_SYMBOL(dentry_open);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(filemap_nopage);
+#endif
 EXPORT_SYMBOL(filemap_fdatawrite);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
@@ -525,7 +527,9 @@
 EXPORT_SYMBOL(single_release);
 
 /* Program loader interfaces */
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(setup_arg_pages);
+#endif
 EXPORT_SYMBOL(copy_strings_kernel);
 EXPORT_SYMBOL(do_execve);
 EXPORT_SYMBOL(flush_old_exec);

--=-=-=



Thanks,

-Miles
-- 
Love is a snowmobile racing across the tundra.  Suddenly it flips over,
pinning you underneath.  At night the ice weasels come.  --Nietzsche

--=-=-=--
