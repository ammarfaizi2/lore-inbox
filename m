Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVHOVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVHOVts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVHOVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:49:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40093 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964991AbVHOVtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:49:47 -0400
Date: Mon, 15 Aug 2005 22:49:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: mikem <mikem@beardog.cca.cpqcorp.net>, marcelo.tosatti@cyclades.com,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 3/4] cciss 2.4: adds 2 ioctls for ia64 based systems
Message-ID: <20050815214903.GA12701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	mikem <mikem@beardog.cca.cpqcorp.net>, marcelo.tosatti@cyclades.com,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20050815212224.GD12760@beardog.cca.cpqcorp.net> <1124141573.5089.55.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124141573.5089.55.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:32:53PM -0500, James Bottomley wrote:
> On Mon, 2005-08-15 at 16:22 -0500, mikem wrote:
> > +#ifdef CONFIG_IA64
> > +        case BLKGETLASTSECT:
> > +        case BLKSETLASTSECT:
> > +#endif
> >  		return blk_ioctl(inode->i_rdev, cmd, arg);
> 
> What makes these two ioctls IA64 specific?  I think they're completely
> general in 2.4, so there's no need for the #ifdef.

They don't exist in 2.4 mainline.  The ia64 patch and then many
distributions introduced it because the EFI partitions spec contains
some braindamage that requries accessing the last sector.  In 2.6 the
block device nodes can do that, so the ioctls aren't needed either.

In short this patch should not go into mainline 2.4, it doesn't support
ia64 anyway and if it did it wouldn't compile because the ioctls aren't
defined.

