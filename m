Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRB1TSw>; Wed, 28 Feb 2001 14:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRB1TSn>; Wed, 28 Feb 2001 14:18:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63709 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129216AbRB1TSe>;
	Wed, 28 Feb 2001 14:18:34 -0500
Date: Wed, 28 Feb 2001 14:18:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <200102281906.f1SJ6qS02383@moisil.dev.hydraweb.com>
Message-ID: <Pine.GSO.4.21.0102281416460.7107-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Ion Badulescu wrote:

> On Wed, 28 Feb 2001 13:07:29 -0500 (EST), Alexander Viro <viro@math.psu.edu> wrote:
> 
> > On Wed, 28 Feb 2001, David L. Parsley wrote:
> 
> >> Yeah, mount --bind is cool, I've been using it on one of my projects
> >> today.  But - maybe I'm just not thinking creatively enough - what are
> >> the advantages of mount --bind versus just symlinking?
> > 
> > 1) Correctly working ".." (obviously relevant only for directories)
> > 2) Try to create symlinks on read-only NFS mount. For bonus points, try
> > to do that one one client without disturbing everybody else.
> > 3) Try to make it different for different users, for that matter.
> 
> And disadvantages: you can't have broken symlinks.
> 
> This actually turns out to be quite a bit of a problem when one tries
> to use bind mounts with autofs. For one thing, it's perfectly legal
> to have /autofs/foo as a symlink to /autofs/bar/foo, where /autofs/bar
> is not yet mounted -- but a bind mount can't handle that...

First of all, you still have symlinks. What's more, the right solution
is to use local objects at the mountpoints. And forget about having a
small tree full of links to real mountpoints. Think of autofs-with-one-node.

