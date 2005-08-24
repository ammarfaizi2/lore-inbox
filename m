Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVHXHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVHXHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVHXHi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:38:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46538 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750716AbVHXHi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:38:57 -0400
Date: Wed, 24 Aug 2005 08:38:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] external interrupts: abstraction layer
Message-ID: <20050824073856.GD24513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050819161054.I87000@chenjesu.americas.sgi.com> <20050820094632.GC21698@infradead.org> <20050823153254.B5569@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823153254.B5569@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static int extint_counter_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct extint_device *ed = file_to_extint_device(filp);
> > 
> > you don't need the file but just the inode (strictly speaking the cdev),
> > and doing this based on the file is rather confusing to the reader because
> > the struct file passed to ->open has just been allocated.
> 
> Perhaps I'm not following something here.
> 
> This behavior enables using poll/select to detect or wait for the
> external interrupt counter (which is per-device) to change.  The
> "has changed" status must be on a per-open basis, not a per-device
> basis, as seperate processes may read the counter at different times.

Sorry, the whole behaviour is complety fine.  I just don't thing the name
and calling convention of file_to_extint_device is optimal.  It should
take an struct inode * and be called just to_extint_device or someting.
The above would become

	struct extint_device *ed = to_extint_device(filp->f_dentry->d_inode);

