Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSKMR70>; Wed, 13 Nov 2002 12:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSKMR70>; Wed, 13 Nov 2002 12:59:26 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:52370 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S262224AbSKMR7Z>; Wed, 13 Nov 2002 12:59:25 -0500
Date: Wed, 13 Nov 2002 18:06:06 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.name>, Sean Neakums <sneakums@zork.net>,
       linux-kernel@vger.kernel.org
Subject: Re: hotplug (was devfs)
Message-ID: <20021113180606.F7989@axis.demon.co.uk>
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021112094949.GE17478@higherplane.net> <6uadkf9kdt.fsf@zork.zork.net> <200211121351.08328.oliver@neukum.name> <20021113104809.D2386@axis.demon.co.uk> <20021113170204.GC5446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113170204.GC5446@kroah.com>; from greg@kroah.com on Wed, Nov 13, 2002 at 09:02:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 09:02:04AM -0800, Greg KH wrote:
> On Wed, Nov 13, 2002 at 10:48:09AM +0000, Nick Craig-Wood wrote:
> > 
> > We fixed these problems by removing hotplug and loading the relevant
> > kernel modules in the correct order and voila a perfectly
> > deterministic order for the /dev/ttyUSBs with all devices initialised.
> 
> deterministic for you :)

Indeed!  It was deterministic in the sense of

1) I booted the machine 10 times and the devices came up in the same
order ;-)

2) the order of the devices was related to the usb topology, like this
(these are usb bus positions as noted by hub.c)

  1/1     <- hub1
  1/1/1   <- keyspan 1 /dev/ttyUSB0..3
  1/1/2   <- keyspan 2 /dev/ttyUSB4..7
  1/1/3   <- keyspan 3 /dev/ttyUSB8..11
  1/1/4   <- hub2
  1/1/4/1 <- keyspan 4 /dev/ttyUSB12..15
  1/1/4/2 <- keyspan 5 /dev/ttyUSB16..19
  1/1/4/3 <- keyspan 6 /dev/ttyUSB20..23

That seemed like a sensible order to me!

> What hotplug will do is allow you to assign a /dev entry to a specific
> device, so that you can go off of the topology, and not just the order
> in which the devices are found.  That is how this problem will be
> solved properly.

So I'll be able to say usb bus1/1/4/1 port 3 should be /dev/ttyUSB15
and it will always be that port?  That would be perfect.

> > Plugging in our USB bus with 24 devices on it does indeed produce a
> > mini-forkbomb effect ;-) (Especially since these Keyspan devices are
> > initialised twice - once without firmware and once with firmware.)
> > 
> > So - perhaps hotplug ought to be serialised?
> 
> No, it's not needed for this problem.  There has been talk of
> serializing stuff in userspace, which is the proper way to handle some
> of the remove before add was seen problems.

Userspace serialisation would have solved this problem for us too I
think without the extra mapping mechanism.

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
