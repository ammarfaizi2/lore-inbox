Return-Path: <linux-kernel-owner+w=401wt.eu-S964944AbWLMFdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWLMFdL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWLMFdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:33:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:12629 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964942AbWLMFdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:33:09 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:33:09 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,160,1165219200"; 
   d="scan'208"; a="173791871:sNHT67998238"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'AVANTIKA R. MATHUR'" <mathur@linux.vnet.ibm.com>,
       "Jens Axboe" <jens.axboe@oracle.com>
Cc: "Avantika Mathur" <mathur@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: RE: cfq performance gap
Date: Tue, 12 Dec 2006 21:23:31 -0800
Message-ID: <000001c71e76$d4930e90$bb89030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcceVsEdh/xCMgspS3uWm/7J1Hf9kQAHminA
In-Reply-To: <457F583B.9090109@linux.vnet.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AVANTIKA R. MATHUR wrote on Tuesday, December 12, 2006 5:33 PM
> >> rawio is actually performing sequential reads, but I don't believe it is
> >> purely sequential with the multiple processes.
> >> I am currently running the test with longer runtimes and will post
> >> results once it is complete.
> >> I've also attached the rawio source.
> >>     
> >
> > It's certainly the slice and idling hurting here. But at the same time,
> > I don't really think your test case is very interesting. The test area
> > is very small and you have 16 threads trying to read the same thing,
> > optimizing for that would be silly as I don't think it has much real
> > world relevance.
> 
> Could a database have similar workload to this test?


No.

Not what I have seen with db workloads exhibits such pattern.  There are
basically two types of db workloads: one does transaction processing, and
I/O pattern are truly random with large stride, both in the context of
process and overall I/O seen at device level.  A second one is decision
making type of db queries.  They does large sequential I/O within one
process context.

This rawio test plows through sequential I/O and modulo each small record
over number of threads.  So each thread appears to be non-contiguous within
its own process context, overall request hitting the device are sequential.
I can't see how any application does that kind of I/O pattern.

- Ken
