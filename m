Return-Path: <linux-kernel-owner+w=401wt.eu-S1161307AbXAMKvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbXAMKvT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 05:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbXAMKvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 05:51:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3316 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161307AbXAMKvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 05:51:18 -0500
Date: Sat, 13 Jan 2007 11:51:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, jffs-dev@axis.com,
       dwmw2@infradead.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Subject: [2.6 patch] fix the JFFS2_FS_DEBUG=2 compilation
Message-ID: <20070113105122.GL7469@stusta.de>
References: <20070112210537.GA24451@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112210537.GA24451@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:05:37PM +0000, Russell King wrote:
> The following configuration:
> 
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=2
> # CONFIG_JFFS2_FS_NAND is not set
> # CONFIG_JFFS2_FS_NOR_ECC is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_RTIME=y
> # CONFIG_JFFS2_RUBIN is not set
> 
> results in these build errors:
> 
> fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
> fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplete type
> fs/jffs2/malloc.c: In function 'jffs2_free_full_dirent':
> fs/jffs2/malloc.c:132: error: dereferencing pointer to incomplete type
> fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dnode':
> fs/jffs2/malloc.c:140: error: dereferencing pointer to incomplete type
> fs/jffs2/malloc.c: In function 'jffs2_free_full_dnode':
> fs/jffs2/malloc.c:146: error: dereferencing pointer to incomplete type
> fs/jffs2/malloc.c: In function 'jffs2_alloc_raw_dirent':
> fs/jffs2/malloc.c:154: error: dereferencing pointer to incomplete type
> 
> ... etc ...

Thanks for the report, patch below.

cu
Adrian


<--  snip  -->


This patch fixes the following CONFIG_JFFS2_FS_DEBUG=2 compile 
breakage introduced by commit 914e26379decf1fd984b22e51fd2e4209b7a7f1b:

<--  snip  -->

...
fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dirent':
fs/jffs2/malloc.c:126: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_free_full_dirent':
fs/jffs2/malloc.c:132: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_alloc_full_dnode':
fs/jffs2/malloc.c:140: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_free_full_dnode':
fs/jffs2/malloc.c:146: error: dereferencing pointer to incomplete type
fs/jffs2/malloc.c: In function 'jffs2_alloc_raw_dirent':
fs/jffs2/malloc.c:154: error: dereferencing pointer to incomplete type
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

commit 3a7722fc440d5214a718bc4b90b7691c04a1af67
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Jan 13 11:50:44 2007 +0100

    sadf

diff --git a/fs/jffs2/debug.h b/fs/jffs2/debug.h
index 3daf3bc..f89c85d 100644
--- a/fs/jffs2/debug.h
+++ b/fs/jffs2/debug.h
@@ -13,6 +13,7 @@
 #ifndef _JFFS2_DEBUG_H_
 #define _JFFS2_DEBUG_H_
 
+#include <linux/sched.h>
 
 #ifndef CONFIG_JFFS2_FS_DEBUG
 #define CONFIG_JFFS2_FS_DEBUG 0

