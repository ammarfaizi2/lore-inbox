Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbREFDBQ>; Sat, 5 May 2001 23:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbREFDBG>; Sat, 5 May 2001 23:01:06 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:51984 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131497AbREFDBC>; Sat, 5 May 2001 23:01:02 -0400
Date: Sun, 6 May 2001 15:00:58 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506150058.A31393@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random> <20010505151808.A29451@metastasis.f00f.org> <20010506023723.A22850@athlon.random> <20010506141437.A31269@metastasis.f00f.org> <20010506045001.C22850@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010506045001.C22850@athlon.random>; from andrea@suse.de on Sun, May 06, 2001 at 04:50:01AM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 04:50:01AM +0200, Andrea Arcangeli wrote:

    Moving e2fsck into the kernel is a completly different matter
    than caching the blockdevice accesses with pagecache instead of
    buffercache.

No, I was takling about user space fsck using character devices.
Solaris is one example.

    I have no idea why/if other got rid of it completly, but the fact
    block_dev is useful has nothing to do if it's in pagecache or in
    buffercache, really. 

I'm not claiming it is... what I'm asking is _why_ do we need block
devices once 'everything' lives in the page cache?

    It's just that by doing it in pagecache you can mmap it as well
    and it will provide overall better performance and it's probably
    cleaner design. The only visible change is that you will be able
    to mmap a blockdevice as well.

Why? What needs to mmap a block device? Since these are typically
larger than that you can mmap into a 32-bit address space (yes, I'm
ignoring the 5% or so of cases where this isn't true) I'm not aware
on many applications that do it.

Databases typically _want_ raw/character device access and do their
own buffering, I assume related applications also do.

    About a kernel based fsck Alexander told me he likes it, I
    personally don't care about it that much because I believe...

As I said, I'm not takling about kernel based fsck, although for
_VERY_ large filesystems even with journalling I suspect it will be
required one day (so it can run in the background and do consistency
checking when the machine is idle).


  --cw
