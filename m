Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269183AbRHFXup>; Mon, 6 Aug 2001 19:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRHFXuf>; Mon, 6 Aug 2001 19:50:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20868 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269183AbRHFXuY>; Mon, 6 Aug 2001 19:50:24 -0400
Date: Mon, 6 Aug 2001 17:50:46 -0600
Message-Id: <200108062350.f76NokT26152@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108060723110.13716-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108060723110.13716-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	OK, folks - that's it.  By all reasonable standards a year
> _is_ sufficient time to fix an obvious race.  One in
> devfs/base.c::create_entry() had been described to Richard more than
> a year ago.  While I respect the "I'll do it myself, don't spoil the
> fun" stance, it's clearly over the bleedin' top.  Patch for that one
> is in the end of posting.  Linus, see if it looks sane for you.

Linus: please don't apply.
Alan: I notice you've put Al's patch into 2.4.7-ac8. Please remove it.

This patch has the following ugly construct:

> +	/*  Ensure table size is enough  */
> +	while (fs_info.num_inodes >= fs_info.table_size) {

Putting the allocation inside a while loop is horrible, and isn't a
perfect solution anyway. I'm fixing this (and other races) with proper
locking. If you went to the trouble to start patching, why at least
didn't you do it cleanly with a lock?

Furthermore, the patch makes gratuitous formatting changes (which made
it harder to see what it actually *changed*).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
