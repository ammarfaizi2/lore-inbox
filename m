Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVKORYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVKORYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKORYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:24:45 -0500
Received: from verein.lst.de ([213.95.11.210]:26778 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751450AbVKORYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:24:44 -0500
Date: Tue, 15 Nov 2005 18:24:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
Message-ID: <20051115172438.GA10445@lst.de>
References: <20051104221652.GB9384@lst.de> <20051112093340.GA15702@lst.de> <1132066277.6014.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132066277.6014.35.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 03:51:17PM +0100, Martin Schwidefsky wrote:
> On Sat, 2005-11-12 at 10:33 +0100, Christoph Hellwig wrote:
> > On Fri, Nov 04, 2005 at 11:16:52PM +0100, Christoph Hellwig wrote:
> > > all dasd ioctls are directly useable from 32bit process, thus switch
> > > the dasd driver to unlocked_ioctl/compat_ioctl and get rid of the
> > > translations in the global table.
> > 
> > ping on all the four s390 compat_ioctl patches.  These are few of the
> > remaining arch compat_ioctl bits and I'd really really like to get rid
> > of them soonish.
> 
> Current status on the four patches:
> 1) dasd ioctl patch didn't compile (missing semicolon after
> lock_kernel())

oops.

> and doesn't work after fixing the compile problem. It's a
> problem with the bdev->bd_disk->private_data which is NULL at the time
> the partition detection code calls the BIODASDINFO and HDIO_GETGEO ioctl
> with ioctl_by_bdev. I don't see an easy way to fix this right now.

my patch doesn't change anything related to dereferencing those fields.

I see the problem that you're probably having: ioctl_by_bdev calls
->ioctl without ensuring ->open has been called previously.  But I don't
see why this couldn't have happened previously.

