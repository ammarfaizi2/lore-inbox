Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUIAV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUIAV1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUIAVYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:24:42 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:23390 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S267864AbUIAVUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:20:09 -0400
Date: Thu, 2 Sep 2004 00:23:15 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901212314.GA26044@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1094053222.431.7165.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094053222.431.7165.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Albert Cahalan (albert@users.sourceforge.net) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
> Michael S. Tsirkin writes:
> > Quoting Lee Revell [snip -- that was excessive]
> 
> >> By adding a new ioctl you are adding a new use of
> >> the BKL. It has been suggested on dri-devel that
> >> this should be fixed.  Is this even possible?
> >
> > I dont know - can the lock be released before the
> > call to filp->f_op->ioctl ?
> >
> > I assume the reason its there is for legacy
> > code - existing ioctls may be assuming the BKL
> > is taken, but maybe there could be another flag
> > in f_ops to let sys_ioctl release the lock before
> > doing the call ...
> >
> > Like this - would that be safe?
> 
> Yes. It is proven to work.

Now that I look at the ioctl.c code, I see a several get_user/put_user
inside the ioctl which are thus done while BKL is held.
But I thought get_user can block?

Why is this not a bug?

MST
