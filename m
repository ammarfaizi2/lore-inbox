Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269687AbUH0AOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269687AbUH0AOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269843AbUH0AOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:14:39 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:16091 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269687AbUH0AJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:09:49 -0400
Message-ID: <412E7B8F.5050502@ttnet.net.tr>
Date: Fri, 27 Aug 2004 03:08:47 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com, willy@w.ods.org
Subject: [PATCH 2.4] fix typo in mm.h introduced 2.4.28-pre2
References: <412E4F43.9030801@ttnet.net.tr> <20040826221229.GB564@alpha.home.local> <412E69DC.5050907@ttnet.net.tr>
In-Reply-To: <412E69DC.5050907@ttnet.net.tr>
Content-Type: multipart/mixed;
	boundary="------------080903080202030001040601"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080903080202030001040601
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

> All the evidence points
> to the s390 changes in -pre2, specificly cset-1.1514 by schwidefsky
> which touches include/linux/mm.h this way:
> 
> --- 1.44/include/linux/mm.h    2004-08-26 15:51:04 -07:00
> +++ 1.45/include/linux/mm.h    2004-08-26 15:51:04 -07:00
> @@ -308,11 +308,9 @@
> /* Make it prettier to test the above... */
> #define UnlockPage(page)    unlock_page(page)
> #define Page_Uptodate(page)    test_bit(PG_uptodate, &(page)->flags)
> -#define SetPageUptodate(page) \
> -    do {                                \
> -        arch_set_page_uptodate(page);                \
> -        set_bit(PG_uptodate, &(page)->flags);            \
> -    } while (0)
> +#ifndef SetPageUptodate
> +#define SetPageUptodate(page)    set_bit(PG_uptodate, &(page)->flags);
> +#endif
> #define ClearPageUptodate(page)    clear_bit(PG_uptodate, &(page)->flags)
> #define PageDirty(page)        test_bit(PG_dirty, &(page)->flags)
> #define SetPageDirty(page)    set_bit(PG_dirty, &(page)->flags)
> 
> Marcelo, you maybe interested in this.
> 
> Cheers,
> Ozkan Sezer
> 

And I beleive this was a typo? Marcelo, please review and apply.

Ozkan Sezer


--------------080903080202030001040601
Content-Type: text/plain;
	name="mm.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="mm.h.diff"

--- 28p2/include/linux/mm.h.BAK	2004-08-27 02:39:21.000000000 +0300
+++ 28p2/include/linux/mm.h	2004-08-27 02:56:10.000000000 +0300
@@ -309,7 +309,7 @@
 #define UnlockPage(page)	unlock_page(page)
 #define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
 #ifndef SetPageUptodate
-#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags);
+#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
 #endif
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 #define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)

--------------080903080202030001040601--
