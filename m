Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271840AbRICWIh>; Mon, 3 Sep 2001 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRICWI1>; Mon, 3 Sep 2001 18:08:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6976 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271843AbRICWIS>; Mon, 3 Sep 2001 18:08:18 -0400
Date: Tue, 4 Sep 2001 00:09:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using O_DIRECT
Message-ID: <20010904000902.Z699@athlon.random>
In-Reply-To: <20010903104544.X23180@draal.physics.wisc.edu> <20010903175333.P699@athlon.random> <20010903105714.Y23180@draal.physics.wisc.edu> <20010903180524.Q699@athlon.random> <20010903151342.A2247@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010903151342.A2247@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Mon, Sep 03, 2001 at 03:13:42PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 03:13:42PM -0500, Bob McElrath wrote:
> I have written a small program to use O_DIRECT (attached), after
> applying your patch o_direct-14 to kernel 2.4.9.  Opening the file with
> O_DIRECT is successful, but attempts to write to the fd return EINVAL.
> 
> Am I doing something wrong?  Should I have to recompile glibc too?

eh, the alignment and size of the buffer have basically the same
restrictions of running read/write on a raw device, with the only
difference that for rawio the granularity is the hardblocksize, while
for O_DIRECT the granularity is the softblocksize of the filesystem.

We'll have to relax the granularity of the I/O down to the hardblocksize
for O_DIRECT too eventually.

Andrea
