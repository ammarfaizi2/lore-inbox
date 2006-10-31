Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWJaICZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWJaICZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422913AbWJaICZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:02:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:12485 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422804AbWJaICX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:02:23 -0500
Date: Tue, 31 Oct 2006 00:01:32 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-ID: <20061031080132.GA9155@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030191340.1c7f8620.akpm@osdl.org> <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030211046.1c3d62b9.akpm@osdl.org> <20061031070351.GB14713@kroah.com> <20061030233432.d75955c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233432.d75955c5.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 11:34:32PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 23:03:51 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Mon, Oct 30, 2006 at 09:10:46PM -0800, Andrew Morton wrote:
> > > On Mon, 30 Oct 2006 22:58:11 -0500
> > > Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> > > 
> > > > > 
> > > > > hm.  Please send the .config
> > > > > 
> > > > Sure.
> > > > 
> > > > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > > > crash go away. I can hack around the resulting udev incompatibility.
> > > > 
> > > > #
> > > > # Automatically generated make config: don't edit
> > > > # Linux kernel version: 2.6.19-rc3-mm1
> > > > # Mon Oct 30 19:31:03 2006
> > > 
> > > Well I tried to reproduce this, but I got such a psychedelic cornucopia of
> > > oopses at various bisection points amongst those sysfs patches that I think
> > > I'll just give up.
> > > 
> > > Greg, Kay: it's quite ugly.  I'll drop all those patches for now, and I
> > > suggest you do so too.  Have a play with the .config which Andrew sent..
> > 
> > No, please don't drop them.  We have tested these out on a lot of
> > different boxes.  So far everyone's problems have either been due to
> > something else in -mm (acpi patches), or because they did not read the
> > CONFIG_SYSFS_DEPRECATED Kconfig help text.
> 
> Does acpi cause the change_page_attr oopses?
> 
> What caused the several different oopses which I got with Andrew's config? 
> They were all inside the gregkh-driver-* series.  (That test machine is
> running FC1, which doesn't run udev at all.  Its BIOS is acpi-free).
> 
> Here's one: http://userweb.kernel.org/~akpm/s5000364.jpg

That function (snd_register_device_for_dev), isn't even in 2.6.19-rc3,
so I don't see how any of my changes could have affected it :)

> I didn't grab the others.
> 
> > I have yet to see any real problems with these patches, except for your
> > build issue with the bonding drivers, which I'm fixing up right now.
> 
> Tried Andrew's .config?

I will do so in the morning...

time for sleep,

greg k-h
