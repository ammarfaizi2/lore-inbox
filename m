Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUAPOSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265513AbUAPOSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:18:15 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:32403 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265505AbUAPORw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:17:52 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 19:47:10 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116125806.GA7409@elf.ucw.cz>
In-Reply-To: <20040116125806.GA7409@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401161947.11259.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 6:28 pm, Pavel Machek wrote:
> Hi!
>
> > KGDB 2.0.3 is available at
> > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> >
> > Ethernet interface still doesn't work. It responds to gdb for a couple of
> > packets and then panics. gdb log for ethernet interface is pasted
> > below.
>
> ++int kgdbeth_thread(void *data)
> ++{
> ++      struct net_device *ndev = (struct net_device *)data;
> ++      daemonize("kgdbeth");
> ++      while (!ndev->ip_ptr) {
> ++              schedule();
> ++      }
> ++      debugger_entry();
> ++      return 0;
>
> Don't you need some locking around ndev->ip_ptr? [Okay, it probably
> only matters on SMP, so it is not causing your problems..]

Yes. Some locking will be needed. I haven't yet figured out the exact sequence 
of function calls during configuration of an interface from userland.

Is there a hold-count kind of a thing on network interface components (like 
inodes, dentries)?

I am still using userland to bring an interface up. I guess it's best done 
inside the kernel instead of using notifications and spawning a thread. Then 
the interface would be usable much earlier.

Thanks.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

