Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274160AbRI0X5T>; Thu, 27 Sep 2001 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274161AbRI0X5J>; Thu, 27 Sep 2001 19:57:09 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:16914 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S274160AbRI0X5D>; Thu, 27 Sep 2001 19:57:03 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81B0@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'Randy.Dunlap'" <rddunlap@osdlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: apm suspend broken in 2.4.10
Date: Thu, 27 Sep 2001 16:56:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy.Dunlap [mailto:rddunlap@osdlab.org]

> > -0xe1a
> {little-endian n[iy]bbles ?}

It's just the closest I can get to my own name in hex. ;)

> Sounds like our 2.4.10's are different then.  :)

It's possible... I got mine from kernel.org, applied the preemptible-kernel
and ext3fs patches, and  compiled with RH's "kgcc" 

> Without this patch, mine didn't create /proc/apm, register as a
> misc device, or create the kapmd-idle kernel thread.
> Must be a distro thingy.

Did you have apm=on set before, or nothing at all?  Here's what I've seen so
far:

In all cases, I've got apm compiled into the kernel, not a module.

- With 2.4.10, Before your patch, with no apm= option in the kernel command
line, APM in general works, but suspend doesn't.  When I append apm=on or
apm=off to my kernel command line, APM is disabled.
- With 2.4.10, After applying your patch, apm=on no longer disables APM, but
suspend still doesn't work.

> Return of EAGAIN from the SUSPEND ioctl means that
> send_event() failed, which means that some device driver
> didn't want suspend to happen...which means that some
> device driver got changed. :(

Just for fun, I tried removing all of my loaded 2.4.10 modules one by one,
and attempting 'apm --suspend' in between, and still had the same problem
when I got down to the bare minimum (ext3 and jbd)

> What was the last working kernel AFAUK (for this APM stuff)?

I just checked, and the RH-compiled 2.4.9-0.5 doesn't suspend either.  It
appears to suffer from the same "apm=on" command-line bug too.  I'm gonna go
try the 2.4.7 from RH's "Roswell" beta now.

-0xe1a
