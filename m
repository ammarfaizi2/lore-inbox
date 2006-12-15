Return-Path: <linux-kernel-owner+w=401wt.eu-S1753184AbWLOS6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbWLOS6b (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbWLOS6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:58:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:14364 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbWLOS6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:58:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,176,1165219200"; 
   d="scan'208"; a="178005176:sNHT18772635"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'xb'" <xavier.bru@bull.net>, <linux-kernel@vger.kernel.org>,
       "'Zach Brown'" <zach.brown@oracle.com>
Subject: RE: 2.6.18.4: flush_workqueue calls mutex_lock in interruptenvironment
Date: Fri, 15 Dec 2006 10:58:28 -0800
Message-ID: <000201c7207b$022f77c0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccgUYMBJ5WkuMylScaOU6jTH1DZBQAKNoFg
In-Reply-To: <1166191273.5761.18.camel@lade.trondhjem.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote on Friday, December 15, 2006 6:01 AM
> Oops. Missed the fact that you are removed the put_ioctx from
> aio_put_req, but the first sentence is still true. If you try to wake up
> wait_for_all_aios before you've changed the condition it is waiting for,
> then it may end up hanging forever.

The easy fix to that is to put wake_up in aio_complete inside the ctx spin
lock.


> Why not fix this by having the context freed via an RCU callback? That
> way you can protect the combined call to aio_put_req() +
> wake_up(ctx->wait) using a simple preempt_off/preempt_on, and all is
> good.

That has been suggested before on a different subject.  I will whip up
something.
