Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbREWXX6>; Wed, 23 May 2001 19:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbREWXXi>; Wed, 23 May 2001 19:23:38 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:7692 "EHLO unity.starfire")
	by vger.kernel.org with ESMTP id <S263315AbREWXXd>;
	Wed, 23 May 2001 19:23:33 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Wed, 23 May 2001 17:23:26 -0600
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
Message-ID: <20010523172326.A898@wintermute.starfire>
In-Reply-To: <20010523161149.A701@Voyager.powersurfr.com> <Pine.GSO.4.21.0105231813490.20269-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0105231813490.20269-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 23, 2001 at 06:21:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 06:21:23PM -0400, Alexander Viro wrote:
> 
> 
> On Wed, 23 May 2001, Maciek Nowacki wrote:
> 
> > > If you want to keep it until later (i.e. want to destiry it by hands)
> > > mkdir /initrd on your final root and old one will be remounted there.
> > > Again, "Trying to unmount old root ... okay" means that it already got
> > > an equivalent of BKLFLSBUF
> > 
> > Ah, okay.. I assumed this behavior had been removed. I will try this as well.
> 
> change_root() in 2.4.4 gives you explicit destroy_buffers(). In 2.4.5-pre5
> it simply does BLKFLSBUF - calls ioctl_by_bdev(). And BLKFLSBUF boils
> down to destroy_buffers().
> 
> I would really like to hear details re survival of the initrd contents.
> I've looked at the way rd.c "protects" the data and it seems to be
> b0rken - playing games with igrab() is not a good idea for driver...

I wrote out the contents of /dev/rd/0 a few times and diff'ed with the
uncompressed image of the initrd on the server. No difference each time. The
same after digging into swap, turning off swap, running blockdev --flushbufs
several times (always with BLKFLSBUF: Device or resource busy).

The next test will be to create an initrd that has the 'initrd' directory..

(this is all with 2.4.4-ac13 +crypto-2.4.3.1 +alsa-cvs)

Maciek
