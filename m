Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDKWmx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDKWmx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:42:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63361 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261999AbTDKWms (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:42:48 -0400
Date: Fri, 11 Apr 2003 15:53:56 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'oliver@neukum.name'" <oliver@neukum.name>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411225356.GC3786@kroah.com>
References: <20030411201029.GP1821@kroah.com> <A46BBDB345A7D5118EC90002A5072C780BEBAAAD@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAAAD@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:27:19PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> 
> > From: Greg KH [mailto:greg@kroah.com]
> >
> > But I can do a lot to prevent losses.  A lot of people around here point
> > to the old way PTX used to regenerate the device naming database on the
> > fly.  We could do that by periodically scanning sysfs to make sure we
> > are keeping /dev in sync with what the system has physically present.
> > That's one way, I'm sure there are others.
> 
> This might be a tad over-simplification, but sysfs knows by heart when
> anything is modified, because it goes through it's interface. If we
> only care about, for example, devices, we could hook up into
> device_create() [was this the name?]; line up in a queue all the
> devices for which an plug/unplug event hasn't been delivered to user
> space and create symlinks in /sysfs/hotplug-events/. 
> 
> Each entry in there is a symlink to the new device directory, named with an 
> increasing integer for easy serialization. When the event is fully
> processed, remove the entry from user space.

Um, how do you show a symlink to a device that is no long there when the
device is removed?  :)

It would also require that users can delete files from sysfs, which
isn't currently possible.  Special casing one directory for this would
be a pain.

In the end, it's a nice idea, but the current one is much simpler, and
works today :)

thanks,

greg k-h
