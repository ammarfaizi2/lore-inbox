Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWCXM6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWCXM6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWCXM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:58:19 -0500
Received: from node-4024215a.mdw.onnet.us.uu.net ([64.36.33.90]:27384 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S1751176AbWCXM6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:58:19 -0500
Date: Fri, 24 Mar 2006 06:58:17 -0600
From: Brandon Low <lostlogic@lostlogicx.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324125817.GB3381@lostlogicx.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060324021729.GL27559@lostlogicx.com> <20060323182411.7f80b4a6.akpm@osdl.org> <20060324024540.GM27559@lostlogicx.com> <20060323185810.3bf2a4ce.akpm@osdl.org> <20060324032126.GN27559@lostlogicx.com> <20060324033934.161302c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324033934.161302c1.akpm@osdl.org>
X-Operating-System: Linux found 2.6.16-rc5-mm3
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03/24/06 at 03:39:34 -0800, Andrew Morton wrote:
> Brandon Low <lostlogic@lostlogicx.com> wrote:
> >
> >  I hadn't noticed immediately in the ooops, but it is something to do
> >  with the Hardware Abstraction Layer Daemon from http://freedesktop.org/Software/hal
> >  I can't reproduce it without that daemon loaded either.  I wonder if the
> >  last accessed sysfs file mentioned in the oops (sda/size) is relevent
> >  also.
> > 
> >  My exact steps (with hald loaded) are:
> >  plug in ipod
> >  mount /mnt/ipod
> >  unzip -d /mnt/ipod rockbox.zip
> >  eject /dev/sda
> >  unplug ipod
> >  immediately here, the oops prints.
> 
> Still no joy, alas.
> 
> git-cfq.patch plays with the elevator exit code for all IO schedulers. 
> Would you be able to do
> 
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/git-cfq.patch
> patch -p1 -R < git-cfq.patch
> 
> and retest?
> 
> Thanks.

It is definitely this patch.  Identical steps (also used an untainted
kernel for both tests) on -mm1 with and without that patch, and when the
patch is reversed, I cannot cause the oops.  I booted into single user
mode (to dodge tainting and any other weirdness), started the dbus
system message daemon and hald (which depends on dbus), then performed
the steps mentioned above.

Thanks!
