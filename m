Return-Path: <linux-kernel-owner+w=401wt.eu-S932273AbXAIRQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbXAIRQy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXAIRQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:16:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51137 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbXAIRQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:16:53 -0500
Date: Tue, 9 Jan 2007 18:16:52 +0100
From: Jan Kara <jack@suse.cz>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109171651.GC23174@atrey.karlin.mff.cuni.cz>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <20070108231524.GA1269@filer.fsl.cs.sunysb.edu> <20070109121552.GA1260@atrey.karlin.mff.cuni.cz> <1168360219.6054.14.camel@lade.trondhjem.org> <1168360893.5024.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168360893.5024.38.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2007-01-09 at 11:30 -0500, Trond Myklebust wrote:
> > On Tue, 2007-01-09 at 13:15 +0100, Jan Kara wrote:
> > > > On Mon, Jan 08, 2007 at 11:18:52AM -0800, Andrew Morton wrote:
> > > > > On Sun,  7 Jan 2007 23:12:53 -0500
> > > > > "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> > > > > 
> > >   <snip>
> > > 
> > > > > > Any such change can cause Unionfs to oops, or stay
> > > > > > silent and even RESULT IN DATA LOSS.
> > > > > 
> > > > > With a rather rough user interface ;)
> > > > 
> > > > That statement is meant to scare people away from modifying the lower fs :)
> > > > I tortured unionfs quite a bit, and it can oops but it takes some effort.
> > >   But isn't it then potential DOS? If you happen to union two filesystems
> > > and an untrusted user has write access to both original filesystem and
> > > the union, then you say he'd be able to produce oops? That does not
> > > sound very secure to me... And if any secure use of unionfs requires
> > > limitting access to the original trees, then I think it's a good reason
> > > to implement it in unionfs itself. Just my 2 cents.
> > 
> > You mean somebody like, say, a perfectly innocent process working on the
> > NFS server or some other client that is oblivious to the existence of
> > unionfs stacks on your particular machine?
> > To me, this has always sounded like a showstopper for using unionfs with
> > a remote filesystem.
> 
> Again, what about fibre channel support?  Imagine I have multiple blades
> connected to a SAN.  For whatever reason I format the san w/ ext3 (I've
> actually done this when we didn't need sharing, just needed a huge disk,
> for instance for doing benchmarks where I needed a large data set that
> was bigger than the 40GB disk that the blades came with).  I better not
> touch that disk from any of the other blades.
> 
> All you are saying is unionfs should always make sure its data is sane,
> never make assumptions about it being correct.
  Nope. I just say that unionfs should do some reasonable precautions so
that it's not easy to screw it (especially not in a DOS way). If I have
a device, then it is usually accessible only to admin and so user cannot
usually do anything bad to e.g. ext3. On the other hand part of
namespace (that unionfs takes instead of a device) is often accessible to
user and so I'd expect it wouldn't be uncommon for a user to be able to
screw unionfs. Of course, you can say: In a reasonable setup, unioned
trees should not be accessible to ordinary user (e.g. their topmost
directory should have 000 permissions). I'm just not sure whether
an average admin will setup his union trees in this way...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
