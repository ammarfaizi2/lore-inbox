Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJCRZG>; Thu, 3 Oct 2002 13:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJCRZF>; Thu, 3 Oct 2002 13:25:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:54540 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261294AbSJCRYw>;
	Thu, 3 Oct 2002 13:24:52 -0400
Date: Thu, 3 Oct 2002 10:27:28 -0700
From: Greg KH <greg@kroah.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net,
       torvalds@transmeta.com
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003172728.GD403@kroah.com>
References: <20021003163018.GC32588@kroah.com> <Pine.LNX.4.44.0210030953130.30836-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210030953130.30836-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:00:29AM -0700, David Lang wrote:
> Greg, please note that while there are people planning to change the
> kernel to require an initramfs to boot on any machine, there are a number
> of people who disagree with this approach, since the initramfs changes to
> make it possible to be mandatory are not in the kernel yet (let alone the
> flame war^H^H^H^H^H^H^H^H^Hdiscussion that will take place before
> initramfs is made mandatory) you can't tell Kevin to build his code in
> such a way that it only works if you have it.
> 
> once initramfs is to the point where it can be made mandatory, then if
> Linus states that he wants to mandate drivers as modules useing initramfs,
> then you can tell new drivers they can't be compiled in and can depend on
> userspace tools like /sbin/hotplug.

Hm, I think you're a bit confused here.

/sbin/hotplug has nothing to do with modules.  It works just fine with a
kernel with everything built in.  /sin/hotplug is getting called when
anything in the system changes, like a device is discovered or removed.

Now the fact that the current hotplug package that implements a version
of /sbin/hotplug only really handles loading new modules for devices
that do not currently have drivers bound to them, is only an
implementation detail.  The hotplug package will start to change soon,
based on the new information that is being spit out by your kernel.

> given that we had a patch a week or so ago to change how modules get
> loaded into memory to avoid a 'several percentage point' speed difference
> between modules and built-in and that the people pushing 'do everything in
> initramfs' have been saying for years that there is no performance
> difference I for one am not convinced that mandating initramfs is a good
> thing.

initramfs and "everything must be a module" are two different
discussions.  Only after the first happens can we even start talking
about the second.

And even if we don't ever agree that everything has to be a module, the
initramfs implementation moves a whole lot of crap out of kernel space,
and into userspace, that I can't see any good reason not to have it.

But let's wait for Al's latest initramfs patches to start talking about
that topic, I thought this thread was about evms :)

thanks,

greg k-h
