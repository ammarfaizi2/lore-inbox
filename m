Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUBWNNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUBWNNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:13:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24589 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261831AbUBWNNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:13:33 -0500
Date: Mon, 23 Feb 2004 13:13:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Wahlberg <mikael.wahlberg@ardendo.se>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Per Lejontand <pele@ardendo.se>,
       =?iso-8859-1?Q?Jonas_Engstr=F6m?= <jonas@ardendo.se>
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
Message-ID: <20040223131331.A8778@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Wahlberg <mikael.wahlberg@ardendo.se>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Per Lejontand <pele@ardendo.se>,
	=?iso-8859-1?Q?Jonas_Engstr=F6m?= <jonas@ardendo.se>
References: <20040222164941.D6046@foo.ardendo.se> <20040223121959.A8354@infradead.org> <1077541689.1247.12.camel@harrier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1077541689.1247.12.camel@harrier>; from mikael.wahlberg@ardendo.se on Mon, Feb 23, 2004 at 02:08:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:08:09PM +0100, Mikael Wahlberg wrote:
> If you need any more information please tell us, it is quite urgent for
> us, since we really don't want to go back to 2.4, the performance
> increase with 2.6 is really impressive (Except when it crashes :) 

Can you check whether the small patch below gets rid of you problems?
It still wouldn't explain the JFS problems, though.

--- 1.59/fs/xfs/linux/xfs_aops.c	Mon Feb  9 05:39:27 2004
+++ edited/fs/xfs/linux/xfs_aops.c	Mon Feb 23 15:11:33 2004
@@ -1170,7 +1170,7 @@
 	if (!delalloc && !unwritten)
 		goto free_buffers;
 
-	if (!(gfp_mask & __GFP_FS))
+	if ((gfp_mask & (__GFP_FS|__GFP_WAIT)) != (__GFP_FS|__GFP_WAIT))
 		return 0;
 
 	/* If we are already inside a transaction or the thread cannot
