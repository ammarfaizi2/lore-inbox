Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWCIAdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWCIAdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWCIAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:33:14 -0500
Received: from fmr22.intel.com ([143.183.121.14]:23756 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932652AbWCIAdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:33:13 -0500
Message-Id: <200603090033.k290XBg13472@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Date: Wed, 8 Mar 2006 16:33:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDD739y2SyqJA7QGu+ICUowBTjaQAAIjfQ
In-Reply-To: <20060309002251.GE17590@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Wednesday, March 08, 2006 4:23 PM
> > But you already make reservation at mmap time.  If you reserve it again
> > when extending the file, won't you double count?
> 
> Well, I'd generally expect extending truncate() to come before mmap(),
> but in any case hugetlb_extend_reservation() is safe against double
> counting (it's idempotent if called twice with the same number of
> pages).  The semantics are "ensure the this many pages total are
> guaranteed available, that is, either reserved or already
> instantiated".

It's kind of peculiar that kernel reserve hugetlb page at the time of
extending truncate.  Maybe there is a close correlation between mmap
size to the file size.  But these two aren't the same and and shouldn't
be mixed.

- Ken

