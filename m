Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266918AbUAXMBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUAXMBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:01:18 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:5258 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S266918AbUAXMBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:01:16 -0500
Date: Sat, 24 Jan 2004 13:01:13 +0100
From: Tim Cambrant <tim@cambrant.com>
To: John Cherry <cherry@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: [PATCH] Re: IA32 (2.6.2-rc1 - 2004-01-23.22.30) - 2 New warnings (gcc 3.2.2)
Message-ID: <20040124120113.GA26460@cambrant.com>
References: <200401241113.i0OBDnfH017530@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401241113.i0OBDnfH017530@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 03:13:49AM -0800, John Cherry wrote:
> fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function

This patch will initialize the ushort 'flags'. This is _really_ trivial, and
isn't needed, but if it's important to remove as many warnings as possible,
then this patch will sort it out.


--- linux-2.6.2-rc/fs/xfs/xfs_log_recover.c.orig	Sat Jan 24 12:49:07 2004
+++ linux-2.6.2-rc/fs/xfs/xfs_log_recover.c	Sat Jan 24 12:51:38 2004
@@ -1531,7 +1531,7 @@ xlog_recover_reorder_trans(
 	xlog_recover_item_t	*first_item, *itemq, *itemq_next;
 	xfs_buf_log_format_t	*buf_f;
 	xfs_buf_log_format_v1_t	*obuf_f;
-	ushort			flags;
+	ushort			flags = 0;
 
 	first_item = itemq = trans->r_itemq;
 	trans->r_itemq = NULL;


Apply this if it's really needed. GCC 3.4 doesn't give any warnings though.

                Tim Cambrant
