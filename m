Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUFQVOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUFQVOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUFQVOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:14:04 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:35288 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263778AbUFQVN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:13:57 -0400
Subject: Re: PATCH: Further aacraid work
From: James Bottomley <James.Bottomley@steeleye.com>
To: Alan Cox <alan@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Anton Blanchard <anton@samba.org>,
       mark_salyzyn@adaptec.com, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040617205414.GE8705@devserv.devel.redhat.com>
References: <286GI-5y3-11@gated-at.bofh.it> <286Qp-5EU-19@gated-at.bofh.it>
	<m3smcut2z0.fsf@averell.firstfloor.org> 
	<20040617205414.GE8705@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jun 2004 16:13:30 -0500
Message-Id: <1087506812.1795.87.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 15:54, Alan Cox wrote:
> I would rather see it below the I/O layer for things like AMD64. The
> reason I say this is that many drivers would suffer from iommu merging not
> gain, and others may have limits.
> 
> Something like
> 
> 	new_sglist = sg_squash(old_sglist, [target max segments], [max per seg])
> 
> could be used by drivers when appropriate to hand back a better sg list
> (or if not possible the existing one). That would put control rather closer
> to the driver. 

You can't quite do it like this.  The problem is that IOMMU merging is
an input to the bio routines.  If you tell it you can merge, it will
spit out a nice list which will merge down to your card segment limit.

If you don't merge though, the list will be way over the number of SG
segments you are allowed.

There was an infrastructure proposed a year ago to allow a "bypass mode"
per device which would do something like you want. 

This is also a separate problem from the IOMMU running out of
resources...

James


