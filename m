Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWA0Tn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWA0Tn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWA0TnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:43:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20241 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932488AbWA0TnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:43:25 -0500
Date: Fri, 27 Jan 2006 19:43:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127194318.GA1433@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA0E97.5030504@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 01:14:15PM +0100, Pierre Ossman wrote:
> Russell, would having a "highmem not supported" flag in the host
> structure be an acceptable solution? mmc_block could then use that to
> tell the block layer that bounce buffers are needed. As for other,
> future, users they would have to take care not to give those drivers
> highmem sg lists.

The mmc_block layer only tells the block layer what the driver told it.

> The current buggy code, was modeled after another MMC driver (mmci). So
> I suspect there might be more occurrences like this. Perhaps an audit
> should be added as a janitor project?

I don't see what the problem is.  A sg entry is a list of struct page
pointers, an offset, and a size.  As such, it can't describe a transfer
which crosses a page because such a structure does not imply that one
struct page follows another struct page.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
