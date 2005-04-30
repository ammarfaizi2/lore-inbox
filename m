Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVD3Oge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVD3Oge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVD3Oge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:36:34 -0400
Received: from mail.shareable.org ([81.29.64.88]:44715 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261235AbVD3Og2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:36:28 -0400
Date: Sat, 30 Apr 2005 15:36:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430143609.GA4362@mail.shareable.org>
References: <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Well, if you can find a way to tell the userspace FUSE daemon to know
> > that the mount is being done by the same user as the existing mount,
> > you don't need (or want) to check the credentials - you want the FUSE
> > daemon to tell the kernel code which superblock to reuse.
> 
> It sounds very _very_ complicated compared to just using bind mounts.
> 
> And maybe the user _does_ want a new connection to the same server
> (for whatever reason).  Why should we _force_ a sharing of
> superblocks?

The point is that you can decide whether to do that in userspace.
It's up to whatever code you put in the _userspace_ FUSE commands.

No kernel support for bind mounts from another namespace is required.

Actually, in terms of complexity, it's not much different from using
bind mounts.  Either way involves finding all the mounts of another
session and copying them one by one: either by getting confirmation
from the daemon to attach to the same superblock, or by getting
handles from the daemon for all the individual directories to bind
mount.

In all, I think private namespaces are still the cleaner way to do it
_when_ a user wants their mounts to appear in multiple sessions anyway.

But bind mounts or superblock sharing are more flexible, at the same
time as being more cumbersome as a user interface.

-- JAmie
