Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUJ0LWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUJ0LWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUJ0LWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:22:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262381AbUJ0LUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:20:06 -0400
Date: Wed, 27 Oct 2004 13:19:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, golbi@mat.uni.torun.pl,
       wrona@mat.uni.torun.pl
Subject: 2.6.10-rc1-mm1: ipc/mqueue.c: remove unused label
Message-ID: <20041027111934.GE2550@stusta.de>
References: <20041026213156.682f35ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041026213156.682f35ca.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, Oct 26, 2004 at 09:31:56PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-mm1:
>...
> +handle-posix-message-queues-with-proc-sys-disabled.patch
> 
>  POSIX message queue fix.

This removes the only usage of a label, resulting in the following 
compile warning:

<--  snip  -->

...
  CC      ipc/mqueue.o
ipc/mqueue.c: In function `init_mqueue_fs':
ipc/mqueue.c:1245: warning: label `out_cache' defined but not used
...

<--  snip  -->


The patch below removes this label.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/ipc/mqueue.c.old	2004-10-27 13:13:48.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/ipc/mqueue.c	2004-10-27 13:13:57.000000000 +0200
@@ -1242,7 +1242,6 @@
 out_sysctl:
 	if (mq_sysctl_table)
 		unregister_sysctl_table(mq_sysctl_table);
- -out_cache:
 	if (kmem_cache_destroy(mqueue_inode_cachep)) {
 		printk(KERN_INFO
 			"mqueue_inode_cache: not all structures were freed\n");

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBf4RGmfzqmE8StAARAvFLAKDA3nCvvYHMHpvhrOXmvlvvVUh6YwCfeTl6
e+Amr4lm762PEGZnAky/pf8=
=vNvV
-----END PGP SIGNATURE-----
