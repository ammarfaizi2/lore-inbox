Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVARKd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVARKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVARKd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:33:59 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:15308 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261231AbVARKd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:33:57 -0500
Date: Tue, 18 Jan 2005 12:34:18 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] Some fixes for compat ioctl
Message-ID: <20050118103418.GA23099@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andi!

Quoting r. Andi Kleen (ak@muc.de) "[PATCH] Some fixes for compat ioctl":
> 
> While doing some compat_ioctl conversions I noticed a few issues
> in compat_sys_ioctl:
> 
> - It is not completely compatible to old ->ioctl because 
> the traditional common ioctls are not checked before it.

How is this different from what we have for compat_sys_ioctl
in 2.6.10? Or is this an old bug?

> I added
> a check for those.

Cant we just add them to fs/compat_ioctl.c instead, and be done?

> The main advantage is that the handler 
> now works the same as a traditional handler even when it returns
> -EINVAL


We still need the conversion functions in fs/compat_ioctl.c, I
think. If that is true, for some devices the handler only almost works
if it returns -EINVAL, and maybe its best not to encourage this.
I have another idea: maybe, lets move the unlocked_ioctl handler up so
that it, too, is required to return -NOIOCTLCMD?
I would argue it also may improve ioctl performance by a small margin,
since it is the unlocked_ioctl/compat_ioctl that do the "real" work.

I plan to send, separately, a patch that does this.
Please comment.

> 
> - The private socket ioctl check should only apply for sockets.

Its an old issue, isnt it? And probably better split in a separate
patch?

> - There was a security hook missing.  Drawback is that it uses
> the same hook now, and the LSM module cannot distingush between
> 32bit and 64bit clients. But it'll have to live with that for now.

It seems it is still missing for compat_ioctl. No?
I am sending a patch to fix this separately.

MST
