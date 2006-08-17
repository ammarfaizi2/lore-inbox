Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWHQNW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWHQNW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWHQNW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:22:27 -0400
Received: from pat.uio.no ([129.240.10.4]:40136 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932482AbWHQNW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:22:26 -0400
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
	writeback.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <17635.59821.21444.287979@cse.unsw.edu.au>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	 <20060815010611.7dc08fb1.akpm@osdl.org>
	 <17635.59821.21444.287979@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 09:21:51 -0400
Message-Id: <1155820912.5662.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.949, required 12,
	autolearn=disabled, AWL 0.54, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 13:59 +1000, Neil Brown wrote:
> On Tuesday August 15, akpm@osdl.org wrote:
> > > When Dirty hits 0 (and Writeback is theoretically 80% of RAM)
> > > balance_dirty_pages will no longer be able to flush the full
> > > 'write_chunk' (1.5 times number of recent dirtied pages) and so will
> > > spin in a loop calling blk_congestion_wait(WRITE, HZ/10), so it isn't
> > > a busy loop, but it won't progress.
> > 
> > This assumes that the queues are unbounded.  They're not - they're limited
> > to 128 requests, which is 60MB or so.
> 
> Ahhh... so the limit on the requests-per-queue is an important part of
> write-throttling behaviour.  I didn't know that, thanks.
> 
> fs/nfs doesn't seem to impose a limit.  It will just allocate as many
> as you ask for until you start running out of memory.  I've seen 60%
> of memory (10 out of 16Gig) in writeback for NFS.
> 
> Maybe I should look there to address my current issue, though imposing
> a system-wide writeback limit seems safer.

Exactly how would a request limit help? All that boils down to is having
the VM monitor global_page_state(NR_FILE_DIRTY) versus monitoring
global_page_state(NR_FILE_DIRTY)+global_page_state(NR_WRITEBACK).

Cheers,
  Trond

