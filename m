Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUAHBu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUAHBu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:50:28 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:938 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263475AbUAHBuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:50:22 -0500
Date: Wed, 07 Jan 2004 17:50:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20490000.1073526617@[10.10.2.4]>
In-Reply-To: <20040108011538.GA4002@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com> <14870000.1073521945@[10.10.2.4]> <20040108004124.GA3388@kroah.com> <16970000.1073524052@[10.10.2.4]> <20040108011538.GA4002@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is the following:
> 	- user plugs in their usb flash reader with no media in it
> 	- the main block device is create, no partitions
> 	- user plugs a flash stick/whatever into the reader
> 	- kernel gets no notification of this event
> 	- userspace gets no notification of this event

You can solve the partitions bit by rescanning when someone opens
the "/dev/hdaX" directory, was my only point. Which was just a little
twist on Linus's thing, only a bit simpler. And no, it doesn't work
unless that dir is a virtual thing that's "magic".
 
> How can userspace know to open the main block device now?  Require that
> we put a big "Rescan media now" button on the desktop?  That's one way,
> but users are used to having to not do that.  

I don't think you should have to press something explicit for the udev
stuff to be correct. But you should to start an application that does
pretty stuff with pictures, like you mention below.

> If a daemon does the scanning every so often, the media can be

As Linus pointed out ... "every so often" has to be horribly frequent, so
I don't see how that can work. How often are you proposing? once a second?

> automatically mounted, and an application can pop up saying that it
> found some pictures on the new device, do you want to open up your image
> application?

Ick. You mean like the Windows crap than autoruns stuff off your CD?
If you really, really want that, then yes you'd have to poll, but it
would be nice to solve the partitions bit without that, IMHO. I'd
see a lot more demand for the partitions being correctly populated
than magically triggered GUI stuff.

M.
