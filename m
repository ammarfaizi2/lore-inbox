Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWISQbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWISQbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWISQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:31:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751859AbWISQbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:31:36 -0400
Date: Tue, 19 Sep 2006 09:31:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-rc7-mm1
Message-Id: <20060919093122.d8923263.akpm@osdl.org>
In-Reply-To: <45100272.505@mbligh.org>
References: <20060919012848.4482666d.akpm@osdl.org>
	<45100272.505@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 07:45:06 -0700
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> 
> > - It took maybe ten hours solid work to get this dogpile vaguely
> >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> >   I guess it's worth briefly testing if you're keen.
> 
> PPC64 blades shit themselves in a strange way. Possibly the udev
> breakage you mentioned? Hard to tell really if people are going to
> go around breaking userspace compatibility ;-(

What version of udev is it running?

> http://test.kernel.org/abat/48127/debug/console.log
> 
> ..
>
> sda: Write Protect is off
> sda: cache data unavailable
> sda: assuming drive cache: write through
> SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
> sda: Write Protect is off
> sda: cache data unavailable
> sda: assuming drive cache: write through
>   sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> sd 0:0:1:0: Attached scsi disk sda
> creating device nodes .[: [0-9]*: bad number
> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
> [: [0-9]*: bad number
> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
> [: [0-9]*: bad number
> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
> [: [0-9]*: bad number
> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
> [: [0-9]*: bad number
> 
>

That all looks rather bad.

> ReiserFS: sda2: Using r5 hash to sort names
> looking for init ...
> found /sbin/init
> /init: cannot open .//dev//console: no such file

Bizarrely-formed pathname.  Does it always do that?

> Kernel panic - not syncing: Attempted to kill init!
>   <0>Rebooting in 180 seconds..-- 0:conmux-control -- time-stamp -- 
> Sep/19/06  4:18:52 --
> (bot:conmon-payload) disconnected

Has udev actually attempted to do anything by this stage?

I wasn't seeing anything that spectacular.  It used to be the case that
udev simply hung.  But in rc7-mm1 the symptoms are that incoming ssh
sessions hang, but most other things work OK.

Oh well - Greg has split that tree apart and I shall not be pulling the
more problematic bits henceforth.
