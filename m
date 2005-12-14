Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVLNTn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVLNTn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLNTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:43:59 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:39172 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932495AbVLNTn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:43:59 -0500
Date: Wed, 14 Dec 2005 14:43:42 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] vm: enhance __alloc_pages to prioritize pagecache eviction when pressed for memory
Message-ID: <20051214194342.GA5738@hmsreliant.homelinux.net>
References: <20051207220401.GB13577@hmsreliant.homelinux.net> <20051209162901.71728620.akpm@osdl.org> <20051212182236.GB828@hmsreliant.homelinux.net> <20051212121639.2e5bb1e4.akpm@osdl.org> <20051212214043.GC828@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212214043.GC828@hmsreliant.homelinux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 04:40:43PM -0500, Neil Horman wrote:
> On Mon, Dec 12, 2005 at 12:16:39PM -0800, Andrew Morton wrote:
> > Neil Horman <nhorman@tuxdriver.com> wrote:
> > >
> > > On Fri, Dec 09, 2005 at 04:29:01PM -0800, Andrew Morton wrote:
> > > > Neil Horman <nhorman@tuxdriver.com> wrote:
> > > > >
> > > > > Hey all-
> > > > >      I was recently shown this issue, wherein, if the kernel was kept full of
> > > > > pagecache via applications that were constantly writing large amounts of data to
> > > > > disk, the box could find itself in a position where the vm, in __alloc_pages
> > > > > would invoke the oom killer repetatively within try_to_free_pages, until such
> > > > > time as the box had no candidate processes left to kill, at which point it would
> > > > > panic.
> > > > 
> > > > That's pretty bad.  Are you able to provide a description which would permit
> > > > others to reproduce this?
> > > 
> > > As promised, heres the reproducer that was given to me, and used to reproduce
> > > this problem:
> > > 
> > > 1) setup an nfs serve with a thread count of 2.  Of course, 1 thread might make
> > > the problem more easy to reproduce.  I haven't tried it yet.
> > > 
> > > 2) Setup 4 nodes to hammer the nfs mounted directory.  The 4 nodes should hammer
> > > out 4 gigs.  2 gigs didn't seem to be enough.
> > > 
> > > I used a locally developed tool called ior to reproduce this problem.  The tool
> > > can be found here:
> > > 
> > > http://www.llnl.gov/asci/platforms/purple/rfp/benchmarks/limited/ior/
> > > 
> > > I suppose anything that can write to NFS fast should be fine.  But that's what I
> > > did.
> > > 
> > > 
> > > If you do this, any node writing to the server that has more than 4GB of RAM
> > > should start oom killing to the point where it runs out of candidate processes
> > > and panics
> > 
> > We merged an NFS fix last week which will help throttling under heavy
> > writeout conditions..
> This one?
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bb713d6d38f7be4f4e7d790cddb1b076e7da6699
> I guess I must have just missed it during my testing. I'll give it a spin and
> let you know if it fixes my test case.
> 
> Thanks & Regards
> Neil
> 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> /***************************************************
>  *Neil Horman
>  *Software Engineer
>  *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
>  ***************************************************/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Just finished testing with the latest kernel, and the problem appears to be
gone.  I withdraw my patch.  Apologies for the noise.

Thanks & Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
