Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUEVJs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUEVJs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUEVJsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:48:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51674 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265230AbUEVJsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:48:18 -0400
Date: Sat, 22 May 2004 11:44:47 +0200
From: Jens Axboe <axboe@suse.de>
To: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040522094443.GY1952@suse.de>
References: <20040522013636.61efef73.akpm@osdl.org> <20040522093830.GA3532@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522093830.GA3532@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22 2004, hch@infradead.org wrote:
> > +disk-barrier-core.patch
> > +disk-barrier-core-tweaks.patch
> > +disk-barrier-ide.patch
> > +disk-barrier-ide-symbol-expoprt.patch
> > +disk-barrier-ide-warning-fix.patch
> > +disk-barrier-scsi.patch
> > 
> >  Support for IDE and SCSI barriers
> > 
> > +disk-barrier-dm.patch
> > +disk-barrier-md.patch
> > 
> >  Via device mapper and raid as well.
> 
> Some comments on the API and the SCSI part:
> 
>  - issue_flush_fn prototype choice is bad, the request_queue_t argument
>    wile always be disk->queue so it's not needed and only causes
>    confusion.

Agree, it's mutated into place which is probably the reason for the
dupe.

>  - issue_flush sounds a little strange to me, what about cache_flush
>    or sync_cache instead?

Fine with me, I'm notoriously bad at naming.

>  - scsi_drive.issue_flush should take a scsi_device * as first parameter,
>    not struct device * - makes life for bother caller and callee easier.
>  - should probably add a small helper to get the scsi_driver from the
>    gendisk instead of duplicating the code, ala:
> 
> static inline struct scsi_driver *scsi_disk_driver(struct gendisk *disk)
> {
> 	return *(struct scsi_driver **) disk->private_data;
> }

Fine too.

>  - the WCE check should move into sd_sync_cache

Ditto

>  - NULL scsi_disk can't happen for sd_issue_flush, no need to check,
>    and thus the disctinction of sd_issue_flush vs sd_sync_cache can
>    go and sd_shutdown can simply call the cache flush method.

Neat, thanks.

Thanks for the review Christoph!

-- 
Jens Axboe

