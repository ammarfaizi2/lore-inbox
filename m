Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSHAONj>; Thu, 1 Aug 2002 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSHAONj>; Thu, 1 Aug 2002 10:13:39 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25727 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312973AbSHAONi>; Thu, 1 Aug 2002 10:13:38 -0400
Date: Thu, 1 Aug 2002 16:17:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc4aa1
Message-ID: <20020801141703.GT1132@dualathlon.random>
References: <20020801055124.GB1132@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801055124.GB1132@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 07:51:24AM +0200, Andrea Arcangeli wrote:
> This may be the last update for a week (unless there's a quick bug to
> fix before next morning :). I wanted to ship async-io and largepage

I would like to thank Randy Hron for reproducing this problem so
quickly with the ltp testsuite:

>>EIP; 80132cc2 <shmem_writepage+22/130>   <=====

here the fix:

--- 2.4.19rc4aa1/include/linux/mm.h.~1~	Thu Aug  1 07:15:54 2002
+++ 2.4.19rc4aa1/include/linux/mm.h	Thu Aug  1 16:13:56 2002
@@ -296,8 +296,8 @@ typedef struct page {
 #define PG_checked		12	/* kill me in 2.5.<early>. */
 #define PG_arch_1		13
 #define PG_reserved		14
-#define PG_bigpage		15
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_bigpage		16
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)


new rc4aa2 with this single fix is coming, if anybody else found any
other problem please let me know ASAP :), thanks.

Andrea
