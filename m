Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSJCRDs>; Thu, 3 Oct 2002 13:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSJCRDs>; Thu, 3 Oct 2002 13:03:48 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:17366 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S261749AbSJCRDq>; Thu, 3 Oct 2002 13:03:46 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Greg KH <greg@kroah.com>
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net,
       torvalds@transmeta.com
Date: Thu, 3 Oct 2002 10:00:29 -0700 (PDT)
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <20021003163018.GC32588@kroah.com>
Message-ID: <Pine.LNX.4.44.0210030953130.30836-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, please note that while there are people planning to change the
kernel to require an initramfs to boot on any machine, there are a number
of people who disagree with this approach, since the initramfs changes to
make it possible to be mandatory are not in the kernel yet (let alone the
flame war^H^H^H^H^H^H^H^H^Hdiscussion that will take place before
initramfs is made mandatory) you can't tell Kevin to build his code in
such a way that it only works if you have it.

once initramfs is to the point where it can be made mandatory, then if
Linus states that he wants to mandate drivers as modules useing initramfs,
then you can tell new drivers they can't be compiled in and can depend on
userspace tools like /sbin/hotplug.

given that we had a patch a week or so ago to change how modules get
loaded into memory to avoid a 'several percentage point' speed difference
between modules and built-in and that the people pushing 'do everything in
initramfs' have been saying for years that there is no performance
difference I for one am not convinced that mandating initramfs is a good
thing.

David Lang


 On Thu, 3 Oct 2002, Greg KH wrote:

> Date: Thu, 3 Oct 2002 09:30:19 -0700
> From: Greg KH <greg@kroah.com>
> To: Alexander Viro <viro@math.psu.edu>
> Cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
>      evms-devel@lists.sourceforge.net, torvalds@transmeta.com
> Subject: Re: EVMS Submission for 2.5
>
> On Thu, Oct 03, 2002 at 12:21:13PM -0400, Alexander Viro wrote:
> > On Thu, 3 Oct 2002, Greg KH wrote:
> > > /sbin/hotplug already gets called for _every_ device that is added to
> > > the system as of 2.5.40, so you should probably use that as your
> > > userspace notifier event.  If there's anything that the /sbin/hotplug
> > > call misses, that you need for evms, please let me know.
> >
> > We need it
> > 	a) early enough
>
> Your initramfs patches will enable this to happen :)
>
> > 	b) called for things like umem, etc. - random drivers built into
> > the tree and exporting several block devices.
>
> All devices that have a "struct device" (which should be about
> everything these days, if not, please let me know), cause a
> /sbin/hotplug event to happen.  This event says what type of device was
> added or removed, and includes the location of the device in the
> driverfs tree so that userspace can then determine what it wants to do
> with this device.
>
> I'm working on adding a call to /sbin/hotplug when classes are
> registered with the kernel (like disk and other things that live in the
> class driverfs tree).
>
> Is this enough information to do what you need?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
