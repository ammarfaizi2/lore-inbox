Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSAGUPU>; Mon, 7 Jan 2002 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286215AbSAGUPL>; Mon, 7 Jan 2002 15:15:11 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:28914 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286198AbSAGUPE>; Mon, 7 Jan 2002 15:15:04 -0500
Date: Mon, 07 Jan 2002 12:13:21 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Message-id: <000701c197b7$c21a5700$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, you wrote:

> > And the /sbin/hotplug program knows about _all_ devices that the
> > currently compiled kernel can handle due to the MODULE_DEVICE_TABLE
> > tags in the drivers.
>
> Along these lines, I am very disappointed in looking at the
> autoconfigure stuff in CML2.  It should be taking all of the device and
> driver matching information from the kernel itself, as it is already
> specified there.

I sent related comments to Eric last April:

> > One thing I noticed is that there's important information in the build
> > system that's discarded after a build.  That "metadata" can be handy
> > for lots of purposes.   Hotplugging drivers (including configuring them
> > after they're loaded) is one application.

So far as I can tell, nobody's trying to do much with that metadata.
Maybe in part because it's not easily accessible.  But that's exactly
something I'd expect the 2.5 build/configure system to start fixing.

MODULE_DEVICE_TABLE support is actually a good example.

Its format isn't quite tool-friendly, but the real issue is that such data
is only available _after_ a build!  In this case it's needed before
config.  And if viewed as metadata, it's also incomplete:

    - Drivers omitted from the current config are not listed.
    - It's discarded for statically linked drivers (affects hotplug)
    - Doesn't say what CONFIG_ flag corresponds to each driver
    - No driver-to-docs linkage
    - ...

For anyone configuring a kernel who's not already an expert (we're
not talking Aunt Tillie ... most technical folk shouldn't be kernel experts),
that information can be important.

(One example:  driver docs.  I did some XSLT hacks a while
back, available off the linux-hotplug "links" page.  They do a better
job for USB than PCI.  Sample output (very old now :) is at

http://linux-hotplug.sourceforge.net/kernel/kernel.html

The early text is boilerplate explanation, but sections 3 and 4 are
generated automagically from modutils output, as driven by the
MODULE_DEVICE_TABLE info.  I think such info should be far
more accessible than it is.)


> Eric, if you are going to keep your "2000+" configuration probes up to
> date by hand, good luck.  Look at all of the new USB drivers that have
> been added in just the 2.5.2-pre series alone.  That's a lot of data to
> keep track of.
>
> The rest of us have decided to rely on automatic tools for this process :)

Absolutely!  What I think is needed in this case is automatic tools to
generate such stuff from kernel sources, without needing to build the
whole thing.  Run once before "configure me a kernel", to build the
driver database.

And, maybe more in the "I have a dream ..." category, take this rare
opportunity (2.5 cycle reworking build/config) to take a look at the
forest rather than the trees.  Useful tools and documents will come
from making this metadata more generally accessible.

- Dave


