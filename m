Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263835AbSIUFoD>; Sat, 21 Sep 2002 01:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbSIUFoD>; Sat, 21 Sep 2002 01:44:03 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:51981 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263835AbSIUFoC>;
	Sat, 21 Sep 2002 01:44:02 -0400
Date: Fri, 20 Sep 2002 22:48:40 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Message-ID: <20020921054840.GD26558@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com> <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com> <3D8B884A.7030205@pacbell.net> <20020920231112.GC24813@kroah.com> <3D8BDF9A.305@pacbell.net> <20020921033137.GA26017@kroah.com> <3D8BEE51.1020304@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8BEE51.1020304@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 08:58:09PM -0700, David Brownell wrote:
> Greg KH wrote:
> >On Fri, Sep 20, 2002 at 07:55:22PM -0700, David Brownell wrote:
> >
> >>How about a facility to create the character (or block?) special file
> >>node right there in the driverfs directory?  Optional of course.
> >
> >
> >No, Linus has stated that this is not ok to do.  See the lkml archives
> >for the whole discussion about this.
> 
> I suspected that'd be the case.  Some pointer into the archives
> would be good, though I'd suspect the basic summary is that it'd
> be too much like devfs that way.  Did the same statement apply to
> adding some file that wasn't a device special file?  That kind
> of solution moves in the "no majors/minors" direction, which I
> thought was the general goal.  Leaves a naming policy debate,
> but one that ought to be more managable (say, with devlabel).

All naming policies are moving to userspace.  It will not be a kernel
issue.

> Though I guess my original reaction still stands then:  I don't
> much want to care about major/minor numbers, so why not just leave
> them out in favor of whatever better solution is the goal?  Save
> everyone the intermediate steps!

No, we need the major/minor number to be in driverfs.  That way the
userspace program (that's running the naming policy) can look at
driverfs to see what devices are present, what the major/minor number of
the device is, what type of device it is, and then create the /dev node
for the device, based on that information.

We are slowly getting there, and I don't see any intermediate steps
along the way (meaning ones that get ripped out later.)

thanks,

greg k-h
