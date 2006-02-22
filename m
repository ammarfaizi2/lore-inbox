Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWBVQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWBVQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWBVQ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:57:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:45462 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030304AbWBVQ5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:57:15 -0500
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
In-Reply-To: <20060222151216.GA22946@lst.de>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 08:58:30 -0800
Message-Id: <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 16:12 +0100, christoph wrote:
> On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > Following patches add support to map multiple blocks in ->get_block().
> > This is will allow us to handle mapping of multiple disk blocks for
> > mpage_readpages() and mpage_writepages() etc. Instead of adding new
> > argument, I use "b_size" to indicate the amount of disk mapping needed
> > for get_block(). And also, on success get_block() actually indicates
> > the amount of disk mapping it did.
> > 
> > Now that get_block() can handle multiple blocks, there is no need
> > for ->get_blocks() which was added for DIO. 
> > 
> > [PATCH 1/3] pass b_size to ->get_block()
> > 
> > [PATCH 2/3] map multiple blocks for mpage_readpages()
> > 
> > [PATCH 3/3] remove ->get_blocks() support
> > 
> > I noticed decent improvements (reduced sys time) on JFS, XFS and ext3. 
> > (on simple "dd" read tests).
> > 	
> >          (rc3.mm1)	(rc3.mm1 + patches)
> > real    0m18.814s	0m18.482s
> > user    0m0.000s	0m0.004s
> > sys     0m3.240s	0m2.912s
> > 
> > Andrew, Could you include it in -mm tree ?
> 
> Thanks Badari, with that interface changes the mpage_readpage changes
> look a lot nicer than my original version.  I'd like to second
> the request to put it into -mm. 

Thanks. Only current issue Nathan raised is, he wants to see
b_size change to u64 (instead of u32) to support really-huge-IO
requests. Does this sound reasonable to you ?

Thanks,
Badari

