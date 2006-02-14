Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWBNVwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWBNVwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWBNVwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:52:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:33464 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422821AbWBNVwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:52:24 -0500
Subject: Re: [RFC][PATCH] map multiple blocks at a time in mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: akpm@osdl.org, mcao@us.ibm.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060214192714.GA20956@lst.de>
References: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
	 <20060214192714.GA20956@lst.de>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 13:53:30 -0800
Message-Id: <1139954010.4762.28.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 20:27 +0100, christoph wrote:
> On Tue, Feb 14, 2006 at 09:49:07AM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > I re-did the support for mpage_readpages() to map multiple blocks
> > at a time (basically, get_blocks()). Instead of adding new
> > get_blocks() and pass it around, I use "bh->b_size" to indicate
> > how much of disk mapping we are interested in to get_block().
> > 
> > This way no changes existing interfaces and no new routines need.
> > Filesystem can choose to ignore the passed in "bh->b_size" value
> > and map one block at a time (ext2, reiser3, etc..)
> 
> Hmm.  Given that we only use buffer_heads for page-cache backed I/O
> bh->b_size should always be set properly and this would be fine.
> 
> If we could completely get rid of ->get_blocks that be a nice cleanup
> in all the fs drivers. 

Yes. Sir !! 
As mentioned in my note, I am already doing that :)
Only problem is, it changes the existing exported interface :(

>  OTOH I still wonder whether ->get_block should
> use a small structure that just contains the information needed with
> easy to decipher names..

While ago, I did look at that. There is nothing much to trim in
the bufferhead. Most of this useful for FS, IO or JBD :(

Thanks,
Badari

