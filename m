Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDMP73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDMP73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDMP72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:59:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:14241 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261378AbVDMP7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:59:13 -0400
Date: Wed, 13 Apr 2005 16:58:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jan Hudec <bulb@ucw.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413155852.GB12825@mail.shareable.org>
References: <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu> <20050413125609.GA9571@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413125609.GA9571@vagabond>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > A nice implemention of it in FUSE could push it along a bit :)
> > 
> > Aren't there some assumptions in VFS that currently make this
> > impossible?
> 
> I believe it's OK with VFS, but applications would be confused to death.
> Well, there really is one issue -- dentries have exactly one parent, so
> what do you do when opening a file with hardlinks as a directory? (In
> fact IIRC that is what lead to all the funny talk about mountpoints,
> since they don't have this limitation)

Hardlinks aren't a problem when entering a file as if it's a
directory, provided the directory does not contain any hard links to a
parent in the hierarchy.  In other words, as long as it's a directed
acyclic graph.

This is trivially always true for virtual directories such as entering
an archive file.  And detachable/movable mountpoints are a nice and
sensible way to implement it.  Some work has actually been done on this.

Experiments with the reiserfs file-as-directory extension showed that
applications are generally ok with it.  It looks like a file, but you
can cd into it or follow a path lookup into it.

Linus had some good ideas on the exact semantics to implement when
doing path lookup on these objects.

-- Jamie
