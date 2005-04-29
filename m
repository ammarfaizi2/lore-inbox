Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVD2Oaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVD2Oaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVD2Oaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:30:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:18906 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262721AbVD2O3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:29:52 -0400
Date: Fri, 29 Apr 2005 16:29:47 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: coywolf@lovecn.org, coywolf@gmail.com, ruben@puettmann.net,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429142947.GD21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <20050427152704.632a9317.rddunlap@osdl.org> <20050428090539.GA18972@puettmann.net> <20050428084313.1e69f59d.rddunlap@osdl.org> <2cd57c90050428093851785879@mail.gmail.com> <20050428094721.4499f861.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428094721.4499f861.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:47:21AM -0700, Randy.Dunlap wrote:
> On Fri, 29 Apr 2005 00:38:24 +0800
> Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> 
> > On 4/28/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > > On Thu, 28 Apr 2005 11:05:40 +0200
> > > Ruben Puettmann <ruben@puettmann.net> wrote:
> > > 
> > > > On Wed, Apr 27, 2005 at 03:27:04PM -0700, Randy.Dunlap wrote:
> > > >  Looks like this code in init/main.c:
> > > > >
> > > > >     if (late_time_init)
> > > > >             late_time_init();
> > > > >
> > > > > sees a garbage value in late_time_init (garbage being
> > > > > %eax == 0x00307974.743d656c, which is "le=tty0\n",
> > > > > as in "console=tty0").
> > > > >
> > > > > How long is your kernel boot/command line?
> > > > > Please post it.
> > > >
> > > > It was boot over pxe here is the append line from the
> > > > pxelinux.cfg/default
> > > >
> > > > APPEND vga=normal rw  load_ramdisk=0 root=/dev/nfs nfsroot=192.168.112.1:/store/rescue/sarge-amd64,rsize=8192,wsize=8192,timo=12,retrans=3,mountvers=3,nfsvers=3
> > > 
> > > Hm, no "console=tty...." at all.  That didn't help (me) much.
> > 
> > Could that boot loader pxe append console=tty implicitly?
> 
> It could... I don't know anything about pxe boot.
> 
> 
> > >From the vmlinux Ruben gave me,
> > ffffffff807980d8 A __bss_start
> > ffffffff807980d8 A _edata
> > ffffffff80798100 B boot_cpu_stack
> > ffffffff8079c100 B boot_exception_stacks
> > ffffffff807a1100 B system_state
> > ffffffff807a1120 B saved_command_line
> > ffffffff807a1220 B late_time_init
> > ffffffff807a1228 b execute_command
> > ffffffff807a1230 b panic_later
> > ffffffff807a1238 b panic_param
> > ...
> > 
> > It seems possible to luckily skip the garbage. Comment out the two
> > lines and see if it works.
> > 
> > /*     if (late_time_init)
> >              late_time_init(); */
> 
> Yes, that would help verify that the command line is the problem.
> I also recall Andi having a few problems with large command lines
> on x86-64... so it still smells like that to me.  (ak added to cc:)


late_time_init is not in my tree. Someone else must have submitted it.
iirc it was a workaround for some race in the NMI watchdog setup, but
that has since then be properly fixed.

I would recommend to just drop the patch.


-Andi
