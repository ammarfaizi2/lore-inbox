Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUFJG2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUFJG2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJG2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:28:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19898 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266183AbUFJG14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:27:56 -0400
Date: Thu, 10 Jun 2004 08:27:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, edt@aei.ca, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040610062750.GF13836@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406092352.18470.bzolnier@elka.pw.edu.pl> <20040609150658.5e5e6653.akpm@osdl.org> <200406100138.18028.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100138.18028.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
> > > - if you more than > 1 filesystem on the disk (quite likely scenario) it
> > >   can happen that barrier (flush) will fail for sector for file from the
> > >   other fs and later barrier for this other fs will succeed
> >
> > I don't understand this one.
> 
> Flush command can fail for sector which came into disk's write cache
> from some write request for some other fs on the same disk i.e.
> 
> write requests for fs 'a' (sector 'x' stays in write cache)
> write requests for fs 'b'
> commit log for fs 'b' -> barrier for fs 'b'
> barrier fails because of sector 'x'
> commit log for fs 'a' -> barrier for fs 'a'
> barrier succeeds

That's a bug in ide_complete_barrier(), like I outlined in the previous
mail you need to reissue the flush until no errors occur. A pre-flush
should not fail the barrier of course, since it has no relation to it.

> Such scenario is highly unlikely (disks do bad sector re-allocation
> on write) but not impossible (pool of sectors for remapping is unlimited).
> That's why I think it is a minor issue (but still worth to know about it).

Yes very, wants to work though...

-- 
Jens Axboe

