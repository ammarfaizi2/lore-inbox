Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWIOMeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWIOMeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWIOMeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:34:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:680 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751348AbWIOMeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:34:08 -0400
Subject: Re: Efficient Use of the Page Cache with 64 KB Pages
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1158311488.23551.4.camel@twins>
References: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
	 <1158311488.23551.4.camel@twins>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 07:34:05 -0500
Message-Id: <1158323645.12076.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 11:11 +0200, Peter Zijlstra wrote:
> On Fri, 2006-09-15 at 01:50 -0700, Sandeep Kumar wrote:
> > Hey all,
> > I am a newbie and I just read a document with the idea for changes in
> > page cache management for 64 Bit machines. This has been taken from
> > Linux symposium 2006, ottawa.
> > 
> > In order for 64-bit processors to efficiently use large address spaces
> > while maintaining lower TLB miss rates, the Linux kernel can be
> > configured with base page sizes up to 64 KB. While this benefits
> > access to large memory segments and files, it greatly reduces the
> > number of smaller files that can be resident in memory at one time.
> > The idea proposes a change to the Linux kernel to allow file data to
> > be more efficiently stored in memory when the size of the file, or the
> > data at the end of a file, is significantly smaller than the page
> > size.
> > 
> > So, how far is this feature feasible for the linux main line kernel ?
> 
> Not in the form last presented, but Dave is still working on making it
> look pretty and covering more use-cases AFAIK.

Right, I've been sidetracked with some other things, but I'm hoping to
get back on it soon.

> But even then, it will not fix all scenarios...

Right, you'll probably never be able to mmap to a "tail page".   I'm
actually trying a couple different approaches to compare the trade-off
between performance and intrusiveness.  On the less intrusive end, data
would be copied into a smaller buffer after it is read into a full page.
The more ambitious approach would have the smaller buffers aligned to
the sector size (and sized to the block size), and data is read, and
sometimes written, directly into them.

> > Is, this feature already supported ?
> 
> No it is not. 
> 
> In future it would be nice to add the author(s) to the CC list ;-)

Peter, thanks for cc'ing me.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

