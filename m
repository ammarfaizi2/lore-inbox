Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTJALi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTJALiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:38:25 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:38586 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262004AbTJALiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:38:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16250.48302.182915.846180@gargle.gargle.HOWL>
Date: Wed, 1 Oct 2003 13:38:22 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: why no EXPORT_SYMBOL of get_sb_pseudo()?
In-Reply-To: <20031001110303.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <16250.39070.555465.86772@gargle.gargle.HOWL>
	<20031001110303.GQ7665@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
 > On Wed, Oct 01, 2003 at 11:04:30AM +0200, Mikael Pettersson wrote:
 > > fs/libfs.c:get_sb_pseudo() isn't exported to modules,
 > > but a lot of the other stuff in fs/libfs.c is.
 > > 
 > > Is there a particular reason for this or just an oversight?
 > > 
 > > Making a private copy of get_sb_pseudo()'s definition works
 > > in a module, but that's not exactly productive use of
 > > programmer time or source and object code space.
 > 
 > Are you really sure that get_sb_pseudo() is what you need?  It might be
 > possible, but I suspect that simple_fill_super() would be the right thing
 > to use.  Care to give details?

I have a pseudo fs to support special files constructed and
returned as the result of certain operations in the module.

This is very very similar to what e.g. pipefs does, so the
fs implementation is closely modelled after fs/pipe.c. And
since pipefs, futexes, and a number of other pseudo fs:s in
the kernel all use get_sb_pseudo() in their ->get_sb method,
I figured I should do the same.

/Mikael
