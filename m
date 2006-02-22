Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWBVTZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWBVTZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWBVTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:25:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751407AbWBVTZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:25:53 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: David Zeuthen <david@fubar.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kay Sievers <kay.sievers@suse.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org>
	 <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	 <20060222152743.GA22281@vrfy.org>
	 <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
	 <1140625103.21517.18.camel@daxter.boston.redhat.com>
	 <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 14:25:06 -0500
Message-Id: <1140636306.2460.41.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(agreeing with you on lots of counts so cutting to the chase)

On Wed, 2006-02-22 at 09:08 -0800, Linus Torvalds wrote:
> THIS IS WHY WE MUST MAKE THE KERNEL INTERFACES STABLE!

You really need to sit down and define what you mean by stable then. For
example the syscall interface is somewhat well defined.

This is how the world looks like today from a consumer of sysfs with
little or no kernel programming experience. Just a few examples:

 1. There is little or no documentation sans kernel sources for
    the meaning nor range of the values of sysfs files. You have to
    lookup the kernel source... Maybe it would be useful to have
    some kind of auto-documentation feature that _forces_ kernel
    developers to provide docs along with the sysfs files..
    Then I would have

     /sys/block/hda/removable

    and 

     /sys/block/hda/docs_removable

    Of course make this an optional feature. Noteworthy this is how
    gconf in GNOME works.. sure, now I get flamed for bloat and, sure,
    this may be a stupid idea... Mostly I'm just trying to outline
    the problem here...

 2. Some of the interesting information we want isn't actually
    available even though the kernel has it already (can we please
    get an event when the kernel has finished scanning for partitions
    for example?). We're pretty fine getting some high-level information
    ourselves, like probing for file system for example.. but some
    things we can't really get at.. 

 3. User space needs to reorder hotplug events; that's fine but we get
    to play a lot of tricks because there are races everywhere (look at
    some of the udev rules for working around this).. I'm not sure how
    this is fixable...

 4. Back in 2.6.9 or 2.6.10 someone yanked the SCSI targets into the
    sysfs chain and that did break HAL. Depending on who you ask this
    is acceptable, other people says it's ABI breakage. Again, need to
    define what's stable means; I don't think it's good enough to just
    wait until it happens and then let yourself or some other high-level
    person decide whether a change is acceptable or not. We need
    predictability.

All these things.. what sysfs files to expect.. proper documentation..
what values a sysfs file can assume.. is, to me at least, all part of an
"interface"... an ABI.

The root problem, I think, here is really the lack of communication
between kernel developers and user space people. It's not like HAL is
closed source nor a lot of code. 

I believe that the problems we have in HAL are very fixable but the
thing is that with the "documentation" and "stability guarantees" that
the kernel today gives us... you pretty much have to be a kernel
developer to figure when or if some sysfs file can assume a new value..
or that there's a better sysfs file to check that this or that one...
Sorry, but I'd rather spend my time making the desktop bits use HAL to
implement a nice user-visible feature... than spending time figuring out
the exact semantics of some arcane file in sysfs. 

At this point I would welcome any kernel developer to help review the
HAL code and send patches for stupid assumptions made in HAL. I would
really appreciate it. I'm not kidding. Thanks.

    David


