Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbULHNvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbULHNvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULHNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:51:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:37551 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261207AbULHNvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:51:40 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Date: Wed, 8 Dec 2004 07:51:44 -0600
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
References: <20041206120941.GB7250@stusta.de> <200412060822.18688.kevcorry@us.ibm.com> <20041206144218.GA10498@suse.de>
In-Reply-To: <20041206144218.GA10498@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412080751.44618.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 December 2004 8:42 am, Jens Axboe wrote:
> On Mon, Dec 06 2004, Kevin Corry wrote:
> > If I recall correctly (and it's been a while since I've looked at that
> > code), the bio_set was added because a few DM modules like to initiate
> > their own I/O requests (things like snapshots and DM's kcopyd daemon),
> > and we felt it was better to allow these modules to each create their
> > own mempools to allocate bios from, rather than allocate from the
> > single kernel-wide bio pool used by the filesystem layer.
>
> That is fully correct and also something that eg the bouncing code needs
> to be 100% deadlock free.
>
> > Strictly speaking (and as you mentioned), the slabs in the bio_set are
> > unnecessary, and they could use the global bio_slab. But there's
> > probably some argument to be made for having separate bio mempools for
> > these modules.
>
> The mempools are needed, the duplicated slabs are not. But that's just a
> small part of it, basically the whole allocation and index stuff is 100%
> duplicated from bio.c. Even bio_init().
>
> > Actually, I also seem to recall discussions with Joe Thornber from
> > quite awhile ago about trying to move this bio_set functionality into
> > fs/bio.c, to allow other device drivers to create their own private
> > bio pools. If you think something like this would be desireable, I can
> > try to look into the specifics again. If you think that having the
> > single kernel-wide bio pool is sufficient for all filesystems and
> > device-drivers (you certainly understand the trade-offs better than I
> > do), then I can look into removing the necessary code from dm-io.c
>
> An abstraction for this would be nice, as there are two users of it then
> (dm-io and highmem.c). So if your team would do that, I would sure help
> you review and integrate it.
>
> That's not what I'm arguing against, it's the (almost) wholesale
> duplication that's a bit silly.

I'll be happy to look into whether this duplication can be removed, and also 
whether the bio_set stuff could be moved out to bio.c or somewhere else 
common to the other device-drivers and filesystems. However, I've got a lot 
of stuff going on right now, so I won't really have time to get to this until 
after the start of the year (might be able to start looking into it over the 
holidays if I get everything else done in the next couple weeks). If/When I 
come up with some patches, I'll let you know.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
