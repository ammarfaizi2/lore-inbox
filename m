Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268742AbTBZNUp>; Wed, 26 Feb 2003 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268743AbTBZNUp>; Wed, 26 Feb 2003 08:20:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11510 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S268742AbTBZNUo>; Wed, 26 Feb 2003 08:20:44 -0500
Date: Wed, 26 Feb 2003 13:32:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jonah Sherman <jsherman@stuy.edu>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
In-Reply-To: <20030225193817.GA2157@j0nah.ath.cx>
Message-ID: <Pine.LNX.4.44.0302261322210.1614-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Jonah Sherman wrote:
> On Tue, Feb 25, 2003 at 09:15:56PM +0000, Hugh Dickins wrote:
> > If you "losetup /dev/loop0 /dev/hdN", then it's LO_FLAGS_BH_REMAP
> > and doesn't even call bio_copy: it doesn't copy bio or buffers or
> 
> It appears this way if you just look at none_status, but you didn't look
> at loop_init_xfer().  Notice that it doesn't call xfer->init unless
> type != 0, so that flag is infact never set.

Hah!  Indeed, thank you for setting me straight.

> > Can you shed more light on how to reproduce this?
> 
> The block dev it is being used on must be larger than your RAM.  I don't
> have any swap on this machine, so I don't know if it must be bigger than
> that too.  Maybe disabling swap before testing this oops will make it
> work?

Yes, I'd tried block dev larger than RAM, with and without swap:
no luck.  Perhaps my disks somehow keep up with the stuff coming
down from /dev/zero but yours don't?  (No disgrace!)  But never mind,
Andrew has a surer way to hit it.

> In any case, the patch sent by Andrew Morton fixed this bug.

Andrew's patch for this is a thing of great beauty, a shining beacon
to inspire all whose eyes are graced by it.  But I'd still have liked
to understand why it's needed in your case not mine: it's a bit
embarrassing for me to claim I have patches for various loopmem
hangs, yet be unable to reproduce this.

Hugh

