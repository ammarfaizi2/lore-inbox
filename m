Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163462AbWLGVxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163462AbWLGVxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163463AbWLGVxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:53:01 -0500
Received: from mga03.intel.com ([143.182.124.21]:19667 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163465AbWLGVxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:53:01 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,511,1157353200"; 
   d="scan'208"; a="155331496:sNHT19499802"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nate Diller'" <nate.diller@gmail.com>
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Thu, 7 Dec 2006 13:52:59 -0800
Message-ID: <000201c71a4a$0fa32280$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccaSSI4eoPBtsi+SuqmPbLUZsy62gAABi1g
In-Reply-To: <5c49b0ed0612071346g5bccedd5q709e5ba66808c7fc@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote on Thursday, December 07, 2006 1:46 PM
> the current code is straightforward and obviously correct.  you want
> to make the alloc/dealloc paths more complex, by special-casing for an
> arbitrary limit of "small" I/O, AFAICT.  of *course* you can expect
> less overhead when you're doing one large I/O vs. two small ones,
> that's the whole reason we have all this code to try to coalesce
> contiguous I/O, do readahead, swap page clustering, etc.  we *want*
> more complexity if it will get us bigger I/Os.  I don't see why we
> want more complexity to reduce the *inherent* penalty of doing smaller
> ones.

You should check out the latest proposal from Jens Axboe which treats
all biovec size the same and stuff it along with struct bio.  I think
it is a better approach than my first cut of special casing 1 segment
biovec.  His patch will speed up all sized I/O.

- Ken
