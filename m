Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbSJCQ1e>; Thu, 3 Oct 2002 12:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJCQ1e>; Thu, 3 Oct 2002 12:27:34 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:43020 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261536AbSJCQ1d>;
	Thu, 3 Oct 2002 12:27:33 -0400
Date: Thu, 3 Oct 2002 09:30:19 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003163018.GC32588@kroah.com>
References: <20021003161320.GA32588@kroah.com> <Pine.GSO.4.21.0210031217430.15787-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210031217430.15787-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:21:13PM -0400, Alexander Viro wrote:
> On Thu, 3 Oct 2002, Greg KH wrote:
> > /sbin/hotplug already gets called for _every_ device that is added to
> > the system as of 2.5.40, so you should probably use that as your
> > userspace notifier event.  If there's anything that the /sbin/hotplug
> > call misses, that you need for evms, please let me know.
> 
> We need it
> 	a) early enough

Your initramfs patches will enable this to happen :)

> 	b) called for things like umem, etc. - random drivers built into
> the tree and exporting several block devices.

All devices that have a "struct device" (which should be about
everything these days, if not, please let me know), cause a
/sbin/hotplug event to happen.  This event says what type of device was
added or removed, and includes the location of the device in the
driverfs tree so that userspace can then determine what it wants to do
with this device.

I'm working on adding a call to /sbin/hotplug when classes are
registered with the kernel (like disk and other things that live in the
class driverfs tree).

Is this enough information to do what you need?

thanks,

greg k-h
