Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTE3INp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTE3INp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:13:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:30091 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263407AbTE3INn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:13:43 -0400
Date: Fri, 30 May 2003 01:27:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: 2.5.70-mm2
Message-Id: <20030530012710.57cca756.akpm@digeo.com>
In-Reply-To: <3ED70B9A.5050104@freemail.hu>
References: <3ED70B9A.5050104@freemail.hu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 08:27:02.0323 (UTC) FILETIME=[3ED61830:01C32685]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>
> Hi,
> 
> I am testing it now with your two extra patches.
> I started vmware but I don't notice it now. Everything is snappy.
> The system is a RH9 with upgrades. The latest errata kernel still
> stops for seconds sometimes and vmware (and rsync between two drives
> for that matter) makes a noticable performance impact. With .70-mm2,
> I can still work on other things and not wait for other things to
> finish first.

OK, thanks.

> However there are problems: Basically, the autoload fails.
> My eth0/eth1 (both use 8139too) are down.
> The iptables modules do not load so the iptables service is failing.
> When I modprobe the needed modules, the things start working.

Make sure that you've correctly enabled the "Kernel Module Loader" in the
"Loadable Mudule Support" menu.

And read the readme file in mudule-init-tools carefully.  You need to build
the /etc/modprobe.conf file with all the aliases in it.  It takes a bit of
fiddling, but demand-modloading does work.

> E.g. named can be started after I modprobe capabilities. I brought up
> named for example because the kernel logs messages for this one:
> 
> process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
> process `named' is using obsolete setsockopt SO_BSDCOMPAT

That's OK.  It's just the kernel spamming the application developers ;)

> The modutils I use is from the latest rawhide (contains module-init-tools).
> 
> And an interesting issue: rpm -q fails for root, works for users.
> 
> # LANG=C rpm -q modutils
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> package modutils is not installed
> $ rpm -q modutils
> modutils-2.4.25-2

This is a bug in rpm.  It can be worked around with:

	alias rpm='LD_ASSUME_KERNEL=2.2.5 rpm'

> 
> Also, I have an old parallel port ZIP drive, and ppa.c does not compile:
> 
> drivers/scsi/ppa.c: In function `ppa_proc_info':
> drivers/scsi/ppa.c:280: invalid operands to binary ==
> make[2]: *** [drivers/scsi/ppa.o] Error 1
> 
> The line compares a struct ppa_struct* with a struct Scsi_Host *.
> 

Christoph should be able to fix that one up.


