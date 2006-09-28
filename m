Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWI1XDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWI1XDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWI1XDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:03:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964907AbWI1XDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:03:46 -0400
Date: Fri, 29 Sep 2006 01:03:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Message-ID: <20060928230339.GF26653@elf.ucw.cz>
References: <200609290005.17616.rjw@sisk.pl> <200609290013.39137.rjw@sisk.pl> <20060928154237.d91abb1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928154237.d91abb1f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Fri, 29 Sep 2006 00:13:38 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > To be able to use swap files as suspend storage from the userland suspend
> > tools we need an additional ioctl() that will allow us to provide the kernel
> > with both the swap header's offset and the identification of the resume
> > partition.
> > 
> > The new ioctl() should be regarded as a replacement for the
> > SNAPSHOT_SET_SWAP_FILE ioctl() that from now on will be considered as
> > obsolete, but has to stay for backwards compatibility of the interface.
> > 
> > +
> > +/*
> > + * This structure is used to pass the values needed for the identification
> > + * of the resume swap area from a user space to the kernel via the
> > + * SNAPSHOT_SET_SWAP_AREA ioctl
> > + */
> > +struct resume_swap_area {
> > +	u_int16_t dev;
> > +	loff_t offset;
> > +} __attribute__((packed));

> 
> hmm.  Asking the compiler to pack 16-bit and 64-bit quantities in this
> manner is a bit risky.  I guess it'll do the right thing, consistently,
> across all compiler versions and vendors and 32-bit-on-64-bit-kernel, etc.
> 
> But from a defensiveness/paranoia POV it'd be better to use a u32 here, I
> suspect.  (Will access to that loff_t cause an alignment trap on ia64?  Any
> other CPUs?  Dunno).

Perhaps just loff_t offset; u32 dev; ? If 64-bit variable is first, we
should avoid most problems, no?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
