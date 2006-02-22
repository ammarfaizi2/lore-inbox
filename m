Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWBVPMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWBVPMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWBVPMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:12:35 -0500
Received: from verein.lst.de ([213.95.11.210]:30634 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750754AbWBVPMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:12:34 -0500
Date: Wed, 22 Feb 2006 16:12:16 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060222151216.GA22946@lst.de>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:21:27PM -0800, Badari Pulavarty wrote:
> Hi,
> 
> Following patches add support to map multiple blocks in ->get_block().
> This is will allow us to handle mapping of multiple disk blocks for
> mpage_readpages() and mpage_writepages() etc. Instead of adding new
> argument, I use "b_size" to indicate the amount of disk mapping needed
> for get_block(). And also, on success get_block() actually indicates
> the amount of disk mapping it did.
> 
> Now that get_block() can handle multiple blocks, there is no need
> for ->get_blocks() which was added for DIO. 
> 
> [PATCH 1/3] pass b_size to ->get_block()
> 
> [PATCH 2/3] map multiple blocks for mpage_readpages()
> 
> [PATCH 3/3] remove ->get_blocks() support
> 
> I noticed decent improvements (reduced sys time) on JFS, XFS and ext3. 
> (on simple "dd" read tests).
> 	
>          (rc3.mm1)	(rc3.mm1 + patches)
> real    0m18.814s	0m18.482s
> user    0m0.000s	0m0.004s
> sys     0m3.240s	0m2.912s
> 
> Andrew, Could you include it in -mm tree ?

Thanks Badari, with that interface changes the mpage_readpage changes
look a lot nicer than my original version.  I'd like to second
the request to put it into -mm. 

And if the namesys folks could try out whether this works for their
reiser4 requirements it'd be nice.  If you have an even faster
->readpages I'd be interested in that secrete souce receipe for
further improvement to mpage_readpages.
