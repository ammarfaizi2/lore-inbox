Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJAOlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJAOlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:41:40 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10966 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261882AbTJAOli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:41:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16250.59296.349391.866901@gargle.gargle.HOWL>
Date: Wed, 1 Oct 2003 16:41:36 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: why no EXPORT_SYMBOL of get_sb_pseudo()?
In-Reply-To: <16250.48302.182915.846180@gargle.gargle.HOWL>
References: <16250.39070.555465.86772@gargle.gargle.HOWL>
	<20031001110303.GQ7665@parcelfarce.linux.theplanet.co.uk>
	<16250.48302.182915.846180@gargle.gargle.HOWL>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:
 > viro@parcelfarce.linux.theplanet.co.uk writes:
 >  > On Wed, Oct 01, 2003 at 11:04:30AM +0200, Mikael Pettersson wrote:
 >  > > fs/libfs.c:get_sb_pseudo() isn't exported to modules,
 >  > > but a lot of the other stuff in fs/libfs.c is.
 >  > > 
 >  > > Is there a particular reason for this or just an oversight?
 >  > > 
 >  > > Making a private copy of get_sb_pseudo()'s definition works
 >  > > in a module, but that's not exactly productive use of
 >  > > programmer time or source and object code space.
 >  > 
 >  > Are you really sure that get_sb_pseudo() is what you need?  It might be
 >  > possible, but I suspect that simple_fill_super() would be the right thing
 >  > to use.  Care to give details?
 > 
 > I have a pseudo fs to support special files constructed and
 > returned as the result of certain operations in the module.
 > 
 > This is very very similar to what e.g. pipefs does, so the
 > fs implementation is closely modelled after fs/pipe.c. And
 > since pipefs, futexes, and a number of other pseudo fs:s in
 > the kernel all use get_sb_pseudo() in their ->get_sb method,
 > I figured I should do the same.

I've now checked what simple_fill_super() does, and it doesn't
seem like a valid replacement for get_sb_pseudo(), especially
since it allocates a root directory inode and populates it.
This is clearly not needed for a pseudo fs that won't be mounted.

I can submit a trivial patch to export get_sb_pseudo(), but it
may fare better with Linus if Al ACKs it first.

/Mikael
