Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbRFECVw>; Mon, 4 Jun 2001 22:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbRFECVm>; Mon, 4 Jun 2001 22:21:42 -0400
Received: from mailout1-0.nyroc.rr.com ([24.92.226.81]:36248 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S263100AbRFECVe>; Mon, 4 Jun 2001 22:21:34 -0400
Message-ID: <04ea01c0ed67$ad3f38f0$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
Subject: forcibly unmap pages in driver?
Date: Mon, 4 Jun 2001 22:31:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a device driver that, like many others, exposes a shared memory
region to user-space via mmap(). The region is allocated with vmalloc(), the
pages are marked reserved, and the user-space mapping is implemented with
remap_page_range().

In my driver, I may have to free the underlying vmalloc() region while the
user-space program is still running. I need to remove the user-space
mapping -- otherwise the user process would still have access to the
now-freed pages. I need an inverse of remap_page_range().

Is zap_page_range() the function I am looking for? Unfortunately it's not
exported to modules =(. As a quick fix, I was thinking I could just remap
all of the user pages to point to a zeroed page or something...

Another question- in the mm.c sources, I see that many of the memory-mapping
functions are surrounded by calls to flush_cache_range() and
flush_tlb_range(). But I don't see these calls in many drivers. Is it
necessary to make them when my driver maps or unmaps the shared memory
region?

Regards,
Dan

