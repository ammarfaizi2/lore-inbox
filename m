Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266497AbUFQOCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUFQOCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUFQOCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:02:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22716 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266497AbUFQOCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:02:52 -0400
Date: Thu, 17 Jun 2004 10:02:29 -0400
From: Alan Cox <alan@redhat.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Alan Cox <alan@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617140229.GB10138@devserv.devel.redhat.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD23FF9@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FD23FF9@otce2k03.adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:53:36AM -0400, Salyzyn, Mark wrote:
> available. Since the scsi layer has a propensity to provide sequentially
> decreasing pages (sequentially increasing would permit coalescing of SG
> elements) for the SG elements, we find that there is an average SG
> element size of 4K.

That ought to be a case of flipping the way the kernel hands out pages.
I've always wondered why we get them often in reverse order but never
sat down and worked it out

> more than 4G of memory; however we *are* having troubles specifically
> with AMD64 systems with more than 4G of memory in 2.6 kernels (the issue
> does not occur on 2.4 kernels). I have yet to investigate why this
> specific problem exists.

The AMD64 is a little unusual in that it has an IO MMU, so requests for
mappings that are physically high memory, not easy to merge, etc can
be made to appear in a convenient order lower down in memory. Thus
asking to map memory at virtual addresses above 4Gb probably hands back
a PCI address around 3.5Gb. That mapping will also vanish (gone forever
and the PCI address will show other data instead) when you unmap it.


