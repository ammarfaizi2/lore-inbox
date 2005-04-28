Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVD1HDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVD1HDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVD1HDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:03:08 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:53671 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261856AbVD1HBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:01:41 -0400
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1114637883.4180.55.camel@localhost> (message from Ram on Wed, 27
	Apr 2005 14:38:03 -0700)
Subject: Re: [PATCH] private mounts
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
	 <1114623598.4480.181.camel@localhost>
	 <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu>
	 <1114624541.4480.187.camel@localhost>
	 <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu>
	 <1114630811.4180.20.camel@localhost>
	 <E1DQskk-0004dI-00@dorka.pomaz.szeredi.hu> <1114637883.4180.55.camel@localhost>
Message-Id: <E1DR312-0005IZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 09:00:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok. Generally overmounts are done on the root dentry of the topmost
> vfsmount.  But in this case, your patch mounts it on the same dentry
> as that of the private mount.
> 
> Essentially I was always under the assertion that 'a dentry can hold
> only one vfsmount'.  But invisible mount seem to invalidate that
> assertion.

You can do that without an invisible mount:

mkdir /tmp/mnt
mkdir /tmp/dir1
mkdir /tmp/dir1/subdir1
mkdir /tmp/dir2
mkdir /tmp/dir2/subdir2

cd /tmp/mnt
mount --bind /tmp/dir1 .
mount --bind /tmp/dir2 .

Now you have both /tmp/dir1 and /tmp/dir2 rooted at the same dentry.

To test this, in another shell do this just after the first bind mount:

cd /tmp/mnt

Then after the second mount do

ls -l subdir1/..

Now unmount everything and repeat the experiment, but do the mounts
this way:

mount --bind /tmp/dir1 /tmp/mnt
mount --bind /tmp/dir2 /tmp/mnt

Now the second mount is an overmount of the first, and you will
actually get different result from the "ls".

Playing with mounts is fun :)

Miklos
