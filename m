Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCRAzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCRAzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCRAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:55:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:10152
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750932AbWCRAzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:55:21 -0500
From: Rob Landley <rob@landley.net>
To: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] kernel BUG at drivers/block/loop.c:621
Date: Fri, 17 Mar 2006 19:55:37 -0500
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200603171912.12082.rob@landley.net> <200603180124.19077.blaisorblade@yahoo.it>
In-Reply-To: <200603180124.19077.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171955.38138.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 7:24 pm, Blaisorblade wrote:
> On Saturday 18 March 2006 01:12, Rob Landley wrote:
> > I can reproduce the following in 2.6.16-rc5, User Mode Linux:
> >
> > kernel BUG at drivers/block/loop.c:621!
> > Kernel panic - not syncing: BUG!
> >
> > EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:b7de1f9c EFLAGS:
> > 00200246 Not tainted
> > EAX: 00000000 EBX: 000018be ECX: 00000013 EDX: 000018be
> > ESI: 000018bb EDI: 00000011 EBP: b7de1fb8 DS: 007b ES: 007b
> > 09b87bb4:  [<0806c762>] show_regs+0x102/0x110
> > 09b87bd0:  [<0805b6fc>] panic_exit+0x2c/0x50
> > 09b87be0:  [<0807ff7d>] notifier_call_chain+0x2d/0x50
> > 09b87c00:  [<08071095>] panic+0x75/0x120
> > 09b87c20:  [<0812e181>] loop_thread+0x151/0x160
> > 09b87c4c:  [<08065297>] run_kernel_thread+0x37/0x60
> > 09b87cfc:  [<0805bbd1>] new_thread_handler+0x91/0xc0
>
> The below is strange - GCC is putting disks in the .text section or
> kallsyms has some bug.
>
> > 09b87d20:  [<ffffe420>] disks+0xf7e7ec84/0x4

Isn't ffffe??? the FASTCALL page?

> > The reproduction sequence is a bit involved (my mount regression test and
> > the current svn snapshot of busybox are involved), and running the
> > following sequence of commands:
> >
> > mount; mount -a; mount; mount /dev/loop1 /images/vfat.dir ;
> > losetup /dev/loop1; ls; vi /etc/fstab; cat /etc/fstab; losetup
> > /dev/loop0; mount /images/vfat.img /images/vfat.dir -o ro
> >
> > The current busybox mount is still broken in a couple of known places
> > (hence the testing; I'm fixing it).  But it probably shouldn't panic the
> > kernel...
>
> *) Is this reproducible on host?

Haven't tried.  I value my laptop. :)

My host is running unbuntu 2.6.12, and my mount test requires a clean 
environment with nothing else mounted when it first runs.  (It basically 
needs to run as PID 1.  Among other things, it synthesizes variants of its 
own fstab...)

I don't think it's a uml bug, but I cc'd the UML list because that's where I 
can easily reproduce it.

Rob
-- 
Never bet against the cheap plastic solution.
