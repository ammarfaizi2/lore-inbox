Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUAPOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAPOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:46:09 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:3712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265298AbUAPOqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:46:03 -0500
Date: Fri, 16 Jan 2004 15:45:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kgdb-bugreport@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116144537.GD2535@elf.ucw.cz>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116125806.GA7409@elf.ucw.cz> <200401161947.11259.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161947.11259.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > KGDB 2.0.3 is available at
> > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> > >
> > > Ethernet interface still doesn't work. It responds to gdb for a couple of
> > > packets and then panics. gdb log for ethernet interface is pasted
> > > below.
> >
> > ++int kgdbeth_thread(void *data)
> > ++{
> > ++      struct net_device *ndev = (struct net_device *)data;
> > ++      daemonize("kgdbeth");
> > ++      while (!ndev->ip_ptr) {
> > ++              schedule();
> > ++      }
> > ++      debugger_entry();
> > ++      return 0;
> >
> > Don't you need some locking around ndev->ip_ptr? [Okay, it probably
> > only matters on SMP, so it is not causing your problems..]
> 
> Yes. Some locking will be needed. I haven't yet figured out the exact sequence 
> of function calls during configuration of an interface from userland.
> 
> Is there a hold-count kind of a thing on network interface components (like 
> inodes, dentries)?
> 
> I am still using userland to bring an interface up. I guess it's best done 
> inside the kernel instead of using notifications and spawning a thread. Then 
> the interface would be usable much earlier.

So.. if it works, I'll ifconfig eth0 up, it will print "waiting for
kgdb to connect", I'll connect with gdb, and it will work?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
