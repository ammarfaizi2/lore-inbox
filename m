Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTDLIlC (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 04:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTDLIlC (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 04:41:02 -0400
Received: from fmr01.intel.com ([192.55.52.18]:21967 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263202AbTDLIlA convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 04:41:00 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB31@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Miquel van Smoorenburg'" <miquels@cistron-office.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 
	0.1 release)
Date: Sat, 12 Apr 2003 01:52:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Greg KH [mailto:greg@kroah.com]
> 
> On Fri, Apr 11, 2003 at 09:16:02PM -0700, Perez-Gonzalez, Inaky wrote:
> >
> > Okay, so what about this:
> >
> > I started playing with a simple event interface, that would allow:
> >
> > - queuing events and recalling-queued events
> > - not consume (almost) memory when two bazillion events are queued
> > - be accessible by different processes at the same time on
> >   different fds
> 
> Have you looked at relayfs?  I think it might do much the same thing as
> this, but through a fs interface, instead of a char device node.

Nope - I didn't even know it existed - this was just, hmmm, it could
be done like this, plank! There.. It's small and to me it cuts it
well enough.

The char device node is a quick place where to hook the struct 
file_operations. I'd say this would go inside sysfs or something. 
It is not really important.
 
> > Now, each fd keeps a pointer to the queue list and only when the
> > event has been read by all the open fds, it is then disposed.
> 
> I don't think you can just count the number of open fds, like your patch
> does to get a count of who all read this message (fds can close and
> others can open, so newer fds might not have read the message before it
> is removed.)

The intention is [unless I have screwed it up big time] that if there 
are no readers, the events are queued up. Once there is at least one
reader, then they are released as soon as they are read by all the
current readers. This way there is little chance for having a big accu-
mulation of unread events - once you start whatever event managing
daemon, you are set.

The idea of allowing multiple readers was so you can have other actors
listening for stuff - although the main one would always be the event
daemon (that could even forward the events).

> Looks like a good start, but I'm not moving the hotplug interface over
> to it :)

Good try - I won't let go :) If you see this as something potentially
useful, how would you like it to develop so that in the long term 
it can be used? be it in parallel with /sbin/hotplug or as a 
potential replacement?

I guess that the first thing I would have to do is somehow look into
how hotplug is behaving now and hook it to do something similar, right?

See ya

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
