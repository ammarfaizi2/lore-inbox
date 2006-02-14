Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422702AbWBNT1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbWBNT1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWBNT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:27:24 -0500
Received: from verein.lst.de ([213.95.11.210]:51409 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422635AbWBNT1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:27:23 -0500
Date: Tue, 14 Feb 2006 20:27:14 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, akpm@osdl.org, mcao@us.ibm.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] map multiple blocks at a time in mpage_readpages()
Message-ID: <20060214192714.GA20956@lst.de>
References: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:49:07AM -0800, Badari Pulavarty wrote:
> Hi,
> 
> I re-did the support for mpage_readpages() to map multiple blocks
> at a time (basically, get_blocks()). Instead of adding new
> get_blocks() and pass it around, I use "bh->b_size" to indicate
> how much of disk mapping we are interested in to get_block().
> 
> This way no changes existing interfaces and no new routines need.
> Filesystem can choose to ignore the passed in "bh->b_size" value
> and map one block at a time (ext2, reiser3, etc..)

Hmm.  Given that we only use buffer_heads for page-cache backed I/O
bh->b_size should always be set properly and this would be fine.

If we could completely get rid of ->get_blocks that be a nice cleanup
in all the fs drivers.  OTOH I still wonder whether ->get_block should
use a small structure that just contains the information needed with
easy to decipher names..
