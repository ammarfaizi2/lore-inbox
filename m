Return-Path: <linux-kernel-owner+w=401wt.eu-S1751452AbXAKT4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXAKT4Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXAKT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:56:24 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:14817 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXAKT4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:56:23 -0500
X-IronPort-AV: i="4.13,174,1167638400"; 
   d="scan'208"; a="456754468:sNHT59518088"
To: Nathan Lynch <ntl@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
X-Message-Flag: Warning: May contain useful information
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111192056.GB24623@infradead.org>
	<20070111194054.GA11770@localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 11:56:18 -0800
In-Reply-To: <20070111194054.GA11770@localdomain> (Nathan Lynch's message of "Thu, 11 Jan 2007 13:40:54 -0600")
Message-ID: <adaodp5ibh9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Jan 2007 19:56:19.0103 (UTC) FILETIME=[8F7F6AF0:01C735BA]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 > >  	while (my_cq->nr_callbacks)
 > >  		yield();

 > Isn't that code outright buggy?  Calling into the scheduler with a
 > spinlock held and local interrupts disabled...

Yes, absolutely -- if nr_callbacks is ever nonzero then this will
obviously crash instantly.

 - R.
