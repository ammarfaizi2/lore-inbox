Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTFKLGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTFKLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:06:34 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:63885 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S264358AbTFKLG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:06:29 -0400
Date: Wed, 11 Jun 2003 20:12:18 +0900 (JST)
Message-Id: <20030611.201218.66717787.taka@valinux.co.jp>
To: ecki@calista.eckenfels.6bone.ka-ip.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: cachefs on linux
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <E19Q2S2-0001J0-00@calista.inka.de>
References: <200306101515.53464.rob@landley.net>
	<E19Q2S2-0001J0-00@calista.inka.de>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think the main benfit of cachefs is on NFS servers. Cachefs of
clients can help them to reduce their loads. We know many clients
may share one huge NFS server.
(e.g. Streaming systems which contents may be extremly huge.)

> >> Its particularly handy for fast read-only NFS stuff.  We have thousands
> >> of linux hosts and distributing software to all of them is a pain.  With
> >> cachefs with NFS as the "back" filesystem, you push to the masters and
> >> the clients get the changes over NFS and then store them in their local
> >> cache so your software distribution nightmare becomes no problem at all.
> 
> This is not a good idea, unless you have a transactional semantic for the
> fetches from the backend. Otherwise you have a mixture of old and new files.
> 
> >> Clients read off the local disk if they can, but fetch over NFS as
> >> required.  You can tune the cache size on all of the client machines so
> >> they can cache more or less of the most recently used NFS junk on its
> >> local disk.
> 
> This is btw exactly what CODA and AFS does best.
> 
> > Technically cachefs is just a union mount with tmpfs or ramfs as the overlay 
> > on the underlying filesystem.  Doing a seperate cachefs is kind of pointless 
> > in Linux.

Cachefs is different from union mount as it is required to synchronize
contents in it with contents on NFS servers. 
I guess it isn't easy to keep them as any other clients may modify the
contents of the servers at any time.

> I think it is a bit different, since the cache is on disk and can be larger.
> If you want to put that in swap space, you may quickly exceed some VM
> limits. So there is a difference.

And we should use filesystem as cache space so that we can make
cachefs be persistent cache. After rebooting all cache remains valid.

Thank you,
Hirokazu Takahashi.
