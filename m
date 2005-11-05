Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVKEAYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVKEAYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKEAYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:24:24 -0500
Received: from verein.lst.de ([213.95.11.210]:35240 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751366AbVKEAYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:24:23 -0500
Date: Sat, 5 Nov 2005 01:24:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [Patch] vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
Message-ID: <20051105002406.GA11235@lst.de>
References: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 03:27:29PM -0800, Zach Brown wrote:
> 
> vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
> 
> This adds IO_CMD_IO_CMD_P{READ,WRITE}V to let userspace specify buffers with
> iovecs.  aio_{read,write}v file operations are then used by the AIO core to
> hand the iovecs to filesystems, a significant number of whom already implement
> their IO methods in terms of iovecs.  It lets applications work with vectored
> file IO in single AIO operations instead of having to issue multiple AIO ops.
> This is of particular use with O_DIRECT when the iovecs are pushed all the way
> down to devices which are capable of scatter-gather DMA.

The aio.c portion looks nice.  I'm not happy about the filesystems bits.
The last thing we want is another set of read/write file operations.  So
as part of the patch (it'll probably grow into a series) we should
remove the aio non-vectored and maybe even the plain vectored
operations.  Doing that will be a lot simpler after I finished sorting
out various bits of duplication in the generic read/write path.  I've
sent the first patch for that to -fsdevel already, but there's a few
more to follow.

