Return-Path: <linux-kernel-owner+w=401wt.eu-S1753015AbXACBXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbXACBXO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbXACBXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:23:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:43870 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbXACBXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:23:13 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="180832366:sNHT25228427"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: make aio_ring_info->nr_pages an unsigned int
Date: Tue, 2 Jan 2007 17:23:13 -0800
Message-ID: <000e01c72ed5$bcbb9430$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu1H4IK4ve1fHzQqSz/9L1tprcTgAAH/PQ
In-Reply-To: <F7E6E752-C6CE-4A89-A716-3C7367EF1FF8@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 5:14 PM
> To: Chen, Kenneth W
> > --- ./include/linux/aio.h.orig	2006-12-24 22:31:55.000000000 -0800
> > +++ ./include/linux/aio.h	2006-12-24 22:41:28.000000000 -0800
> > @@ -165,7 +165,7 @@ struct aio_ring_info {
> >
> >  	struct page		**ring_pages;
> >  	spinlock_t		ring_lock;
> > -	long			nr_pages;
> > +	unsigned		nr_pages;
> >
> >  	unsigned		nr, tail;
> 
> Hmm.
> 
> This seems so trivial as to not be worth it.  It'd be more compelling  
> if it was more thorough -- doing things like updating the 'long i'  
> iterators that a feww have over ->nr_pages.  That kind of thing.   
> Giving some confidence that the references of ->nr_pages were audited.


I had that changes earlier, but dropped it to make the patch smaller. It
all started with head and tail index, which is defined as unsigned int in
structure, but in aio.c, all local variables that does temporary head and
tail calculation are unsigned long. While cleaning that, it got expanded
into nr_pages etc.  Oh well.

- Ken

