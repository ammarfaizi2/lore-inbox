Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRDZTvG>; Thu, 26 Apr 2001 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135477AbRDZTur>; Thu, 26 Apr 2001 15:50:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131638AbRDZTuc>; Thu, 26 Apr 2001 15:50:32 -0400
Date: Thu, 26 Apr 2001 21:44:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426214444.B819@athlon.random>
In-Reply-To: <20010426211557.Z819@athlon.random> <Pine.GSO.4.21.0104261530370.15385-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104261530370.15385-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 26, 2001 at 03:34:00PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 03:34:00PM -0400, Alexander Viro wrote:
> Same scenario, but with read-in-progress started before we do getblk(). BTW,

how can the read in progress see a branch that we didn't spliced yet? We
clear and mark uptodate the new part of the branch before it's visible
to any reader no? then in splice we write the key into the where->p and
the branch become visible to the readers but by that time the reader
won't start I/O because the buffer are just uptodate. I only had a short
look now and to verify Ingo's fix, so maybe I overlooked something.

> without direct access to device - truncate() doesn't terminate writeout of
> the indirect blocks it frees (IMO it should, but that's another story).

If the block is under I/O or dirty that's another story, the only issue
here is when the buffer block is new and not uptodate.

Andrea
