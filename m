Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRDXB2l>; Mon, 23 Apr 2001 21:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDXB2b>; Mon, 23 Apr 2001 21:28:31 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:55302 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131246AbRDXB2W>; Mon, 23 Apr 2001 21:28:22 -0400
Date: Mon, 23 Apr 2001 20:28:12 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [upatch] lib/Makefile
Message-ID: <20010423202812.C1690@cadcamlab.org>
In-Reply-To: <20010423171624.B1690@cadcamlab.org> <20010423153026.E19945@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010423153026.E19945@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Apr 23, 2001 at 03:30:26PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > Introduced in 2.4.4pre4, I believe.  $(export-objs) need not be
> > conditional, and the if statement was not really correct either,
> > although in this case it probably worked.

[Tom Rini]
> Er, are you sure changing the test for !"nn" is correct here?  I
> _think_ at least that is intentional and correct (since you can have
> one on but not the other).

I understand the intent.  The point is that in our current makefiles
you are not allowed to assume that a negative value is "n", because it
could be "".

2.4.4pre probably works because each 'config.in' file explicitly sets
these variables to "y" or "n".  However, it would be perfectly legal
for a config.in to unset the variable, or for that matter not even
mention it.  In that case the !"nn" test fails.

This is the same reason you cannot use 'ifdef CONFIG_*' in the
Makefiles.  Lots of people do, but each instance is a bug.  They are
assuming the opposite: that a variable will be "" rather than "n".

(N.B. this issue will go away with Keith's 2.5 Makefiles.  And there
was much rejoicing.)

Peter
