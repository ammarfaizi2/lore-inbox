Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVDTHKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDTHKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDTHKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:10:10 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:3977 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261399AbVDTHKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:10:04 -0400
To: mike@waychison.com
CC: ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <4265D39D.2010301@waychison.com> (message from Mike Waychison on
	Tue, 19 Apr 2005 23:59:25 -0400)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>	 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>	 <3UmnD-6Fy-7@gated-at.bofh.it>	 <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>	 <a4e6962a050419045752cc8be0@mail.gmail.com>	 <Pine.LNX.4.58.0504191647320.3652@be1.lrz>	 <a4e6962a05041908262df343f1@mail.gmail.com>	 <Pine.LNX.4.58.0504191756200.3929@be1.lrz> <a4e6962a05041912293ba87710@mail.gmail.com> <4265D39D.2010301@waychison.com>
Message-Id: <E1DO9L8-0000mQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Apr 2005 09:09:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Likely because its a chroot vulnerability.
> 
> It allows a process to obtain a reference to the root vfsmount that
> doesn't have chroot checks performed on it.
> 
> Consider the following pseudo example:
> 
[...]
>
> if main is run within a chroot where it's "/" is on the same vfsmount as
>  it's "..", then the application can step out of the chroot using clone(2).
> 
> Note: using chdir in a vfsmount outside of your namespace works, however
> you won't be able to walk off that vfsmount (to its parent or children).

How about fixing fchdir, so it checks whether you gone outside the
tree under current->fs->rootmnt?  Should be fairly easy to do.

Miklos
