Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272068AbTHDTTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272135AbTHDTTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:19:06 -0400
Received: from ns.suse.de ([213.95.15.193]:6406 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272068AbTHDTTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:19:02 -0400
To: "H. J. Lu" <hjl@lucon.org>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<20030804175308.GB16804@lucon.org> <20030804180015.GA543@sgi.com>
	<20030804181033.GA17265@lucon.org> <20030804185231.GA532@sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  I like my new DENTIST...
Date: Mon, 04 Aug 2003 21:18:57 +0200
In-Reply-To: <20030804185231.GA532@sgi.com> (Jesse Barnes's message of "Mon,
 4 Aug 2003 11:52:31 -0700")
Message-ID: <jesmohfcym.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) writes:

|> diff -Nru a/fs/xfs/linux/xfs_vfs.h b/fs/xfs/linux/xfs_vfs.h
|> --- a/fs/xfs/linux/xfs_vfs.h	Wed Jul 16 12:10:39 2003
|> +++ b/fs/xfs/linux/xfs_vfs.h	Wed Jul 16 12:10:39 2003
|> @@ -44,8 +44,8 @@
|>  
|>  typedef struct vfs {
|>  	u_int			vfs_flag;	/* flags */
|> -	fsid_t			vfs_fsid;	/* file system ID */
|> -	fsid_t			*vfs_altfsid;	/* An ID fixed for life of FS */
|> +	__kernel_fsid_t			vfs_fsid;	/* file system ID */
|> +	__kernel_fsid_t			*vfs_altfsid;	/* An ID fixed for life of FS */
|>  	bhv_head_t		vfs_bh;		/* head of vfs behavior chain */
|>  	struct super_block	*vfs_super;	/* Linux superblock structure */
|>  	struct task_struct	*vfs_sync_task;

Alternatively you could use this patch (following the other
architectures):

--- linux-2.5.73/include/asm-ia64/statfs.h.~1~	2003-06-22 20:32:55.000000000 +0200
+++ linux-2.5.73/include/asm-ia64/statfs.h	2003-07-01 16:14:44.000000000 +0200
@@ -6,6 +6,11 @@
  * Copyright (C) 1998, 1999 David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
+#ifndef __KERNEL_STRICT_NAMES
+# include <linux/types.h>
+typedef __kernel_fsid_t	fsid_t;
+#endif
+
 /*
  * This is ugly --- we're already 64-bit, so just duplicate the definitions
  */

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
