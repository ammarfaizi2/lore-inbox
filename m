Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUIAVqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUIAVqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIAVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:44:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53122 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268095AbUIAVi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:38:29 -0400
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
From: Lee Revell <rlrevell@joe-job.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901212314.GA26044@mellanox.co.il>
References: <1094053222.431.7165.camel@cube>
	 <20040901212314.GA26044@mellanox.co.il>
Content-Type: text/plain
Message-Id: <1094074708.1343.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 17:38:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 17:23, Michael S. Tsirkin wrote:
> Hello!
> Quoting r. Albert Cahalan (albert@users.sourceforge.net) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
> > Michael S. Tsirkin writes:
> > > Quoting Lee Revell [snip -- that was excessive]
> > 
> > >> By adding a new ioctl you are adding a new use of
> > >> the BKL. It has been suggested on dri-devel that
> > >> this should be fixed.  Is this even possible?
> > >
> > > I dont know - can the lock be released before the
> > > call to filp->f_op->ioctl ?
> > >
> > > I assume the reason its there is for legacy
> > > code - existing ioctls may be assuming the BKL
> > > is taken, but maybe there could be another flag
> > > in f_ops to let sys_ioctl release the lock before
> > > doing the call ...
> > >
> > > Like this - would that be safe?
> > 
> > Yes. It is proven to work.
> 
> Now that I look at the ioctl.c code, I see a several get_user/put_user
> inside the ioctl which are thus done while BKL is held.
> But I thought get_user can block?
> 
> Why is this not a bug?
> 

You can sleep while holding the BKL, it is automatically dropped and
reacquired.  The BKL has some magic properties, it does not work like a
regular spinlock.

Lee

