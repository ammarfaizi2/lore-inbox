Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTDKWsC (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbTDKWsC (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:48:02 -0400
Received: from fmr04.intel.com ([143.183.121.6]:23501 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262198AbTDKWr7 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:47:59 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAAC4@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'oliver@neukum.name'" <oliver@neukum.name>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 15:59:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH [mailto:greg@kroah.com]


> > > From: Greg KH [mailto:greg@kroah.com]
> > >
> > > But I can do a lot to prevent losses.  A lot of people around here
point
> > > to the old way PTX used to regenerate the device naming database on
the
> > > fly.  We could do that by periodically scanning sysfs to make sure we
> > > are keeping /dev in sync with what the system has physically present.
> > > That's one way, I'm sure there are others.
> >
> > This might be a tad over-simplification, but sysfs knows by heart when
> > anything is modified, because it goes through it's interface. If we
> > only care about, for example, devices, we could hook up into
> > device_create() [was this the name?]; line up in a queue all the
> > devices for which an plug/unplug event hasn't been delivered to user
> > space and create symlinks in /sysfs/hotplug-events/.
> >
> > Each entry in there is a symlink to the new device directory, named with
an
> > increasing integer for easy serialization. When the event is fully
> > processed, remove the entry from user space.
> 
> Um, how do you show a symlink to a device that is no long there when the
> device is removed?  :)

Broken link - removal event [my fault, should have explained];
still, this is kind of broken because of what you mention in
the next paragraph and because it limits you to just two types
of events - addition and removal.

I like better the having of a file where you can get events
from (that at the end goes with the select() thingie).

> In the end, it's a nice idea, but the current one is much simpler, and
> works today :)

Sure - let's just not forget it and build on top of it little
by little.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
