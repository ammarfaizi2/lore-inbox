Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUJEPvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUJEPvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270063AbUJEPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:51:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6879 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269917AbUJEPtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:49:25 -0400
Date: Tue, 5 Oct 2004 17:46:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041005154628.GG19971@suse.de>
References: <20041005142001.GR2433@suse.de> <20041005163730.A19554@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005163730.A19554@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2004, Christoph Hellwig wrote:
> On Tue, Oct 05, 2004 at 04:20:01PM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > The blacklist stuff is broken. When set_using_dma() calls into
> > ide_dma_check(), it returns ide_dma_off() for a blacklisted drive. This
> > of course succeeds, returning success to the caller of ide_dma_check().
> > Not so good... It then uncondtionally calls ide_dma_on(), which turns on
> > dma for the drive.
> > 
> > This moves the check to ide_dma_on() so we also catch the buggy
> > ->ide_dma_check() defined by various chipset drivers.
> 
> Is this a bug introduced in the 2.6.9ish IDE changes or has it been there
> for a longer time? 

I didn't check, someone just reported today. But looking at eg 2.6.5, it
seems to have the same bug. So it's likely very old.

-- 
Jens Axboe

