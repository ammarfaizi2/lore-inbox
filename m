Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966274AbWLDTrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbWLDTrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966206AbWLDTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:46:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:38384 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937338AbWLDTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:45:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="170058655:sNHT43349761"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Christoph Hellwig" <hch@infradead.org>
Subject: RE: [patch] remove redundant iov segment check
Date: Mon, 4 Dec 2006 11:45:28 -0800
Message-ID: <000401c717dc$bff0c5e0$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccX2R7GbpvMO3SnR/u/qV0wbu9G4wAAVmYQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <28F99581-3A2A-45BD-8F00-B554313E2C26@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Monday, December 04, 2006 11:19 AM
> On Dec 4, 2006, at 8:26 AM, Chen, Kenneth W wrote:
> 
> > The access_ok() and negative length check on each iov segment in  
> > function
> > generic_file_aio_read/write are redundant.  They are all already  
> > checked
> > before calling down to these low level generic functions.
> 
> ...
> 
> > So it's not possible to call down to generic_file_aio_read/write  
> > with invalid
> > iov segment.
> 
> Well, generic_file_aio_{read,write}() are exported to modules, so  
> anything's *possible*. :)
> 
> This change makes me nervous because it relies on our ability to  
> audit all code paths to ensure that it's correct.  It'd be nice if  
> the code enforced the rules.

Maybe we should create another internal generic_file_aio_read/write
for in-core function? fs/read_write.c and fs/aio.c are not module-able
and the check is already there.  For external module, we can do the
check and then calls down to the internal one.

I hate to see iov is being walked multiple times ....  And this is
part of my effort to bring back O_DIRECT performance compares to a
3-years old vendor kernel based on 2.4 kernel.

- Ken
