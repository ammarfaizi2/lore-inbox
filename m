Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLLXyn>; Tue, 12 Dec 2000 18:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQLLXye>; Tue, 12 Dec 2000 18:54:34 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:23306 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129319AbQLLXyW>; Tue, 12 Dec 2000 18:54:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jasper Spaans <jasper@spaans.ds9a.nl>
Date: Wed, 13 Dec 2000 10:21:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14902.45844.964925.199379@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: message from Jasper Spaans on Tuesday December 12
In-Reply-To: <20001212160605.A1835@spaans.ds9a.nl>
	<Pine.LNX.4.10.10012121047140.2239-100000@penguin.transmeta.com>
	<20001212234126.A1866@spaans.ds9a.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, jasper@spaans.ds9a.nl wrote:
> On Tue, Dec 12, 2000 at 11:06:07AM -0800, Linus Torvalds wrote:
> >
> > To get better debug output, could you please do something for me? 
> > 
> > In fs/buffer.c, get rid of "end_buffer_io_bad" completely, and replace all
> > users of it with NULL.
> > 
> > Then, in drivers/block/ll_rw_block.c: generic_make_request(), add a test
> > like
> > 
> > 	if (!bh->b_end_io) BUG();
> > 
> > to the top of that function.

Could you add this test to the top of md_make_request as well, because
requests to raid5 don't go through generic_make_request.

> 
> Strange thing is that it doesn't call BUG() and the trace seems quite
> identical -- this caused me to start looking at the code in
> drivers/md/raid5.c and it seems this null pointer deref is coming from there
> - Neil, do you have some documentation on how this code should work, as
> stripe_head causes some null-pointer-derefs inside my head..

No, no doco, sorry.
I do have a new version of the code that I haven't been brave enough
to submit during a code freeze (whatever that is)... you could try
the raid5 patch under
  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.0-test12-pre8

I expect that you will get the same result as I don't (currently)
think the bug is in RAID code, but at least I would get one more
tester for my code....

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
