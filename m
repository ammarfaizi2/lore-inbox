Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUERAN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUERAN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUERAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:13:26 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:1699 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S262744AbUERANW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:13:22 -0400
Date: Tue, 18 May 2004 02:13:19 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
In-Reply-To: <20040517170433.0311c2e9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0405180208250.21480-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004, Andrew Morton wrote:

> "Robert M. Stockmann" <stock@stokkie.net> wrote:
> >
> > Be aware of other problems when using the linux ramdisk driver,
> > loosing its contents. Especially the use of mkinitrd might result in 
> > unexpected problems. googling for "kernel 2.6.6 ramdisk problem" shows lots
> > of people with problems mounting their root filesystems and loading modules
> > from ramdisk. Klaus Knopper (knoppix) is not amused, neither am i :)
> 
> Well in that case perhaps something else broke.  I've seen no such reports
> of recent regressions in the ramdisk driver.
> 
> The two problems of which I am aware are:
> 
> a) It loses its brains across umount.  Seems that it's very rare that
>    anyone actually cares about this, which is why it has not been fixed in
>    well over a year.
> 
> b) It loses data under heavy I/O loads.  I _think_ this has been
>    observed only on ppc64 and might be a cache writeback/invalidate thing.
> 
> If there are new post-2.6.5 problems then I'm all ears.

Well i think a problem has risen due to people allocating huge ramdisks with
sizes over 128Mb RAM. This is biting into the virtual memory management
system. For people using the ramdisk driver as a permanent runtime
root filesystem, maybe create a boot option : 

ramdisk=persistent	(or =solid or =sticky )

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

