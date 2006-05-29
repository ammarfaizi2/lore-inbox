Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWE2TRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWE2TRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWE2TRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:17:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25420 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751214AbWE2TRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:17:41 -0400
Date: Mon, 29 May 2006 15:17:40 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
In-reply-to: <20060302204432.GZ4329@suse.de>
X-X-Sender: nico@localhost.localdomain
To: Jens Axboe <axboe@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Tejun Heo <htejun@gmail.com>, Dave Miller <davem@redhat.com>,
       bzolnier@gmail.com, james.steward@dynamicratings.com, jgarzik@pobox.com,
       lkml <linux-kernel@vger.kernel.org>, mattjreimer@gmail.com
Message-id: <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <11371658562541-git-send-email-htejun@gmail.com>
 <1137167419.3365.5.camel@mulgrave>
 <20060113182035.GC25849@flint.arm.linux.org.uk>
 <1137177324.3365.67.camel@mulgrave>
 <20060113190613.GD25849@flint.arm.linux.org.uk>
 <20060222082732.GA24320@htj.dyndns.org>
 <1141325189.3238.37.camel@mulgrave.il.steeleye.com>
 <20060302203039.GH28895@flint.arm.linux.org.uk> <20060302204432.GZ4329@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Jens Axboe wrote:

> On Thu, Mar 02 2006, Russell King wrote:
> > On Thu, Mar 02, 2006 at 12:46:28PM -0600, James Bottomley wrote:
> > > On Wed, 2006-02-22 at 17:27 +0900, Tejun Heo wrote:
> > > > The objection raised by James Bottomley is that although syncing the
> > > > kernel page is the responsbility of the driver, syncing user page is
> > > > not; thus, use of flush_dcache_page() is excessive.  James suggested
> > > > use of flush_kernel_dcache_page().
> > > 
> > > The problem is that it's not only excessive, it would entangle us with
> > > mm locking.  Basically, all you want to ensure is that the underlying
> > > memory has the information after you've done (rather than the CPU
> > > cache), flush_kernel_dcache_page() will achieve this.  The block layer
> > > itself takes care of user space coherency.
> > 
> > Your understanding of the problem on ARM remains fundamentally flawed.
> > I see no way to resolve this since you don't seem to listen or accept
> > my reasoning.
> > 
> > Therefore, message I'm getting from you is that we are not allowed to
> > have an ARM system which can possibly work correctly with PIO.
> > 
> > As a result, I have no further interest in trying to resolve this issue,
> > period.  ARM people will just have to accept that PIO mode IDE drivers
> > just will not be an option.
> 
> Hey Russell calm down, lets get this thing fixed in the easiest and
> least intrusive way for 2.6.17. As mentioned before, this isn't actually
> a new problem by any stretch, a 2.6.17 solution would be acceptable to
> you I hope.

Has any discussion about this problem lead to some consensus?

> What do you think of the kmap_atomic_pio() (notoriously bad at names,
> but it should get the point across) and kunmap_atomic_pio(), the latter
> accepting a read/write flag to note if we wrote to a vm page?
> 
> This is basically Tejuns original patch set, just moving it out of the
> block layer so it's a generel exported property of the kmap api.

What was the problem with Tejun's patchset already to which RMK (and 
many others) agreed?

I do have hardware that exhibits the problem and therefore I wish the 
discussion could be resumed.


Nicolas
