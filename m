Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVERPoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVERPoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVERPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:41:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46055 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262293AbVERPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:37:43 -0400
Date: Wed, 18 May 2005 16:37:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carsten Otte <cotte@freenet.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 1/5] bdev: execute in place (V2)
Message-ID: <20050518153739.GA25420@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424403.2202.16.camel@cotte.boeblingen.de.ibm.com> <20050518142739.GB23162@infradead.org> <428B6111.3000802@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B6111.3000802@freenet.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 05:36:49PM +0200, Carsten Otte wrote:
> Christoph Hellwig wrote:
> 
> >>+	int (*direct_access) (struct inode *, sector_t, unsigned long *);
> >>    
> >>
> >
> >this should have a block_device * first argument.
> >  
> >
> While I agree that (block_device *) would be a good thing to address
> the target block device, the inode *  is consistent with other
> operations in this vector: open, release, & ioctl use the same scheme.

That's going to change real soon.

> The reason for inode * here is that the caller has no easy way to get
> to the block_device *. How would the filesystem do that?

sb->s_bdev
