Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUIAHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUIAHcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUIAHcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:32:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267850AbUIAHcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:32:24 -0400
Date: Wed, 1 Sep 2004 08:32:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
References: <20040901072245.GF13749@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901072245.GF13749@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> Hello!
> Currently, on the x86_64 architecture, its quite tricky to make
> a char device ioctl work for an x86 executables.
> In particular,
>    1. there is a requirement that ioctl number is unique -
>       which is hard to guarantee especially for out of kernel modules

Too bad.

>    2. there's a performance huge overhead for each compat call - there's
>       a hash lookup in a global hash inside a lock_kernel -
>       and I think compat performance *is* important.
> 
> Further, adding a command to the ioctl suddenly requires changing
> two places - registration code and ioctl itself.

So don't add them.  Adding a new ioctl is *NOT* a step to be taken lightly -
we used to be far too accepting in that area and as somebody who'd waded
through the resulting dungpiles over the last months I can tell you that
result is utterly revolting.

Excuse me, but I have zero sympathy to people who complain about obstacles
to dumping more into the same piles - it should be hard.
