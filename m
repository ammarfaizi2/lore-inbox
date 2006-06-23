Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932982AbWFWKAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWFWKAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWFWKAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:00:33 -0400
Received: from verein.lst.de ([213.95.11.210]:62387 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932984AbWFWKAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:00:32 -0400
Date: Fri, 23 Jun 2006 12:00:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, mbroz@redhat.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-ID: <20060623100018.GA6985@lst.de>
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060621205206.35ecdbf8.akpm@osdl.org> <449A51A2.4080601@redhat.com> <20060622012957.97697208.akpm@osdl.org> <20060622151721.GT19222@agk.surrey.redhat.com> <20060622095551.b5c6ddce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622095551.b5c6ddce.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:55:51AM -0700, Andrew Morton wrote:
> > - long (*unlocked_ioctl) (struct file *, unsigned, unsigned long);
> > + long (*unlocked_ioctl) (struct inode *, struct file *, unsigned, unsigned long);
> > 
> > so it can be used for block devices?
> 
> Perhaps it should (have).  It's a bit nasty, but we do have at least two
> internal callers who don't have a file*.
> 
> The alternative would be to cook up a fake file* like blkdev_get() does,
> but we don't want to propagate that practice.

Faking up the file struct is the only viable short-term option.  It
should be done in ioctl_by_bdev which every kernel blockdevice ioctl
user should use.  Long-term we should not pass a struct file but
a struct block_device *, but braindamage in floppy.c prevents that.

