Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUIAHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUIAHrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIAHrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:47:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63905 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268001AbUIAHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:47:12 -0400
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
From: Lee Revell <rlrevell@joe-job.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, discuss@x86-64.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
References: <20040901072245.GF13749@mellanox.co.il>
	 <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1094024831.1970.21.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 03:47:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 03:32, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> > Hello!
> > Currently, on the x86_64 architecture, its quite tricky to make
> > a char device ioctl work for an x86 executables.
> > In particular,
> >    1. there is a requirement that ioctl number is unique -
> >       which is hard to guarantee especially for out of kernel modules
> 
> Too bad.
> 
> >    2. there's a performance huge overhead for each compat call - there's
> >       a hash lookup in a global hash inside a lock_kernel -
> >       and I think compat performance *is* important.
> > 
> > Further, adding a command to the ioctl suddenly requires changing
> > two places - registration code and ioctl itself.
> 
> So don't add them.  Adding a new ioctl is *NOT* a step to be taken lightly -
> we used to be far too accepting in that area and as somebody who'd waded
> through the resulting dungpiles over the last months I can tell you that
> result is utterly revolting.
> 

By adding a new ioctl you are adding a new use of the BKL.  It has been
suggested on dri-devel that this should be fixed.  Is this even
possible?

Lee


