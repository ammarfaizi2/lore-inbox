Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbRESUya>; Sat, 19 May 2001 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbRESUyV>; Sat, 19 May 2001 16:54:21 -0400
Received: from ohiper0-142.apex.net ([209.250.50.142]:14854 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S261324AbRESUyL>; Sat, 19 May 2001 16:54:11 -0400
Date: Sat, 19 May 2001 15:53:21 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010519155321.A19764@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <20010519184819.M18853@arthur.ubicom.tudelft.nl> <20010519104511.A2648@vitelus.com> <20010519213803.N18853@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519213803.N18853@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Sat, May 19, 2001 at 09:38:03PM +0200
X-Uptime: 3:36pm  up 16:31,  2 users,  load average: 1.17, 1.24, 1.32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 09:38:03PM +0200, Erik Mouw wrote:
> > But /dev/sda/offset=234234,limit=626737537 isn't a file! ls it and see
> > if it's there. writing to files that aren't shown in directory listings
> > is plain evil. I really don't want to explain why. It's extremely
> > messy and unintuitive.
> > 
> > It would be better to do this with a file that does exist, for example
> > writing something to /proc/disks/sda/arguments. Then again, I don't
> > even think much of dynamic file systems in the first place.
> 
> A network socket also isn't a file in a filesystem, you can't do ls on
> it, it doesn't even exist until you create one, but still you use it as
> a file by reading and writing it. I don't see any difference in the way
> you create /dev/sda/offset=234234,limit=626737537 by just using it.

I think you're kind of missing the point.  Erik is saying that, by the
path, it appears to be a file, even though it isn't listed as a file in
the directory /dev/sda.  Network sockets don't have a path, unless its a
Unix domain socket, and then you /can/ 'ls' it.

My opinion is that putting options directly in the open is no nicer than
an ioctl.  I think that where this scheme really shines, though, is
where there are multiple logical channels to a device, as in the
/dev/fb0/control example.  I like that.  What could be done, therefore,
is have a /dev/ttyS0/control file, where you could "echo
'baud=19200,parity=odd' > /dev/ttyS0/control" or even "echo '19200' >
/dev/ttyS0/baud" and "echo 'odd' > /dev/ttyS0/parity".  That seems to me
to be the cleanest and most logical solution.

As for this partition stuff, it seems a bad example to me.  Maybe I'm
just spoiled, but I think partitions is something that the kernel can
and should abstract.  None of this /dev/sda/offset=12345,limit=45678
madness.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
