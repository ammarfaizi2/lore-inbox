Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTEOTkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEOTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:40:00 -0400
Received: from holomorphy.com ([66.224.33.161]:63952 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264182AbTEOTj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:39:58 -0400
Date: Thu, 15 May 2003 12:51:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm5
Message-ID: <20030515195157.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030514012947.46b011ff.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514012947.46b011ff.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 01:29:47AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm5/
> 
> Various fixes.  It should even compile on uniprocessor.
> I dropped all the NFS client changes, which have been in -mm for ages.  A
> number of fixes have been merged into Linus's tree and they need testing on
> their own.


put_page_testzero() does BUG_ON(page_count(page)) when its argument
is p.

-- wli


diff -prauN linux-2.5.69-bk9/include/linux/mm.h numaq-2.5.69-bk9-1/include/linux/mm.h
--- linux-2.5.69-bk9/include/linux/mm.h	2003-05-15 12:01:44.000000000 -0700
+++ numaq-2.5.69-bk9-1/include/linux/mm.h	2003-05-15 12:26:34.000000000 -0700
@@ -214,7 +214,7 @@ struct page {
  */
 #define put_page_testzero(p)				\
 	({						\
-		BUG_ON(page_count(page) == 0);		\
+		BUG_ON(page_count(p) == 0);		\
 		atomic_dec_and_test(&(p)->count);	\
 	})
 
