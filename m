Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTDLHZl (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTDLHZl (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:25:41 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1408 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263182AbTDLHZk (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 03:25:40 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304120739.h3C7drk6000368@81-2-122-30.bradfords.org.uk>
Subject: Re: [ANNOUNCE] udev 0.1 release
To: greg@kroah.com (Greg KH)
Date: Sat, 12 Apr 2003 08:39:53 +0100 (BST)
Cc: arnd@arndb.de (Arnd Bergmann), linux-kernel@vger.kernel.org
In-Reply-To: <20030411215755.GX1821@kroah.com> from "Greg KH" at Apr 11, 2003 02:57:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - Someone accidentally removes the cable that connects a few hundred 
> >   (mounted) disks
> > - The cable is replaced, but - oops - to the wrong socket
> > - The person notices the error and now places the cable into the right
> >   socket.
> > 
> > At this time we have four concurrent hotplug events for every single
> > disks that we want to be finished in order and we want every disk
> > to end up with its original minor number in the end. If this is not
> > possible, the system still needs to be in a sensible state after this.
> 
> No, you want to make sure you have the same "name" after that.  As any
> userspace apps that had a open file on the original disks are basically
> screwed anyway, we want a way to enable them to recover nicely.

Another scenario would be if a hotpluggable disk interface failed.
Someone could purposely move the cable to a second adaptor, before
replacing the failed one.  Relevant userspace apps could be suspended
during this switch over, but when they are resumed, it would be
desirable to have the disks with the same minor numbers as before,
thereby simplifying the userspace application's requirements.

> And no, I don't want to go into the whole, remove a device and plug it
> back in, and userspace never noticed the difference while it held an
> open file handle.  That's a problem I don't want to even go near right
> now, and is totally different from what udev is trying to do :)

It's also arguably better done in userspace.  The kernel would see the
device disappear and re-appear, but a userspace abstraction layer
could identify it as being the same device, (and unmodified since it
last saw it), and act accordingly.

Effectively, reads from an unconnected device would succeed if the
data was cached, and writes would succeed at least until a certain
amount of write cache had been filled.  The result of disconnecting a
device, modifying it's contents, then re-connecting it would be
undefined.

John.
