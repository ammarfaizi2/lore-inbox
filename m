Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbRGPSXk>; Mon, 16 Jul 2001 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267561AbRGPSXa>; Mon, 16 Jul 2001 14:23:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12358 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267560AbRGPSXV>; Mon, 16 Jul 2001 14:23:21 -0400
Date: Mon, 16 Jul 2001 19:23:05 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Mike Black <mblack@csihq.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010716192305.F28023@redhat.com>
In-Reply-To: <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au> <125101c10bc1$85eab630$e1de11cc@csihq.com> <20010713183800.J13419@redhat.com> <001101c10c51$bd6239e0$b6562341@cfl.rr.com> <3B5033F2.AF71624E@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5033F2.AF71624E@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jul 14, 2001 at 09:58:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 14, 2001 at 09:58:42PM +1000, Andrew Morton wrote:

> OK, there was a nasty bug in 0.9.1 which I was not able to trigger
> in a solid month's testing.  But others with more worthy hardware
> were able to find it quite quickly.

It would depend very much on the workload.  The problem would only
occur if you had two tasks collide when trying to allocate a block at
the same time, which essentially means doing mmap writes in the middle
of a sparse file.  Most workloads would not ever trigger that no
matter how much you tried.  

> Stephen fixed it in 0.9.2.
> I don't know if it explains the failure you saw.

Me neither, but it could conceivably do so.  The worst case scenario
as an immediate result of that bug would be corruption in the middle
of an indirect block.  We used to see that on ext2 on kernels before
2.4.3 as a result of a similar bug there, and the side effects of the
bug were often severe --- if an indirect block is corrupted this way,
then on subsequent delete, you can end up freeing arbitrary parts of
the fs and all bets are off beyond that.

With the 0.9.2 fix in place, I've seen no such problems with any
stress tests, although the VM problems being discussed elsewhere do
still sometimes cause things to stall for a while or lock up totally
after a few hours.

Cheers,
 Stephen
