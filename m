Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFTSz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTFTSz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:55:58 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:36805
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264450AbTFTSz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:55:56 -0400
Date: Fri, 20 Jun 2003 15:09:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
Message-ID: <20030620190957.GA19988@gtf.org>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620185915.GD28711@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 08:59:15PM +0200, J?rn Engel wrote:
> Now, the cost of the underlying BWT is O(n) in memory and O(n*ln(n))
> in time.  That given, I consider it odd to use a linear semantic of
> blockSizeXXXX and would prefer an exponential one, as the zlib uses
> here and there.  Thus blockSizeBits would now give the blockSize as
> 1 << blockSizeBits, allowing to go well below 100k, resulting in lower
> memory consumption for some and well above 900k, giving better
> compression ratios.
> 
> 
> Long intro, short question: Jay O Nay?

The big question is whether the bzip2 better compression is actually
useful in a kernel context?  Patches to do bzip2 for initrd, for
example, have been around for ages:

	http://gtf.org/garzik/kernel/files/initrd-bzip2-2.2.13-2.patch.gz

But the compression and decompression overhead is _much_ larger
than gzip.  It was so huge for maximal compression that dialing back
compression reaching a point of diminishing returns rather quickly,
when compared to gzip memory usage and compression.

I talked a bit with the bzip2 author a while ago about memory usage.
He eventually added the capability to only require small blocks
for decompression (64K IIRC?), but there was a significant loss in
compression factor.

So... even in 2003, I really don't know of many (any?) tasks which
would benefit from bzip2, considering the additional memory and
cpu overhead.

	Jeff



