Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUIFBh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUIFBh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUIFBh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:37:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30876 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267382AbUIFBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:37:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Mon, 6 Sep 2004 11:36:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16699.48946.29579.495180@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: bug in md write barrier support?
In-Reply-To: message from Jens Axboe on Saturday September 4
References: <20040903172414.GA6771@lst.de>
	<16697.4817.621088.474648@cse.unsw.edu.au>
	<20040904082121.GB2343@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday September 4, axboe@suse.de wrote:
> On Sat, Sep 04 2004, Neil Brown wrote:
> > On Friday September 3, hch@lst.de wrote:
> > > md_flush_mddev just passes on the sector relative to the raid device,
> > > shouldn't it be translated somewhere?
> > 
> > Yes.  md_flush_mddev should simply be removed.  
> > The functionality should be, and largely is, in the individual
> > personalities. 
> 
> Yes, sorry I was a little lazy there even though I followed the plugging
> conversion :(
> 
> > Is there documentation somewhere on exactly what an issue_flush_fn
> > should do (is it  allowed to sleep? what must happen before it is
> > allowed to return, what is the "error_sector" for,  that sort of thing).
> 
> It is allowed to sleep, you should return when the flush is complete.
> error_sector is the failed location, which really should be a dev,sector
> tupple.

Could I get a little more information about this function please.
I've read through the code, and there isn't much in the way of
examples to follow: only reiserfs uses it, only scsi-disk and ide-disk
supports it (I think).

It would seem that this is for write requests where b_end_io has already
been called, indicating that the data is safe, but that maybe the data
isn't really safe after-all, and blk_issue_flush needs to be called.

I would have thought that after b_end_io is called, that data should
be safe anyway.  Not so?

How do you tell a device: it is OK to just leave the data is cache,
I'll call blk_issue_flush when I want it safe.
Is this related to barriers are all??

NeilBrown
