Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbULHCUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbULHCUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULHCUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:20:33 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:63192 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262007AbULHCUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:20:25 -0500
Date: Wed, 8 Dec 2004 03:20:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208022020.GH16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207180033.6699425b.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 06:00:33PM -0800, Andrew Morton wrote:
> untuned SCSI benchmark results without realising that.  If a distro is
> always selecting CFQ then they've probably gone and deoptimised all their
> IDE users.  

The enterprise distro definitely shouldn't use "as" by default: database
apps _must_ not use AS, they've to use either CFQ or deadline. CFQ is
definitely the best for enterprise distros. This is a tangible result,
SCSI/IDE doesn't matter at all (and keep in mind they use O_DIRECT a
lot, so such 64kib Jens found would be a showstopper for a enterprise
release, slelecting something different than "as" is a _must_ for
enterprise distro).

In the desktop distro you'll notice the /proc/cmdline has elevator="as"
because for desktop distros more people is going to use them for
desktop as expected.

But for enterprise distros this isn't the case, and cfq (or deadline)
must be the default, sure not "as". So claiming that selecting cfq by
default (I said in the enterprise distro) is deoptimising users, is
a wrong statement and the opposite of reality.

And personally I use cfq even on the desktop (since I'm not a normal
desktop user and I've apps writing too).

> AS needs another iteration of development to fix these things.  Right now
> it's probably the case that we need CFQ or deadline for servers and AS for
> desktops.   That's awkward.

Exactly.

If you believe AS is going to perform better than CFQ on the database
enterprise usage, we just need to prove it in practice after the round
of fixes, then changing the default back to "as" it'll be an additional
one liner on top of the blocker direct-io bug.

Desktop is already forced to "as" by /proc/cmdline, so it's not affected
on how we change the default of the enterprise distro AFIK.
