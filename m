Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136939AbRAHHrp>; Mon, 8 Jan 2001 02:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137014AbRAHHrf>; Mon, 8 Jan 2001 02:47:35 -0500
Received: from rausis.latnet.lv ([159.148.108.6]:12296 "HELO rausis.latnet.lv")
	by vger.kernel.org with SMTP id <S136939AbRAHHrZ>;
	Mon, 8 Jan 2001 02:47:25 -0500
Date: Mon, 8 Jan 2001 09:47:25 +0200 (GMT-2)
From: Andris Pavenis <pavenis@latnet.lv>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: devfs breakage in 2.4.0 release
In-Reply-To: <200101070625.WAA01585@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0101080926030.2247-100000@rausis.latnet.lv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sat, 6 Jan 2001, Adam J. Richter wrote:

> 	On my Sony PictureBook PCG-C1VN, 2.4.0 hangs in the boot
> process while 2.4.0-prerelease boots just fine.  At first I thought
> the problem was devfs-related, but skipping devfsd just caused the
> hang to occur a little later, this time in ifconfig.  The kernel
> call trace looked something like this:
> 
> 	neigh_ifdown
> 	sys_ioctl
> 	sock_ioctl
> 	[some addresses in modules]
> 	stext_lock
> 	__down_failed
> 	__down
> 
> 	What surprised me more was that attempting to remount the
> root filesystem for writing just before this (to record the module
> kernel symbols) caused a kenel BUG() in slab.c:1542 becuase kmalloc
> was being called with a huge negative number.
> 
> 	I know I could run ksymoops to get this trace, but I now
> think the cause of the problem probably happens much earlier than
> the symptoms.  So, I trying backing out different 2.4.0 changes.
> So far, I can tell you that reverting the linux/mm subdirectory to
> its 2.4.0-prerelease contents had no effect.  I will let you know
> if I diagnose or fix the problem, as I think you may be experiencing
> the same problem.

I think it's a different problem. I reproduced the same with 2.4.0-test12
but not 2.4.0-test10. 

There are changes (not very large) in fs/devfs/base.c between
these versions. I tried to take 2.4.0 and change back these updates and 
saw that it doesn't fix the problem. Trying all prerelaeses between
2.4.0-test10 and 2.4.0-test12 perhaps would take too much time ... 

There is no hanging (or crashes) at all for me. All these versions
boots Ok for me, but what I have is devfsd quitting with error message
that it cannot state /dev/vcc/[1-6] after some relooging from the same
terminal.

Andris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
