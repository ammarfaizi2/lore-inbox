Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWCIAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWCIAMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCIAMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:12:19 -0500
Received: from fmr23.intel.com ([143.183.121.15]:14780 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932305AbWCIAMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:12:18 -0500
Message-Id: <200603090012.k290CDg13307@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Date: Wed, 8 Mar 2006 16:12:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDDbR+Ws8lT532SlK60U/7MkGp4wAADvgA
In-Reply-To: <20060308235805.GC17590@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Wednesday, March 08, 2006 3:58 PM
> > Hmm??  I don't think you need to extend the reservation when extending
> > hugetlb file via ftruncate.  You don't have any vma that pass beyond
> > current size.  So making a reservation is a wrong thing to do here.
> 
> Fwiw, I think truncate *should* extend the reservation.  We have a
> separate thread arguing about whether we should be reserving by inode
> length, as I've implemented, or by which ranges are actually mapped
> (as apw's old path implemented).  As long as it *is* by inode length -
> so it's conceptually all about the logical file in hugetlbfs, not
> about any of its mappings - I think it makes sense for an extending
> truncate() to extend the reservation.  It's not reserving them for any
> particular mapping, it's reserving them for page cache pages.

But you already make reservation at mmap time.  If you reserve it again
when extending the file, won't you double count?

- Ken

