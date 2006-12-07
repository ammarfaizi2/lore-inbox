Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032036AbWLGLGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032036AbWLGLGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032035AbWLGLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:06:34 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34854 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032030AbWLGLGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:06:32 -0500
Date: Thu, 7 Dec 2006 11:59:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 29/35] Unionfs: Superblock operations
In-Reply-To: <11652354723550-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612071154290.2863@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354723550-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:
>+int init_inode_cache(void)
>+{
>+	int err = 0;
>+
>+	unionfs_inode_cachep =
>+	    kmem_cache_create("unionfs_inode_cache",
>+			      sizeof(struct unionfs_inode_info), 0,
>+			      SLAB_RECLAIM_ACCOUNT, init_once, NULL);
>+	if (!unionfs_inode_cachep)
>+		err = -ENOMEM;
>+	return err;
>+}
>+
>+void destroy_inode_cache(void)
>+{
>+	if (unionfs_inode_cachep)
>+		kmem_cache_destroy(unionfs_inode_cachep);
>+}

These function names could possibly clash with same-named functions
elsewhere, because they are not marked static. (This shows when two
features with same function names are compiled as y.) I grepped
through a 2.6.18 tree with unionfs, and unionfs was the only one
having this function name at this time. I would suggest prefixing it
somehow.


	-`J'
-- 
