Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263692AbUEHLad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUEHLad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUEHLad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:30:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:30875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263692AbUEHLa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:30:29 -0400
Date: Sat, 8 May 2004 04:30:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: how long does it take to init the scheduler?
Message-Id: <20040508043005.44222723.akpm@osdl.org>
In-Reply-To: <20040508041910.495be234.akpm@osdl.org>
References: <20040508105311.GA15577@suse.de>
	<20040508035934.46101a9b.akpm@osdl.org>
	<20040508110959.GA1374@suse.de>
	<20040508041910.495be234.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  -module_init(init_elf_binfmt)
>  +core_initcall(init_elf_binfmt)

Sigh.  core_initcall() requires a semicolon, but module_init() does not.


diff -puN fs/binfmt_aout.c~binfmt-use-core_initcall fs/binfmt_aout.c
--- 25/fs/binfmt_aout.c~binfmt-use-core_initcall	2004-05-08 04:17:46.882598008 -0700
+++ 25-akpm/fs/binfmt_aout.c	2004-05-08 04:17:46.895596032 -0700
@@ -520,6 +520,6 @@ static void __exit exit_aout_binfmt(void
 	unregister_binfmt(&aout_format);
 }
 
-module_init(init_aout_binfmt);
+core_initcall(init_aout_binfmt);
 module_exit(exit_aout_binfmt);
 MODULE_LICENSE("GPL");
diff -puN fs/binfmt_elf.c~binfmt-use-core_initcall fs/binfmt_elf.c
--- 25/fs/binfmt_elf.c~binfmt-use-core_initcall	2004-05-08 04:17:46.884597704 -0700
+++ 25-akpm/fs/binfmt_elf.c	2004-05-08 04:28:39.475388824 -0700
@@ -1542,6 +1542,6 @@ static void __exit exit_elf_binfmt(void)
 	unregister_binfmt(&elf_format);
 }
 
-module_init(init_elf_binfmt)
-module_exit(exit_elf_binfmt)
+core_initcall(init_elf_binfmt);
+module_exit(exit_elf_binfmt);
 MODULE_LICENSE("GPL");
diff -puN fs/binfmt_em86.c~binfmt-use-core_initcall fs/binfmt_em86.c
--- 25/fs/binfmt_em86.c~binfmt-use-core_initcall	2004-05-08 04:17:46.885597552 -0700
+++ 25-akpm/fs/binfmt_em86.c	2004-05-08 04:29:02.014962288 -0700
@@ -110,6 +110,6 @@ static void __exit exit_em86_binfmt(void
 	unregister_binfmt(&em86_format);
 }
 
-module_init(init_em86_binfmt)
-module_exit(exit_em86_binfmt)
+core_initcall(init_em86_binfmt);
+module_exit(exit_em86_binfmt);
 MODULE_LICENSE("GPL");
diff -puN fs/binfmt_flat.c~binfmt-use-core_initcall fs/binfmt_flat.c
--- 25/fs/binfmt_flat.c~binfmt-use-core_initcall	2004-05-08 04:17:46.887597248 -0700
+++ 25-akpm/fs/binfmt_flat.c	2004-05-08 04:17:46.898595576 -0700
@@ -895,7 +895,7 @@ static void __exit exit_flat_binfmt(void
 
 /****************************************************************************/
 
-module_init(init_flat_binfmt);
+core_initcall(init_flat_binfmt);
 module_exit(exit_flat_binfmt);
 
 /****************************************************************************/
diff -puN fs/binfmt_misc.c~binfmt-use-core_initcall fs/binfmt_misc.c
--- 25/fs/binfmt_misc.c~binfmt-use-core_initcall	2004-05-08 04:17:46.888597096 -0700
+++ 25-akpm/fs/binfmt_misc.c	2004-05-08 04:17:46.898595576 -0700
@@ -775,6 +775,6 @@ static void __exit exit_misc_binfmt(void
 	unregister_filesystem(&bm_fs_type);
 }
 
-module_init(init_misc_binfmt);
+core_initcall(init_misc_binfmt);
 module_exit(exit_misc_binfmt);
 MODULE_LICENSE("GPL");
diff -puN fs/binfmt_script.c~binfmt-use-core_initcall fs/binfmt_script.c
--- 25/fs/binfmt_script.c~binfmt-use-core_initcall	2004-05-08 04:17:46.890596792 -0700
+++ 25-akpm/fs/binfmt_script.c	2004-05-08 04:26:17.946904424 -0700
@@ -111,6 +111,6 @@ static void __exit exit_script_binfmt(vo
 	unregister_binfmt(&script_format);
 }
 
-module_init(init_script_binfmt)
-module_exit(exit_script_binfmt)
+core_initcall(init_script_binfmt);
+module_exit(exit_script_binfmt);
 MODULE_LICENSE("GPL");
diff -puN fs/binfmt_som.c~binfmt-use-core_initcall fs/binfmt_som.c
--- 25/fs/binfmt_som.c~binfmt-use-core_initcall	2004-05-08 04:17:46.891596640 -0700
+++ 25-akpm/fs/binfmt_som.c	2004-05-08 04:17:46.899595424 -0700
@@ -305,5 +305,5 @@ static void __exit exit_som_binfmt(void)
 	unregister_binfmt(&som_format);
 }
 
-module_init(init_som_binfmt);
+core_initcall(init_som_binfmt);
 module_exit(exit_som_binfmt);

_

