Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVF0SQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVF0SQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVF0SQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:16:33 -0400
Received: from fmr24.intel.com ([143.183.121.16]:28843 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261533AbVF0SQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:16:17 -0400
Message-Id: <200506271814.j5RIEwg22390@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "Lincoln Dale" <ltd@cisco.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: RE: [rfc] lockless pagecache
Date: Mon, 27 Jun 2005 11:14:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV6928keiUVJvUgQleTCfKTXmW9DwASyEyw
In-Reply-To: <42BFC10E.50204@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Monday, June 27, 2005 2:04 AM
> >> However I think for Oracle and others that use shared memory like
> >> this, they are probably not doing linear access, so that would be a
> >> net loss. I'm not completely sure (I don't have access to real loads
> >> at the moment), but I would have thought those guys would have looked
> >> into fault ahead if it were a possibility.
> > 
> > 
> > i thought those guys used O_DIRECT - in which case, wouldn't the page 
> > cache not be used?
> > 
> 
> Well I think they do use O_DIRECT for their IO, but they need to
> use the Linux pagecache for their shared memory - that shared
> memory being the basis for their page cache. I think. Whatever
> the setup I believe they have issues with the tree_lock, which is
> why it was changed to an rwlock.

Typically shared memory is used as db buffer cache, and O_DIRECT is
performed on these buffer cache (hence O_DIRECT on the shared memory).
You must be thinking some other workload.  Nevertheless, for OLTP type
of db workload, tree_lock hasn't been a problem so far.

- Ken

