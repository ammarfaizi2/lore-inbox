Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUIIOHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUIIOHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUIIOFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:05:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9734 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264386AbUIIOEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:04:48 -0400
Date: Thu, 9 Sep 2004 15:04:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch][9/9] block: remove bio walking
Message-ID: <20040909150444.C6434@flint.arm.linux.org.uk>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <20040909090314.A24950@flint.arm.linux.org.uk> <200409091553.13918.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409091553.13918.bzolnier@elka.pw.edu.pl>; from bzolnier@elka.pw.edu.pl on Thu, Sep 09, 2004 at 03:53:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 03:53:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 09 September 2004 10:03, Russell King wrote:
> > On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > [patch] block: remove bio walking
> > > 
> > > IDE driver was the only user of bio walking code.
> 
> was in -bk10 :-(
> 
> > The MMC driver also uses this.  Please don't remove.
> 
> OK I'll just drop this patch but can't we also use scatterlists in MMC?
> 
> The point is that I now think bio walking was a mistake and accessing
> bios directly from low-level drivers is a layering violation (thus
> all the added complexity). Moreover with fixed IDE PIO and without
> bio walking code it should be possible to shrink struct request by
> removing all "current" entries.

I'm wondering whether it is legal to map onto SG lists and then do PIO.
Provided we don't end up using the DMA API and then using PIO to the
original pages, it should work.

I would rather Jens considered your point first before rewriting code.

However, using the SG lists does finally provide us with a nice way to
ensure that we have the right information to finally fix IDE wrt the
PIO cache issues (dirty cache lines being left in the page cache.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
