Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131065AbRCGNmd>; Wed, 7 Mar 2001 08:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131071AbRCGNmX>; Wed, 7 Mar 2001 08:42:23 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:18189 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131065AbRCGNmI>;
	Wed, 7 Mar 2001 08:42:08 -0500
Date: Wed, 7 Mar 2001 14:41:20 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hashing and directories
Message-ID: <20010307144120.A9878@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet> <20010302095608.G15061@atrey.karlin.mff.cuni.cz> <20010307013729.A7184@pcep-jamie.cern.ch> <984bur$lqq$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <984bur$lqq$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 06, 2001 at 08:03:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The long-term solution for this is to create the new VM space for the
> new process early, and add it to the list of mm_struct's that the
> swapper knows about, and then just get rid of the pages[MAX_ARG_PAGES]
> array completely and instead just populate the new VM directly.  That
> way the destination is swappable etc, and you can also remove the
> "put_dirty_page()" loop later on, as the pages will already be in their
> right places. 
> 
> It's definitely not a one-liner, but if somebody really feels strongly
> about this, then I can tell already that the above is the only way to do
> it sanely.

Yup.  We discussed this years ago, and it nobody thought it important
enough.  mm->mmlist didn't exist then, and creating it it _just_ for
this feature seemed too intrusive.  I agree it's the only sane way to
completely remove the limit.

-- Jamie
