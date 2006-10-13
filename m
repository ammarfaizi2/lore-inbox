Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWJMUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWJMUiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWJMUiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:38:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:11111 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751890AbWJMUiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:38:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,308,1157353200"; 
   d="scan'208"; a="144705334:sNHT17240944"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Benjamin LaHaise'" <bcrl@kvack.org>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       <linux-kernel@vger.kernel.org>, "'linux-aio'" <linux-aio@kvack.org>
Subject: RE: [patch] clarify AIO_EVENTS_OFFSET constant
Date: Fri, 13 Oct 2006 13:38:01 -0700
Message-ID: <000501c6ef07$79c1c770$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acbu0x4q2TGEejUAQUCD+YCjSYY9ZAAM2hIQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20061013142257.GJ4141@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote on Friday, October 13, 2006 7:23 AM
> On Thu, Oct 12, 2006 at 05:00:24PM -0700, Chen, Kenneth W wrote:
> > A clean up patch: I think it is a lot easier to read AIO_EVENTS_OFFSET
> > as an offset because of aio_ring at the beginning of a head page, instead
> > of doing arithmetic of (event on 2nd page - event on 1st page).
> 
> Nak.  Your change fails if aio_ring is not an exact multiple of the 
> io_event size due to rounding errors, while the original code rounds 
> correctly.


Yeah, neither form is bullet proof, even the original one will break down
when io_event size is not in power of 2.  The good news is that no where
near in sight that these two data structures size will change.

To make it a real bullet proof, it should be something like the following:

#define AIO_EVENTS_OFFSET       ((sizeof(struct aio_ring) +             \
                                  sizeof(struct io_event) - 1 ) /       \
                                  sizeof(struct io_event))

