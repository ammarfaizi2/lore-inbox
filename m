Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWGALws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWGALws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGALws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:52:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964861AbWGALwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:52:47 -0400
Date: Sat, 1 Jul 2006 04:52:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com
Subject: Re: 2.6.17-mm4 raid bugs & traces
Message-Id: <20060701045219.85d7d2b9.akpm@osdl.org>
In-Reply-To: <20060701111153.GA10855@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<20060701111153.GA10855@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006 13:11:53 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> Raid-1 is not well in mm4.  Now, my raid devices may
> have some problems after running mm2, because mm2 tends to
> trip up on shutdown, which might cause linux to come up again
> with some failed mirrors. That shouldn't cause mm4 to go BUG
> and spit call traces though.
> 
> When I boot up mm4, dmesg tells me this:
> 
> [...]
> SCTP: Hash tables configured (established 16384 bind 16384)
> powernow-k8: Found 1 AMD Opteron(tm) Processor 244 processors (version 2.00.00)
> powernow-k8: BIOS error - no PSB or ACPI _PSS objects
> BIOS EDD facility v0.16 2004-Jun-25, 4 devices found
> Freeing unused kernel memory: 272k freed
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: considering sde2 ...
> md:  adding sde2 ...
> md:  adding sdd2 ...
> md: sdc1 has different UUID to sde2
> md: sdb5 has different UUID to sde2
> md: sdb1 has different UUID to sde2
> md: sda5 has different UUID to sde2
> md: sda2 has different UUID to sde2
> md: created md2
> md: bind<sdd2>
> md: bind<sde2>
> md: running: <sde2><sdd2>
> md: kicking non-fresh sdd2 from array!
> md: unbind<sdd2>
> md: export_rdev(sdd2)

Yes, Reuben is hitting things like that too.

> BUG: warning at fs/block_dev.c:1109/__blkdev_put()

A flakey lockdep conversion.  -mm5 allegedly fixes this.

