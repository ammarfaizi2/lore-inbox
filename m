Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUFQQit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUFQQit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUFQQit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:38:49 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:46730 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266564AbUFQQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:38:46 -0400
Subject: Re: PATCH: Further aacraid work
From: James Bottomley <James.Bottomley@steeleye.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <yqujzn72uov6.fsf@chaapala-lnx2.cisco.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com>
	<1087484107.2090.42.camel@mulgrave> 
	<yqujzn72uov6.fsf@chaapala-lnx2.cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jun 2004 11:37:04 -0500
Message-Id: <1087490225.2210.48.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 11:32, Clay Haapala wrote:
> Today's scatterlists already handle entries with a size greater than
> MMU pagelength, even on x86, right?  We have seen it in iSCSI driver
> testing, though it is not the usual case.  crypto/digests.c:update()
> function was recently patched to handle the case and properly kmap()
> the additional memory represented by the sg entry.

Yes.  The bio layer does two operations on sg elements: clustering and
virtual merging.  Clustering tries to coalesce two adjacent I/O pages
that also happen to be adjacent in memory physical space.  virtual
merging uses an IOMMU to place non-physically-adjacent pages at adjacent
locations in bus physical space.

> So, on regular x86 this is a matter of convenience/timing, and the
> page assignments will tend toward, but not always be, random 1-page
> entries as the system is used.

That's what the jury is out on, I think.  The question is could we
improve the chances of clustering by altering the way the vm allocator
works.

James


