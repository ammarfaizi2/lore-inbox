Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbXAKTlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXAKTlI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXAKTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:41:07 -0500
Received: from rune.pobox.com ([208.210.124.79]:42439 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbXAKTlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:41:05 -0500
Date: Thu, 11 Jan 2007 13:40:54 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
       openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
Message-ID: <20070111194054.GA11770@localdomain>
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com> <20070111192056.GB24623@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111192056.GB24623@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Jan 11, 2007 at 08:08:36PM +0100, Hoang-Nam Nguyen wrote:
> 
> >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
> >  	while (my_cq->nr_callbacks)
> >  		yield();
> 
> Calling yield is a very bad idea in general.  You should probably
> add a waitqueue that gets woken when nr_callbacks reaches zero to
> sleep effectively here.

Isn't that code outright buggy?  Calling into the scheduler with a
spinlock held and local interrupts disabled...

