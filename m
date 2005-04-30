Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVD3JnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVD3JnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVD3JnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:43:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:37035 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261174AbVD3JnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:43:13 -0400
Date: Sat, 30 Apr 2005 10:42:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430094218.GA32679@mail.shareable.org>
References: <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > > How do you bind mount it from a different namespace?  You _do_ need
> > > bind mount, since a new mount might require password input, etc...
> > 
> > Not nessecarily.  The filesystem gets called into ->get_sb for every mount,
> > and can then decided whether to return an existing superblock instance or
> > setup a new one.  If the credentials for the new mount match an old one
> > it can just reuse it.  (e.g. for block based filesystem it will always reuse
> > right now)
> 
> And if the credentials are checked in userspace (sshfs)?

Well, if you can find a way to tell the userspace FUSE daemon to know
that the mount is being done by the same user as the existing mount,
you don't need (or want) to check the credentials - you want the FUSE
daemon to tell the kernel code which superblock to reuse.

This hack is a bit nasty - namespace per login, copying mounts
from another login's namespace - but it would work.

-- Jamie
