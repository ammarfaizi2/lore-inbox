Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVF3Uer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVF3Uer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVF3UVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:21:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263033AbVF3TrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:47:14 -0400
Date: Thu, 30 Jun 2005 12:46:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: arjan@infradead.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: FUSE merging?
Message-Id: <20050630124622.7c041c0b.akpm@osdl.org>
In-Reply-To: <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> On Thu, 2005-06-30 at 12:20 +0200, Arjan van de Ven wrote:
> > On Thu, 2005-06-30 at 12:12 +0200, Miklos Szeredi wrote:
> > > > if you are so interested in getting fuse merged... why not merge it
> > > > first with the security stuff removed entirely. And then start
> > > > discussing putting security stuff back in ?
> > > 
> > >   a) it's already been discussed to death (just search for 'fuse' on
> > >      lkml and fsdevel)
> > > 
> > >   b) I don't consider it a good idea to ship a defunct version of it in
> > >      the mainline
> > > 
> > > Can you please accept my wish to have FUSE merged _with_ the
> > > unprivileged mount's thing.
> > 
> > By the same argument:
> > Then can you please accept that FUSE will not get merged right now.
> 
> Why should he?  IMNSHO it should be merged right now with the security
> stuff.  FUSE works as is.  Without the security stuff FUSE is useless.
> 
> I have yet to read even a single constructive argument why it should not
> be merged as is.

I believe that the requirement which fuse_allow_task() attempts to satisfy
is legitimate and is useful to FUSE users.

The fact that, AFAIK, nobody as found a way to implement it more nicely is
a Linux problem, not a FUSE problem.

Given that the actual amount of code involved is small, centralised and
well known about we can easily fix it up later if/when new infrastructure
or new ideas become available.

So unless someone is able to come up with a better approach in the next few
days I'm inclined to say "we suck" and merge the thing as-is.

However, a few things:

- is there anything in the current implementation of the permission stuff
  which might tie our hands if it is later reimplemented?  IOW: does the
  current FUSE user interface in any way lock us into the current FUSE
  implementation (fuse_allow_task())?

- the fuse mount options don't seem to be documented

- aren't we going to remove the nfs semi-server feature?

- Frank points out that a user can send a sigstop to his own setuid(0)
  task and he intimates that this could cause DoS problems with FUSE.  More
  details needed please?

- I don't recall seeing an exhaustive investigation of how an
  unprivileged user could use a FUSE mount to implement DoS attacks against
  other users or against root.
