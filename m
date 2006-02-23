Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWBWWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWBWWQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWBWWQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:16:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:59352 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751774AbWBWWQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:16:53 -0500
Subject: Re: [PATCH 2/3] map multiple blocks for mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: suparna@in.ibm.com
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060223032903.GA31252@in.ibm.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <1140470635.22756.15.camel@dyn9047017100.beaverton.ibm.com>
	 <20060223032903.GA31252@in.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 14:18:10 -0800
Message-Id: <1140733090.22756.157.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 08:59 +0530, Suparna Bhattacharya wrote:
> On Mon, Feb 20, 2006 at 01:23:55PM -0800, Badari Pulavarty wrote:
> > [PATCH 2/3] map multiple blocks for mpage_readpages()
> > 
> > This patch changes mpage_readpages() and get_block() to
> > get the disk mapping information for multiple blocks at the
> > same time.
> > 
> > b_size represents the amount of disk mapping that needs to
> > mapped. On the successful get_block() b_size indicates the
> > amount of disk mapping thats actually mapped.  Only the
> > filesystems who care to use this information and provide multiple
> > disk blocks at a time can choose to do so.
> > 
> > No changes are needed for the filesystems who wants to ignore this.
> 
> That's a nice way to handle this !
> 
> Just one minor suggestion on the patches - instead of adding all those
> arguments to do_mpage_readpage, have you considered using
> an mio structure as we did in the mpage_writepages multiple blocks case ?

I did think about moving stuff to "mio" and pass it around. Then, I
realized I need to think hard about mpage_writepages() also to come
out with a super-set "mio". For now, I settled with arguments for now,
when we cleanup mpage_writepages() we can take a pass at cleaning up
mpage_readpages() also.  (BTW, there are only 2 more arguments added).

Thanks,
Badari

