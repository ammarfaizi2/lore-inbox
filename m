Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269085AbUINABj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbUINABj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUINABi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:01:38 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:64666 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269058AbUINAA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:00:28 -0400
Message-ID: <414634B5.6040604@engr.sgi.com>
Date: Mon, 13 Sep 2004 17:00:53 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [patch 2.6.8.1] BSD accounting: update chars transferred value
References: <20040908112909.GA10036@frec.bull.fr> <41423480.8090104@sgi.com> <20040913063444.GA17636@frec.bull.fr>
In-Reply-To: <20040913063444.GA17636@frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> On Fri, Sep 10, 2004 at 04:10:56PM -0700, Jay Lan wrote:
> 
>>This patch is a subset of csa_io with your patch deals with character
>>IO only.
> 
> 
> Yes you are right. This patch only deals with character IO because I 
> don't know yet how to get information for blocks IO. As I said my goal 
> is to provide a good solution for accounting. BSD-accounting is already 
> in the kernel and CSA provide more metrics so I think it could be good 
> to add some CSA accounting values in the BSD-accounting. 

Agreed!

> 
> 
>>I can see that merge csa_io's change at vfs_writev() and vfs_readv()
>>into your change at do_readv_writev(). However, the code change is
>>not really common code in that a) the operation type is different and
>>2) the fields to add to are different, so you end up doing extra check 
>>of file operation type (READ vs WRITE). I would be happy if either
>>your patch or mine is accepted, but i think it does extra work to put
>>the changes into the common routine (ie do_readv_writev).
> 
> 
> As you notice, vfs_writev() and vfs_readv() both call do_readv_writev()
> and as fields to add are different I added a test on the operation type.
> I though that it was interesting to put a changes in the common routine
> but you are right that it has a cost (the file operation check). As the 
> changes can be done in vfs_readv() and vfs_writev() instead of one single 
> routine (do_readv_writev()) I though this choice was good but if the
> extra cost is a problem I agree with your solution. Thank you to point
> this out
> 
> 
>>Shall we combine your patch and SGI's csa_io patch?
> 
> 
> IMHO, it could be very interesting to combine your patch and mine.
> BSD-accounting is doing per-process accounting and CSA also doing
> per-process accounting even if the goal is a per-job accounting. Thus, I
> think that it can be good to combine both. It isn't necessary to have
> two different accounting systems in the kernel. 
> 
> Is it difficult for you to add what you are doing with CSA in the
> BSD-accounting file? Maybe the solution is to remove BSD-accounting in
> favor of CSA accounting? Personally, I don't care if we keep
> BSD-accounting or if we remove it to add CSA accounting.

Your patch and SGI's csa_io are about accounting data gathering, so
merging these two patches still agrees with the favored approach: one
common data collection while we allow different data presentation
layer.

We have removed block IO from csa_io patch. The difference between
these two patches are data colleciton regarding to READ/WRITE system
calls, and block IO wait time (per process) that SGI and Cray customers
demanded.

Thanks,
  - jay

> 
> Best,
> Guillaume

