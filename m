Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVCKART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVCKART (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVCKAQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:16:20 -0500
Received: from [205.233.219.253] ([205.233.219.253]:65228 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262988AbVCKAK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:10:28 -0500
Date: Thu, 10 Mar 2005 19:10:06 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: linux-kernel@vger.kernel.org
Cc: willy@debian.org
Subject: Re: [PATCH, RFC 3/3] Use sem_getcount in xfs
Message-ID: <20050311001006.GL1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert XFS to use sem_getcount instead of nasty hack.  Should fix warning
with XFS debugging on PARISC.  Untested since there is no obvious way to
turn on XFS debugging.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- 1394-dev.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-03-10 18:20:13.000000000 -0500
+++ 1394-dev/fs/xfs/linux-2.6/xfs_buf.c	2005-03-10 18:20:55.000000000 -0500
@@ -976,7 +976,7 @@ int
 pagebuf_lock_value(
 	xfs_buf_t		*pb)
 {
-	return(atomic_read(&pb->pb_sema.count));
+	return(sem_getcount(&pb->pb_sema));
 }
 #endif
 
