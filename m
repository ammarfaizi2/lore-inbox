Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUIWQt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUIWQt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWQtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:49:06 -0400
Received: from holomorphy.com ([207.189.100.168]:61399 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268174AbUIWQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:48:42 -0400
Date: Thu, 23 Sep 2004 09:48:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-ID: <20040923164835.GE9106@holomorphy.com>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 01:12:10PM -0700, Andrew Morton wrote:
> +reiser4-plugin_set_done-memleak-fix.patch
> +reiser4-init-max_atom_flusers.patch
> +reiser4-parse-options-reduce-stack-usage.patch
> +reiser4-sparce64-warning-fix.patch
> +reiser4-x86_64-warning-fix.patch
> +reiser4-fix-mount-option-parsing.patch
> +reiser4-parse-option-cleanup.patch
> +reiser4-comment-fix.patch
> +reiser4-fill_super-improve-warning.patch
> +reiser4-disable-pseudo.patch
> +reiser4-disable-repacker.patch
>  reiser4 update

in_interrupt() requires hardirq.h; without this reiser4 fails to link.

Index: mm2-2.6.9-rc2/fs/reiser4/plugin/cryptcompress.c
===================================================================
--- mm2-2.6.9-rc2.orig/fs/reiser4/plugin/cryptcompress.c	2004-09-23 09:01:45.749541424 -0700
+++ mm2-2.6.9-rc2/fs/reiser4/plugin/cryptcompress.c	2004-09-23 09:18:19.243507384 -0700
@@ -43,6 +43,7 @@
 #include <linux/pagemap.h>
 #include <linux/crypto.h>
 #include <linux/swap.h>
+#include <linux/hardirq.h>
 
 int do_readpage_ctail(reiser4_cluster_t *, struct page * page);
 int ctail_read_cluster (reiser4_cluster_t *, struct inode *, int);
