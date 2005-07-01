Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263404AbVGARFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbVGARFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbVGARFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:05:41 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:7442 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263404AbVGARFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:05:30 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050701152003.GA7073@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 17:20:03 +0200)
Subject: Re: FUSE merging?
References: <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus>
Message-Id: <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 19:04:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's not as simple.  A filesystem can be mounted many times (either
> > with mount --bind, or just by mounting the same device on multiple
> > mountpoints).  In this case you can't ensure, that a mountpoint will
> > remain a leaf node after being mounted on.
> 
> I have bind-mounted / on /net/blabla
> I tried two experiments:
> 
> 	mounting something under / and looking for it under /net/blabla
> 	mounting something under /net/blabla and looking for it under /
> 
> The experiment was done with bind mounts and by mounting a USB stick
> (/dev/sdb1) and there was no auto propagation of mounts.

I'm not talking about auto propagation (that's only now being
implemented by Ram Pai, and is not in stock kernels).

What I'm saying is that mounting something over a leaf node, does not
guarantee, that it will remain a leaf node after it's been mounted on.

For example:

mkdir /tmp/leafdir
mkdir /tmp/rootcopy
mount --bind / /tmp/rootcopy
mount /dev/sdb1 /tmp/leafdir
mkdir /tmp/rootcopy/tmp/leafdir/child

Now 'leafdir' is no longer a leaf.

I'm not saying this is a problem, but also I don't see any
overwhelming reason to not allow user mounts over non-leaf
directories.

Miklos
