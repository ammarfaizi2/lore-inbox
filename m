Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIIOeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIIOeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUIIOeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:34:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33749 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264917AbUIIOdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:33:53 -0400
Date: Thu, 9 Sep 2004 16:32:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch][9/9] block: remove bio walking
Message-ID: <20040909143244.GY1737@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <20040909090314.A24950@flint.arm.linux.org.uk> <200409091553.13918.bzolnier@elka.pw.edu.pl> <20040909150444.C6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909150444.C6434@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Russell King wrote:
> On Thu, Sep 09, 2004 at 03:53:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 09 September 2004 10:03, Russell King wrote:
> > > On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > [patch] block: remove bio walking
> > > > 
> > > > IDE driver was the only user of bio walking code.
> > 
> > was in -bk10 :-(
> > 
> > > The MMC driver also uses this.  Please don't remove.
> > 
> > OK I'll just drop this patch but can't we also use scatterlists in MMC?
> > 
> > The point is that I now think bio walking was a mistake and accessing
> > bios directly from low-level drivers is a layering violation (thus
> > all the added complexity). Moreover with fixed IDE PIO and without
> > bio walking code it should be possible to shrink struct request by
> > removing all "current" entries.
> 
> I'm wondering whether it is legal to map onto SG lists and then do PIO.
> Provided we don't end up using the DMA API and then using PIO to the
> original pages, it should work.

Will be fine.

> I would rather Jens considered your point first before rewriting code.
> 
> However, using the SG lists does finally provide us with a nice way to
> ensure that we have the right information to finally fix IDE wrt the
> PIO cache issues (dirty cache lines being left in the page cache.)

You can do this directly from the bio. Probably mmc should just do a
make_request_fn hook instead and just fill in a scatter gather table
directly and submit.

-- 
Jens Axboe

