Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUIMGey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUIMGey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUIMGey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:34:54 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:19179 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266155AbUIMGew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:34:52 -0400
Date: Mon, 13 Sep 2004 08:34:44 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, John Hesterberg <jh@sgi.com>
Subject: Re: [patch 2.6.8.1] BSD accounting: update chars transferred value
Message-ID: <20040913063444.GA17636@frec.bull.fr>
References: <20040908112909.GA10036@frec.bull.fr> <41423480.8090104@sgi.com>
Mime-Version: 1.0
In-Reply-To: <41423480.8090104@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/09/2004 08:40:23,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/09/2004 08:40:28,
	Serialize complete at 13/09/2004 08:40:28
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 04:10:56PM -0700, Jay Lan wrote:
> This patch is a subset of csa_io with your patch deals with character
> IO only.

Yes you are right. This patch only deals with character IO because I 
don't know yet how to get information for blocks IO. As I said my goal 
is to provide a good solution for accounting. BSD-accounting is already 
in the kernel and CSA provide more metrics so I think it could be good 
to add some CSA accounting values in the BSD-accounting. 

> I can see that merge csa_io's change at vfs_writev() and vfs_readv()
> into your change at do_readv_writev(). However, the code change is
> not really common code in that a) the operation type is different and
> 2) the fields to add to are different, so you end up doing extra check 
> of file operation type (READ vs WRITE). I would be happy if either
> your patch or mine is accepted, but i think it does extra work to put
> the changes into the common routine (ie do_readv_writev).

As you notice, vfs_writev() and vfs_readv() both call do_readv_writev()
and as fields to add are different I added a test on the operation type.
I though that it was interesting to put a changes in the common routine
but you are right that it has a cost (the file operation check). As the 
changes can be done in vfs_readv() and vfs_writev() instead of one single 
routine (do_readv_writev()) I though this choice was good but if the
extra cost is a problem I agree with your solution. Thank you to point
this out.

> Shall we combine your patch and SGI's csa_io patch?

IMHO, it could be very interesting to combine your patch and mine.
BSD-accounting is doing per-process accounting and CSA also doing
per-process accounting even if the goal is a per-job accounting. Thus, I
think that it can be good to combine both. It isn't necessary to have
two different accounting systems in the kernel. 

Is it difficult for you to add what you are doing with CSA in the
BSD-accounting file? Maybe the solution is to remove BSD-accounting in
favor of CSA accounting? Personally, I don't care if we keep
BSD-accounting or if we remove it to add CSA accounting.

Best,
Guillaume
