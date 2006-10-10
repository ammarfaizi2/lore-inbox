Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWJJL47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWJJL47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWJJL47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:56:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47510 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751132AbWJJL47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:56:59 -0400
Date: Tue, 10 Oct 2006 13:56:38 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix IO error reporting on fsync()
Message-ID: <20061010115637.GF23622@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz> <20061006230609.c04e78bc.akpm@osdl.org> <20061009114040.GI17620@atrey.karlin.mff.cuni.cz> <20061009112011.b8c84e54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009112011.b8c84e54.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 9 Oct 2006 13:40:41 +0200
> Jan Kara <jack@suse.cz> wrote:
> 
> > > What about putting an address_space* into the buffer_head?  Transfer the
> > > EIO state into the address_space within, say, __remove_assoc_queue()?
> >   Yes, that's of course possible. But it enlarges each buffer head by 4
> > bytes (or 8 on 64-bit arch).
> 
> I suspect we could get that back by removing buffer_head.b_bdev.  That's
> not a trivial thing to do, but should be feasible.
> 
> We can't just do bh->b_page->mapping->host->i_sb->s_bdev because of races
> with trunate, plus the general horror of it all.  But I expect that all
> callers of submit_bh() have the blockdev* easily available by other means,
> so adding a `struct block_device*' argument to submit_bh() would get us
> there.
  OK. For now I've written and tested the patch with the pointer in
buffer head. Later we can have a look at shrinking buffer_head again...

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
