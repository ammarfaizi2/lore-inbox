Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291651AbSBAJr2>; Fri, 1 Feb 2002 04:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291645AbSBAJrS>; Fri, 1 Feb 2002 04:47:18 -0500
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:24936 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S291651AbSBAJrI>; Fri, 1 Feb 2002 04:47:08 -0500
Date: Thu, 31 Jan 2002 12:52:11 +0000
To: lvm-devel@sistina.com
Cc: Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [linux-lvm] Re: [lvm-devel] [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020131125211.A8934@fib011235813.fsnet.co.uk>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com>; from slpratt@us.ibm.com on Thu, Jan 31, 2002 at 01:52:29PM -0600
From: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:52:29PM -0600, Steve Pratt wrote:
> Joe Thornber wrote:
> >On Wed, Jan 30, 2002 at 10:03:40PM +0000, Jim McDonald wrote:
> >> Also, does/where does this fit in with EVMS?
> 
> >EVMS differs from us in that they seem to be trying to move the whole
> >application into the kernel,
> 
> No, not really.  We only put in the kernel the things that make sense to be
> in the kernel, discovery logic, ioctl support, I/O path.  All configuration
> is handled in user space.

There's still a *lot* of code in there; > 26,000 lines in fact.
Whereas device-mapper weighs in at ~2,600 lines.  This is just because
you've decided to take a different route from us, you may be proven to
be correct.

> > whereas we've taken the opposite route
> >and stripped down the kernel side to just provide services.
> 
> Then why does snapshot.c in device mapper have a read_metadata function
> which populates the exception table from on disk metadata?  Seems like you
> agree with us that having metadata knowledge in the kernel is a GOOD thing.

In the case of snapshots the exception data has to be written by the
kernel for performance reasons, as you know.  This is still a far cry
from understanding the LVM1 metadata format.

> Since device_mapper does not support in kernel discovery, and EVMS relies
> on this, it would be very difficult to change EVMS to use device_mapper.

So do the discovery on the EVMS side, and then pass the tables across
to device-mapper to activate the LV's.

> Why compete, come on over and help us :-)

I would like the two projects to help each other, but not to the point
where one group of people has to say 'you are completely right, we
will stop developing our project'.  It's unlikely that either of us is
100% correct; but I do think device-mapper splits off a nice chunk of
services that is useful to *all* people who want to do volume
management.  As such I see that as one area where we may eventually
work together.

Similarly I expect to be providing an *optional* kernel module for LVM
users who wish to do in kernel discovery of a root LV, so if the EVMS
team has managed to get a nice generic way of iterating block devices
etc.  into the kernel, we would be able to take advantage of that.
Are you trying to break out functionality so it benefits other Linux
projects ? or is EVMS just one monolithic application embedded in the
kernel ?

- Joe
