Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWBJMbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWBJMbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBJMbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:31:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64011 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751235AbWBJMbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:31:15 -0500
Date: Fri, 10 Feb 2006 13:31:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, xfs-masters@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: [-mm patch] fs/xfs/linux-2.6/xfs_linux.h: #if CONFIG_SMP -> #ifdef CONFIG_SMP
Message-ID: <20060210123114.GC19918@stusta.de>
References: <20060207220627.345107c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm5:
>...
>  git-xfs.patch
>...
>  Git trees
>...

When compiling with gcc 4.0 and CONFIG_SMP unset, there are tons of the 
following warnings:

<--  snip  -->

...
  CC      fs/xfs/quota/xfs_dquot_item.o
In file included from fs/xfs/xfs.h:20,
                 from fs/xfs/quota/xfs_dquot_item.c:18:
fs/xfs/linux-2.6/xfs_linux.h:103:5: warning: "CONFIG_SMP" is not defined
  CC      fs/xfs/quota/xfs_trans_dquot.o
In file included from fs/xfs/xfs.h:20,
                 from fs/xfs/quota/xfs_trans_dquot.c:18:
fs/xfs/linux-2.6/xfs_linux.h:103:5: warning: "CONFIG_SMP" is not defined
  CC      fs/xfs/quota/xfs_qm_syscalls.o
In file included from fs/xfs/xfs.h:20,
                 from fs/xfs/quota/xfs_qm_syscalls.c:21:
fs/xfs/linux-2.6/xfs_linux.h:103:5: warning: "CONFIG_SMP" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/fs/xfs/linux-2.6/xfs_linux.h.old	2006-02-10 12:17:32.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/fs/xfs/linux-2.6/xfs_linux.h	2006-02-10 12:18:05.000000000 +0100
@@ -100,7 +100,7 @@
  */
 #undef  HAVE_REFCACHE	/* reference cache not needed for NFS in 2.6 */
 #define HAVE_SENDFILE	/* sendfile(2) exists in 2.6, but not in 2.4 */
-#if CONFIG_SMP
+#ifdef CONFIG_SMP
 #define HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
 #else
 #undef  HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */

