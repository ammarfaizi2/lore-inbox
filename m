Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSKLIvn>; Tue, 12 Nov 2002 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSKLIvn>; Tue, 12 Nov 2002 03:51:43 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:17198 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266379AbSKLIvm>; Tue, 12 Nov 2002 03:51:42 -0500
Date: Tue, 12 Nov 2002 08:58:08 +0000
To: linux-lvm@sistina.com
Cc: Bernd Eckenfels <ecki@lina.inka.de>, dm@uk.sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [patch] make device mapper compile on 2.5.4x
Message-ID: <20021112085808.GB1308@reti>
References: <20021111225340.GA3587@lina.inka.de> <Pine.GSO.4.21.0211111821210.29617-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211111821210.29617-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 06:23:00PM -0500, Alexander Viro wrote:
> 
> 
> On Mon, 11 Nov 2002, Bernd Eckenfels wrote:
> 
> > -	set_device_ro(dm_kdev(md), 0/*(param->flags & DM_READONLY_FLAG)*/);
> > +	bdev = bdget(kdev_t_to_nr(dm_kdev(md)));
> > +	if (!bdev)
> > +		return -ENXIO;
> > +	set_device_ro(bdev, (param->flags & DM_READONLY_FLAG));
> > +	bdput(bdev);
> 
> That is simply wrong.  set_device_ro() works only on opened block_device.
> Correct fix is to use set_disk_ro() and it's already in the tree (1.830
> on bkbits).

And I have sent the patch for this 3 times now.

- Joe
