Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbUJ0Qmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUJ0Qmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUJ0QiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:38:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262508AbUJ0Qfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:35:44 -0400
Message-ID: <417FCE4E.4080605@pobox.com>
Date: Wed, 27 Oct 2004 12:35:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]> <1246750000.1098892883@[10.10.2.4]>
In-Reply-To: <1246750000.1098892883@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------090508010108060408080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090508010108060408080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
> To repeat what I said in IRC ... ;-)
> 
> Actually, you could check this with the pfns being the same when >> MAX_ORDER-1.
> We should be aligned on a MAX_ORDER boundary, I think.
> 
> However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If rather slower.


Is this patch acceptable to everyone?  Andrew?

It uses the publicly-exported pfn_to_page/page_to_pfn abstraction, which 
seems to be the only way to accomplish what we want to do in IDE/libata.

	Jeff



--------------090508010108060408080403
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/linux/mm.h 1.193 vs edited =====
--- 1.193/include/linux/mm.h	2004-10-20 04:37:06 -04:00
+++ edited/include/linux/mm.h	2004-10-27 12:33:28 -04:00
@@ -41,6 +41,8 @@
 #define MM_VM_SIZE(mm)	TASK_SIZE
 #endif
 
+#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + n)
+
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way

--------------090508010108060408080403--
