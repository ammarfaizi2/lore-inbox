Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbTIKU2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbTIKU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:28:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:18141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261505AbTIKU2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:28:31 -0400
Date: Thu, 11 Sep 2003 13:28:48 -0700
From: Greg KH <greg@kroah.com>
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
Message-ID: <20030911202848.GA14031@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com> <20030910154608.14ad0ac8.akpm@osdl.org> <1063239544.1328.22.camel@ranjeet-pc2.zultys.com> <20030911002404.GA7178@kroah.com> <1063240611.1327.37.camel@ranjeet-pc2.zultys.com> <20030911024054.GA7566@kroah.com> <1063311985.1328.101.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063311985.1328.101.camel@ranjeet-pc2.zultys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 01:26:26PM -0700, Ranjeet Shetye wrote:
> On Wed, 2003-09-10 at 19:40, Greg KH wrote:
> > On Wed, Sep 10, 2003 at 05:36:51PM -0700, Ranjeet Shetye wrote:
> > > On Wed, 2003-09-10 at 17:24, Greg KH wrote:
> > > > On Wed, Sep 10, 2003 at 05:19:05PM -0700, Ranjeet Shetye wrote:
> > > > > 
> > > > > Your changes fixed the issue. Thanks a lot for your help. I still get
> > > > > this call trace, but no more OOPS on bootup.
> > > > > 
> > > > > kobject_register failed for Ensoniq AudioPCI (-17)
> > > > > Call Trace:
> > > > >  [<c026f45c>] kobject_register+0x50/0x59
> > > > >  [<c02f8003>] bus_add_driver+0x4c/0xaf
> > > > >  [<c02f8453>] driver_register+0x31/0x35
> > > > >  [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
> > > > >  [<c027c491>] pci_register_driver+0x5e/0x83
> > > > >  [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
> > > > >  [<c068475a>] do_initcalls+0x2a/0x97
> > > > >  [<c012e920>] init_workqueues+0x12/0x2a
> > > > >  [<c01050a3>] init+0x39/0x196
> > > > >  [<c010506a>] init+0x0/0x196
> > > > >  [<c0108f31>] kernel_thread_helper+0x5/0xb
> > > > 
> > > > Odds are that the pci driver is trying to register 2 drivers with the
> > > > pci core with the same name.  What does /sys/bus/pci/drivers show?
> > > 
> > > I didn't find a /proc/sys/bus/pci/drivers, but I did find a
> > > /proc/bus/pci/devices - which is what I am guessing you meant. If you
> > > did in fact mean '/proc/sys/bus/pci/drivers' then I dont have any such
> > > file. In fact I dont have a bus sub-directory under /proc/sys/
> > 
> > No, look at what I asked for above, "/sys/bus/pci..."  I don't care about
> > /proc at all :)
> > 
> > sysfs is mounted at /sys.
> 
> Actually I don't know what part I am missing, but I dont have a /sys
> directory at all. That's why I assumed you might be referring to
> /proc/sys. I've attached my .config. Is there some option I need to turn
> on ? I looked and couldn't find it. (The fs/Makefile has a obj-y for
> sysfs and there is no CONFIG_ parameter in any file in fs/sysfs). I dont
> have a top level /sys directory. Is that the problem ? How do i get my
> sysfs running ?

mkdir /sys
mount -t sysfs none /sys

thanks,

greg k-h
