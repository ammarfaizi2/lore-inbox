Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUIZVdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUIZVdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 17:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUIZVdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 17:33:42 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:17869
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S263818AbUIZVdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 17:33:35 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Jan Kara" <jack@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: Consistent kernel hang during heavy TCP connection handling load
Date: Sun, 26 Sep 2004 17:33:26 -0400
Message-ID: <NFBBICMEBHKIKEFBPLMCGEHFIJAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20040926174217.GB18172@atrey.karlin.mff.cuni.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan,

Thanks for responding.  When I got no responses, I searched for ways to get more data out of the kernel--I must say that it has been
quite a journey to identify what is working, where to get it, and how to install it when it comes to kernel
debugging/crash-data-gathering tools.  LKCD for example, is not available at the location you'll eventually arrive at if you search
for it in google ... it's not obvious what it's state is (current/defunct/superceded), there's KDB, KGDB, netdump, netconsol,
netlog, diskdump (conusingly known as lkdump) etc. etc.  And then, even if you do figure out what tools are current, you then have
to match the tool to the particular kernel version you are running -- which can be a task and a half unto itself.

Is diskdump available for 2.4?  Can anyone comment on the choice of tools below?

Anyway, I have also done all of the following:

(1) Enabled netdump/netconsole on 2.6.8.1-521 Fedora Core kernel, after first fixing the startup scripts.  Fixes can be found at
www.memeplex.com/Linux.html  Note that after I also fixed crash.c to be a 2.6 compliant kernel module, and loading it to test
netdump, I always end up with a vmcore-incomplete image approx 45k in size, on the netdump-server.  Can anyone tell me if this is
absurdly small, and if so, what might be the solution?  The client box always reboots so I suspect too-small timeouts are the issue.

(2) Downloaded the latest 2.4 kernel, installed KDB patches and modified configs on the system to accept the 2.4 kernel --
specifically, /etc/modules.conf and xorg.conf changes (added Mouse1/SendCoreEvents on /dev/psaux).  I don't think I found any
netdump patches for the 2.4 line of kernels.  Can someone point me in the right direction?

(3) Enabled sysrq on both kernels, including echo "1" > /proc/sys/kernel/sysrq

I'll wait for the next hang now, trying it on both kernels.  By the way, the system is hung VERY badly--doesn't respond to anything,
no switching consoles, no keyboard events, no disk activity.  Dunno about network, since I haven't put a sniffer on it yet.

A.

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz]
Sent: Sunday, September 26, 2004 1:42 PM
To: Andrew A.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Consistent kernel hang during heavy TCP connection handling
load


>
> I would not normally quote an an entire message, but it contains data
> relevant to this problem.
>
> The hang below occurs even outside of GDB, and also occurs after
> upgrading the kernel:
>
> Linux bbox.memeplex.com 2.6.8-1.521 #1 Mon Aug 16 09:01:18 EDT 2004
> i686 i686 i386 GNU/Linux
>
>
>
> Can anyone please give me a clue/pointer to tools/techniques that
> might help identify where in the kernel the hang occurs?  The system
> is so completely unresponsive when this occurs that I cannot provide
> any forensic data.
  How unresponsive exactly it is? Can you switch consoles and write? I
suppose ps(1) hangs... Is the disk working?

You can compile kernel with the magic Sysrq key (it is the option in the
kernel debugging section), run it and then press alt-sysrq-t and the
state of all processes will be printed. That might help...

> Does anyone's experience show that these types of hangs might occur
> purely as the result of use (or mis-use) of the pthreads library?  I'm
> looking for hints about what parts of my code to review.
>
> There could easily be erroneous calls to pthread_detach(),
> pthread_join(), close(), and other system calls involved.
>
> Thanks,
> Andrew Athan

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs



