Return-Path: <linux-kernel-owner+w=401wt.eu-S1751039AbXAVPdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbXAVPdA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXAVPdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:33:00 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:47975 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbXAVPc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:32:59 -0500
Subject: Re: [RFC 1/6] bidi support: request dma_data_direction
From: James Bottomley <James.Bottomley@SteelEye.com>
To: dougg@torque.net
Cc: Benny Halevy <bhalevy@panasas.com>, Boaz Harrosh <bharrosh@panasas.com>,
       Jens Axboe <jens.axboe@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
       Daniel.E.Messinger@seagate.com, Liran Schour <LIRANS@il.ibm.com>
In-Reply-To: <45B4D2A0.4080201@torque.net>
References: <45B3F578.7090109@panasas.com> <45B40458.9010107@torque.net>
	 <45B4547A.3020105@panasas.com>  <45B4D2A0.4080201@torque.net>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 09:31:43 -0600
Message-Id: <1169479903.2769.20.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-22 at 10:05 -0500, Douglas Gilbert wrote:
> Perhaps the right use of DMA_BIRECTIONAL needs to be
> defined.
> 
> Could it be used with a XDWRITE(10) SCSI command
> defined in sbc3r07.pdf at http://www.t10.org ? I suspect
> using two scatter gather lists would be a better approach.
> 
> >>> - Introduce new blk_rq_init_unqueued_req() and use it in places ad-hoc
> >>>   requests were used and bzero'ed.
> >> With a bi-directional transfer is it always unambiguous
> >> which transfer occurs first (or could they occur at
> >> the same time)?
> > 
> > The bidi transfers can occur in any order and in parallel.

> Then it is not sufficient for modern SCSI transports in which
> certain bidirectional commands (probably most) have a well
> defined order.

Right, that's why I think bi-directional needs to be one way op followed
by one way op ... even if it is to the same buffer.  That should be a
general enough paradigm for everything.

> So DMA_BIDIRECTIONAL looks PCI specific and it may have
> been a mistake to replace other subsystem's direction flags
> with it. RDMA might be an interesting case.

It's bus specific ... it means that the bus must be programmed to expect
the device to transfer both to and from the memory buffer.  There are a
very few drivers which do this when they don't know the actual transfer
direction, so it might be reasonably tested on architectures ... but
we'd probably have to check.

James


