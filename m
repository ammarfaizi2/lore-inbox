Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVFUU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVFUU26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVFUU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:26:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261803AbVFUUWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:22:30 -0400
Date: Tue, 21 Jun 2005 13:22:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050621132204.1b57b6ba.akpm@osdl.org>
In-Reply-To: <42B831B4.9020603@pobox.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > sparsemem
> > 
> >     OK by me for a merge.  Need to poke arch maintainers first, check that
> >     they've looked at it sufficiently closely.
> 
> seems sane, though there are some whitespace niggles that should be 
> cleaned up
> 

There are?  I thought I fixed most of them.

*general sigh*.  I wish people would absorb CodingStyle.  It's not hard,
and fixing the style post-facto creates a real mess.  I now have a great
string of kexec patches followed by a "kexec-code-cleanup.patch" which
totally buggers up the patch sequencing and really needs to be split into
18 parts and sprinkled back over the entire series.

> > rapidio-*
> > 
> >     Will merge.
> 
> send through netdev, as is proper
> 

OK.  But then the master version vanishes into the jgarzik git forest and I
won't know how to get it ;)

> > connector.patch
> > 
> >     Nice idea IMO, but there are still questions around the
> >     implementation.  More dialogue needed ;)
> > 
> > connector-add-a-fork-connector.patch
> > 
> >     OK, but needs connector.
> 
> I don't like connector
> 

How come?

> 
> > pcmcia-*.patch
> > 
> >     Makes the pcmcia layer generate hotplug events and deprecates cardmgr.
> >     Will merge.
> 
> Testing?  The goal behind the patch is certainly good, but I worry about 
> exposure.
> 

Yes, there will be a few problems I guess.  But people are testing it - we
know, because we've had lots of bug reports which were actually due to
greg-pci breakage...

> 
> > cachefs
> > 
> >     This is a ton of code which knows rather a lot about pagecache
> >     internals.  It allows the AFS client to cache file contents on a local
> >     blockdev.
> > 
> >     I don't think it's a justified addition for only AFS and I'd prefer to
> >     see it proven for NFS as well.
> > 
> >     Issues around add-page-becoming-writable-notification.patch need to
> >     be resolved.
> > 
> > cachefs-for-nfs
> > 
> >     A recent addition.  Needs review from NFS developers and considerably
> >     more testing.
> > 
> >     These things aren't looking likely for 2.6.13.
> 
> If I could vote more than once, I would!  I really like cachefs, and 
> have been pushing for its inclusion for a while.
> 

You've been using it?

> > kexec and kdump
> > 
> >     I guess we should merge these.
> > 
> >     I'm still concerned that the various device shutdown problems will
> >     mean that the success rate for crashing kernels is not high enough for
> >     kdump to be considered a success.  In which case in six months time we'll
> >     hear rumours about vendors shipping wholly different crashdump
> >     implementations, which would be quite bad.
> > 
> >     But I think this has gone as far as it can go in -mm, so it's a bit of
> >     a punt.
> 
> I'm not particularly pleased with these,

How come?

> and indeed vendors ARE shipping 
> other crashdump methods.

Which ones?

> 
> > reiser4
> > 
> >     Merge it, I guess.
> > 
> >     The patches still contain all the reiser4-specific namespace
> >     enhancements, only it is disabled, so it is effectively dead code.  Maybe
> >     we should ask that it actually be removed?
> 
> The plugin stuff is crap.  This is not a filesystem but a filesystem + 
> new layer.  IMO considered in that light, it duplicates functionality 
> elsewhere.
> 

hm.

