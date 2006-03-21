Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWCUPhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWCUPhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCUPhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:37:41 -0500
Received: from vidur.ministry.se ([62.95.69.217]:46016 "EHLO vidur.ministry.se")
	by vger.kernel.org with ESMTP id S1751786AbWCUPhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:37:40 -0500
Date: Tue, 21 Mar 2006 16:21:57 +0100 (MET)
From: kernel@ministry.se
X-X-Sender: fwadmin@celeborn.ministry.se
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jesper Juhl <jesper.juhl@gmail.com>, <Valdis.Kletnieks@vt.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel cache mem bug(?)
In-Reply-To: <1142861478.20050.27.camel@localhost.localdomain>
Message-ID: <Pine.GHP.4.44.0603211545470.18694-100000@celeborn.ministry.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The RAM is 100% OK, both according to the initial BIOS memory check and
> > memtest86 running for more than four (4) hours straight.
> >
> > One more thing that we just noticed: it seems the cache corruption (or
> > whatever it is)  only occurs when X is running.
>
> X is special in a couple of ways - it accesses hardware directly and it
> uses AGP. See if setting the NoAccel X option makes any difference to
> the failures - it'll make your desktop slower but should help validate X
> is the problem. If that does help then try disabling DRI (3D) support if
> your box has it, and see what that does. If it works with noaccel and
> fails with DRI then finally try with no AGP support built into your
> kernel.  That should identify the problem as X, DRI, AGP or other.

I gave it a try, running the same reboot & test script for every change:

  X with "noaccel"         - no change (i.e. corruption still occur)
  X w/o kernel fb support  - no change
  X without "dri"          - no change
  w/o AGP support in kernel  - no change
  X without "fgl"          - no change
  X without "glx"          - no change
  X without "fglrx"        - no change (ATI:s driver, used vesa instead)
  X without "dbe"          - no change
  X with only 1 screen     - no change
  X w/o Dev PCI:1...       - no change
  X without "dri"          - no change
  w/o kernel DRM support   - no change
  w/PCI acess=direct       - no change
  w/o kernel SMP HT support - no change

  and finally...

  w/o kernel SMP support   - 100% ok!

  (No corruption at all after 12 x 100 x 35 x 20 megabyte writing and
   reading to ram cache)

I.e, the only thing that seem to fix this is by removing SMP (and by
doing that also HT) support :(

The processor is an Intel P4 3.4GHz w/1MB L2 cache
The graphics card is an ATI X800 using the PCI Express slot
(see my first post for more detailed info).

Perhaps worth noting: when doing repeated md5sum runs on the cached files
and discrepancies are found, it is "always" different files. I.e., the
same file will never show a bad checksum twice. A subsequent run will show
a good checksum for a file which just seconds ago had a bad one.

Of course no other programs were accessing the files during these tests.

Even though disabling kernel SMP support entirely will make this problem
go away, I seriously do not like that kind of workarounds...

Please let me know if there is more system/hardware information I could
provide to help sort this out.

Regards,
//D

