Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWDSX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWDSX0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDSX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:26:36 -0400
Received: from gold.veritas.com ([143.127.12.110]:34967 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751319AbWDSX0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:26:35 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="58712203:sNHT31084080"
Date: Thu, 20 Apr 2006 00:26:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Matt Mackall <mpm@selenic.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <20060419225759.GV15445@waste.org>
Message-ID: <Pine.LNX.4.64.0604200012500.30523@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
 <20060419214959.GR15445@waste.org> <Pine.LNX.4.64.0604192332050.28312@blonde.wat.veritas.com>
 <20060419225759.GV15445@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Apr 2006 23:26:35.0628 (UTC) FILETIME=[B33D1AC0:01C66408]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Matt Mackall wrote:
> On Wed, Apr 19, 2006 at 11:50:55PM +0100, Hugh Dickins wrote:
> > 
> > Yes, the only reservation I have about your patch, entirely unrelated to
> > this resume issue, is that those systems which "hwclock -w" on shutdown
> > (do they on suspend too? haven't looked) will slowly tend to lose time.
> 
> If they weren't already using NTP, they were losing time anyway.

But considerably more slowly, I thought; but I could well be wrong,
it's not something I've thought a great deal about.

> > I tend to assume that it's not anything subtle, just that something
> > there needs a delay which it accidentally happened to get (most of
> > the time) from the CMOS reading, and with that gone now falls over.
> 
> I'm puzzled by 1 second not being enough. The former code should have
> taken between 1+e and 2 seconds, so I'd think mdelay(1000) would work.

You're assuming that resume worked on this before: not all the time.

This laptop is new to me, with several different issues in the
suspend to RAM area (e.g. the MSI business just fixed in -rc2).
I've not had it resuming reliably until just now: so I think that
with 2.6.16 (where I started out) it would (modulo other issues)
resume successfully when the former code worked out at 2 seconds,
but not when it worked out at 1 second.

One of the few things I'm sure of is that mdelay(1000) proved to be
not enough; maybe even mdelay(2000) is not enough, and I just haven't
yet hit a case which would show that.

Hugh
