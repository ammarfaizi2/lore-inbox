Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUHXMfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUHXMfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 08:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUHXMfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 08:35:18 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60168 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267659AbUHXMfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 08:35:09 -0400
Date: Tue, 24 Aug 2004 13:35:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS compilation warning in 2.6.9-rc1
Message-ID: <20040824133504.A28488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Clayton <andrew@digital-domain.net>,
	linux-kernel@vger.kernel.org
References: <1093350616.2237.8.camel@alpha.digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1093350616.2237.8.camel@alpha.digital-domain.net>; from andrew@digital-domain.net on Tue, Aug 24, 2004 at 01:30:16PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 01:30:16PM +0100, Andrew Clayton wrote:
>   CC      fs/xfs/xfs_bmap.o
> fs/xfs/xfs_bmap.c: In function `xfs_bmap_do_search_extents':
> fs/xfs/xfs_bmap.c:3434: warning: integer constant is too large for
> "long" type
> fs/xfs/xfs_bmap.c:3435: warning: integer constant is too large for
> "long" type
>   CC      fs/xfs/xfs_bmap_btree.o


--- 1.26/fs/xfs/xfs_bmap.c	2004-08-19 05:36:06 +02:00
+++ edited/fs/xfs/xfs_bmap.c	2004-08-24 14:35:40 +02:00
@@ -3431,15 +3431,16 @@
 	* uninitialized br_startblock field.
 	*/
 
-        got.br_startoff = 0xffa5a5a5a5a5a5a5;
-        got.br_blockcount = 0xa55a5a5a5a5a5a5a;
+        got.br_startoff = 0xffa5a5a5a5a5a5a5LL;
+        got.br_blockcount = 0xa55a5a5a5a5a5a5aLL;
         got.br_state = XFS_EXT_INVALID;
 
-	#if XFS_BIG_BLKNOS
-        	got.br_startblock = 0xffffa5a5a5a5a5a5;
-	#else
-		got.br_startblock = 0xffffa5a5;
-	#endif
+#if XFS_BIG_BLKNOS
+	got.br_startblock = 0xffffa5a5a5a5a5a5LL;
+#else
+	got.br_startblock = 0xffffa5a5;
+#endif
+
 	if (lastx != NULLEXTNUM && lastx < nextents)
 		ep = base + lastx;
 	else
