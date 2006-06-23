Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751903AbWFWVAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWFWVAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbWFWVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:00:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751903AbWFWVAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:00:53 -0400
Date: Fri, 23 Jun 2006 14:00:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-Id: <20060623140040.01aeccf9.akpm@osdl.org>
In-Reply-To: <20060623153323.GA4848@infradead.org>
References: <20060621193657.GA4521@agk.surrey.redhat.com>
	<20060621210504.b1f387bd.akpm@osdl.org>
	<20060622135117.GS19222@agk.surrey.redhat.com>
	<20060622100353.50a7654e.akpm@osdl.org>
	<20060623150011.GW19222@agk.surrey.redhat.com>
	<20060623153323.GA4848@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 16:33:23 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jun 23, 2006 at 04:00:11PM +0100, Alasdair G Kergon wrote:
> > On Thu, Jun 22, 2006 at 10:03:53AM -0700, Andrew Morton wrote:
> > > Adding twenty new unused exports is rather a big deal.  Do you have some
> > > new code pending which will use all these?
> > 
> > No - there's code on the horizon which wants to use a few and so I did this
> > clean-up exercise to indicate which ones should be used and which ones
> > shouldn't.  It's no problem delaying the actual exports until they're
> > specifically requested, but I would at least like to move the definitions
> > into include/linux so people know they are welcome to use them if they wish.
> 
> Please dont introduce exports eaarly.  I'm also very curious about what kind
> of user you have in the pipeline, calling these functions from kernelspace
> seems very wrong to me.

So Alasdair, we need to work out what we're going to do about all this.  I
think the current status is:

- hold off on dm-add-exports.patch

- Rework needed on

	dm-support-ioctls-on-mapped-devices.patch
	dm-linear-support-ioctls.patch
	dm-mpath-support-ioctls.patch
	dm-export-blkdev_driver_ioctl.patch

- We're OK with

	dm-mirror-log-sector-size-fix.patch
	dm-mirror-log-refactor-context.patch
	dm-mirror-log-bitset_size-fix.patch
	dm-mirror-log-sync_count-fix.patch
	dm-kcopyd-error-accumulation-fix.patch
	dm-table-split_args-handle-no-input.patch
	dm-consolidate-creation-functions.patch
	dm-create-error-table.patch
	dm-prevent-removal-if-open.patch
	dm-improve-error-message-consistency.patch

Which means going from this:

	dm-support-ioctls-on-mapped-devices.patch
	dm-linear-support-ioctls.patch
	dm-mpath-support-ioctls.patch
	dm-export-blkdev_driver_ioctl.patch
	dm-mirror-log-sector-size-fix.patch
	dm-mirror-log-refactor-context.patch
	dm-mirror-log-bitset_size-fix.patch
	dm-mirror-log-sync_count-fix.patch
	dm-kcopyd-error-accumulation-fix.patch
	dm-table-split_args-handle-no-input.patch
	dm-consolidate-creation-functions.patch
	dm-add-exports.patch
	dm-create-error-table.patch
	dm-prevent-removal-if-open.patch
	dm-improve-error-message-consistency.patch

to this:

	# for 2.6.18:
	dm-mirror-log-sector-size-fix.patch
	dm-mirror-log-refactor-context.patch
	dm-mirror-log-bitset_size-fix.patch
	dm-mirror-log-sync_count-fix.patch
	dm-kcopyd-error-accumulation-fix.patch
	dm-table-split_args-handle-no-input.patch
	dm-consolidate-creation-functions.patch
	dm-create-error-table.patch
	dm-prevent-removal-if-open.patch
	dm-improve-error-message-consistency.patch
	# rework in progress:
	dm-support-ioctls-on-mapped-devices.patch
	dm-linear-support-ioctls.patch
	dm-mpath-support-ioctls.patch
	dm-export-blkdev_driver_ioctl.patch
	# later:
	dm-add-exports.patch

but I'm uncertain if I can just reshuffle them like this, because at least
two of them update the userspace-visible DM version number.
