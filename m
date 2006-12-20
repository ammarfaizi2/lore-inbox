Return-Path: <linux-kernel-owner+w=401wt.eu-S1030269AbWLTTLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWLTTLm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWLTTLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:11:42 -0500
Received: from mga03.intel.com ([143.182.124.21]:42828 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030269AbWLTTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:11:41 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,193,1165219200"; 
   d="scan'208"; a="160679918:sNHT21179662"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Kiyoshi Ueda'" <k-ueda@ct.jp.nec.com>, <jens.axboe@oracle.com>
Cc: <agk@redhat.com>, <mchristi@redhat.com>, <linux-kernel@vger.kernel.org>,
       <dm-devel@redhat.com>, <j-nomura@ce.jp.nec.com>
Subject: RE: [RFC PATCH 1/8] rqbased-dm: allow blk_get_request() to be called from interrupt context
Date: Wed, 20 Dec 2006 11:11:40 -0800
Message-ID: <000001c7246a$ae31c8a0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcckX6wbJy1Mh0qMRyi6tXiuEosHVQACjdhg
In-Reply-To: <20061220.125002.71083198.k-ueda@ct.jp.nec.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kiyoshi Ueda wrote on Wednesday, December 20, 2006 9:50 AM
> On Wed, 20 Dec 2006 14:48:49 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> > Big NACK on this - it's not only really ugly, it's also buggy to pass
> > interrupt flags as function arguments. As you also mention in the 0/1
> > mail, this also breaks CFQ.
> > 
> > Why do you need in-interrupt request allocation?
>  
> Because I'd like to use blk_get_request() in q->request_fn()
> which can be called from interrupt context like below:
>   scsi_io_completion -> scsi_end_request -> scsi_next_command
>   -> scsi_run_queue -> blk_run_queue -> q->request_fn
> 
> [ ...]
> 
> Do you think creating another function like blk_get_request_nowait()
> is acceptable?

You don't need to create another function.  blk_get_request already
have both wait and nowait semantics via gfp_mask argument. If you can
not block, then clear __GFP_WAIT bit in the mask before calling
blk_get_request.

- Ken
