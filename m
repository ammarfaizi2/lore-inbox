Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUHCGNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUHCGNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUHCGNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:13:47 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:32416 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265053AbUHCGNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:13:44 -0400
Subject: Re: DRM code reorganization
From: Eric Anholt <eta@lclark.edu>
To: Dave Jones <davej@redhat.com>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <20040802185746.GA12724@redhat.com>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
	 <410E81C3.2070804@us.ibm.com>  <20040802185746.GA12724@redhat.com>
Content-Type: text/plain
Message-Id: <1091513621.885.107.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 23:13:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 11:57, Dave Jones wrote:
> I don't maintain upstream DRM, but I have a fair amount of responsibility
> regarding the Fedora kernel, and I'll state publically that looking at
> bugs in drivers/char/drm is right up there on my list of
> "things I'd rather not do after lunch". Maintainability goes much
> further than 'the guy that wrote the code can grok it'.
> 
> People trying to pick up 3d driver programming on Linux have a huge
> hurdle in their place, as that code resembles *NO OTHER* driver code
> in the tree.

Here, I'd note that I got started in the DRM because I was interested in
3D drivers, but the actual 3D drivers were far bigger hurdles compared
to understanding even some nasty kernel spaghetti.

Of course, this is not to say that we don't have a ton of room for
improvement in the DRM, without even going back to having a generic DRM
library.  One of the things that I think would be nice to see is the
gamma DMA made to be like the rest of the drivers, in which case a lot
of code related to just that driver could be removed.  We could also do
some significant cleanups if we could allow ourselves to remove old
interface mistakes eventually.  This has been made harder than it should
be by the long turnaround times for new monolithic X releases, which is
finally changing now.

>  > >ian: what about splitting the current memory management code into a
>  > >module that can be swapped for your new version?
>  > 
>  > AFAIK, the only drivers that have any sort of in-kernel memory manager 
>  > are the radeon (only used by the R200 driver) and i830.
> 
> ISTR SiS has some memory management code too, though I've not looked
> too closely at that for a long time.

The SiS (and via, which copied it) memory management has way too much
code for what little it has to do.  I've replaced it and made it smaller
in terms of code and binary size, 64-bit clean, and (I think) much more
readable.  I'm going to take a look at committing it once I can drag
myself away from X.Org, at which point someone with via hardware could
do the same for theirs.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


