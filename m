Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVD1QsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVD1QsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVD1QsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:48:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:2974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVD1Qro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:47:44 -0400
Date: Thu, 28 Apr 2005 09:47:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: coywolf@lovecn.org
Cc: coywolf@gmail.com, ruben@puettmann.net, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-Id: <20050428094721.4499f861.rddunlap@osdl.org>
In-Reply-To: <2cd57c90050428093851785879@mail.gmail.com>
References: <20050427140342.GG10685@puettmann.net>
	<20050427152704.632a9317.rddunlap@osdl.org>
	<20050428090539.GA18972@puettmann.net>
	<20050428084313.1e69f59d.rddunlap@osdl.org>
	<2cd57c90050428093851785879@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 00:38:24 +0800
Coywolf Qi Hunt <coywolf@gmail.com> wrote:

> On 4/28/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > On Thu, 28 Apr 2005 11:05:40 +0200
> > Ruben Puettmann <ruben@puettmann.net> wrote:
> > 
> > > On Wed, Apr 27, 2005 at 03:27:04PM -0700, Randy.Dunlap wrote:
> > >  Looks like this code in init/main.c:
> > > >
> > > >     if (late_time_init)
> > > >             late_time_init();
> > > >
> > > > sees a garbage value in late_time_init (garbage being
> > > > %eax == 0x00307974.743d656c, which is "le=tty0\n",
> > > > as in "console=tty0").
> > > >
> > > > How long is your kernel boot/command line?
> > > > Please post it.
> > >
> > > It was boot over pxe here is the append line from the
> > > pxelinux.cfg/default
> > >
> > > APPEND vga=normal rw  load_ramdisk=0 root=/dev/nfs nfsroot=192.168.112.1:/store/rescue/sarge-amd64,rsize=8192,wsize=8192,timo=12,retrans=3,mountvers=3,nfsvers=3
> > 
> > Hm, no "console=tty...." at all.  That didn't help (me) much.
> 
> Could that boot loader pxe append console=tty implicitly?

It could... I don't know anything about pxe boot.


> >From the vmlinux Ruben gave me,
> ffffffff807980d8 A __bss_start
> ffffffff807980d8 A _edata
> ffffffff80798100 B boot_cpu_stack
> ffffffff8079c100 B boot_exception_stacks
> ffffffff807a1100 B system_state
> ffffffff807a1120 B saved_command_line
> ffffffff807a1220 B late_time_init
> ffffffff807a1228 b execute_command
> ffffffff807a1230 b panic_later
> ffffffff807a1238 b panic_param
> ...
> 
> It seems possible to luckily skip the garbage. Comment out the two
> lines and see if it works.
> 
> /*     if (late_time_init)
>              late_time_init(); */

Yes, that would help verify that the command line is the problem.
I also recall Andi having a few problems with large command lines
on x86-64... so it still smells like that to me.  (ak added to cc:)

---
~Randy
