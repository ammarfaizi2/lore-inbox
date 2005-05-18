Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVEROeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVEROeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVEROdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:33:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25573 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262227AbVEROKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:10:24 -0400
Date: Wed, 18 May 2005 15:09:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Russell Miller <rmiller@duskglow.com>, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30 xfs bug
Message-ID: <20050518140958.GA22771@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Miller <rmiller@duskglow.com>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org
References: <200505121117.01192.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505121117.01192.rmiller@duskglow.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:17:01AM -0700, Russell Miller wrote:
> 2.4.30 will not compile if XFS is turned on, but XFS debugging is not.  
> Culprit is:
> 
> fs/xfs/linux-2.4/xfs_buf.c line 1076.  Apparently pagebuf_lock_value is used 
> somewhere else, even if it's not defined because debugging is off.

Looks like a trivial one-liner got lost when merging from the SGI CVS tree.

Macelo, can you apply this little patch below?


--- 1.195/fs/xfs/linux-2.4/xfs_buf.c	2005-01-12 01:08:23 +01:00
+++ edited/fs/xfs/linux-2.4/xfs_buf.c	2005-05-18 16:06:09 +02:00
@@ -1073,7 +1073,7 @@ pagebuf_cond_lock(			/* lock buffer, if 
 	return(locked ? 0 : -EBUSY);
 }
 
-#ifdef DEBUG
+#if defined(DEBUG) || defined(XFS_BLI_TRACE)
 /*
  *	pagebuf_lock_value
  *
