Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWJMAAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWJMAAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWJMAAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:00:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:36974 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751344AbWJMAAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:00:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="3368490:sNHT335317284"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "'linux-aio'" <linux-aio@kvack.org>
Subject: [patch] clarify AIO_EVENTS_OFFSET constant
Date: Thu, 12 Oct 2006 17:00:24 -0700
Message-ID: <000301c6ee5a$9dfae250$db34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbuWpUOj6XXIxnsQga5s3ALMZCUDg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A clean up patch: I think it is a lot easier to read AIO_EVENTS_OFFSET
as an offset because of aio_ring at the beginning of a head page, instead
of doing arithmetic of (event on 2nd page - event on 1st page).


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.18/fs/aio.c linux-2.6.18.ken/fs/aio.c
--- linux-2.6.18/fs/aio.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.ken/fs/aio.c	2006-10-12 13:33:09.000000000 -0700
@@ -173,9 +173,8 @@ static int aio_setup_ring(struct kioctx 
 /* aio_ring_event: returns a pointer to the event at the given index from
  * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
  */
-#define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
-#define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
-#define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
+#define AIO_EVENTS_PER_PAGE  (PAGE_SIZE / sizeof(struct io_event))
+#define AIO_EVENTS_OFFSET    (sizeof(struct aio_ring) / sizeof(struct io_event))
 
 #define aio_ring_event(info, nr, km) ({					\
 	unsigned pos = (nr) + AIO_EVENTS_OFFSET;			\

