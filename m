Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbSLSGak>; Thu, 19 Dec 2002 01:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLSGak>; Thu, 19 Dec 2002 01:30:40 -0500
Received: from dp.samba.org ([66.70.73.150]:26581 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267542AbSLSGai>;
	Thu, 19 Dec 2002 01:30:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modules oops in 2.5.52 
In-reply-to: Your message of "18 Dec 2002 20:19:09 -0800."
             <1040271549.1317.12.camel@ixodes.goop.org> 
Date: Thu, 19 Dec 2002 16:55:38 +1100
Message-Id: <20021219063839.40F322C080@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1040271549.1317.12.camel@ixodes.goop.org> you write:
> On Wed, 2002-12-18 at 18:11, Rusty Russell wrote:
> > In message <1040260444.1316.4.camel@ixodes.goop.org> you write:
> > > Hi,
> > > 
> > > I just had an oops in the modules code:
> > > 
> > > Dec 18 16:58:59 ixodes kernel: Unable to handle kernel paging request at 
virt
> > ual address f8980924
> > > Dec 18 16:58:59 ixodes kernel:  printing eip:
> > > Dec 18 16:58:59 ixodes kernel: f896756d
> > > Dec 18 16:58:59 ixodes kernel: *pde = 01bfc067
> > > Dec 18 16:58:59 ixodes kernel: *pte = 00000000
> > > Dec 18 16:58:59 ixodes kernel: Oops: 0000
> > > Dec 18 16:58:59 ixodes kernel: CPU:    0
> > > Dec 18 16:58:59 ixodes kernel: EIP:    0060:[<f896756d>]    Not tainted
> > > Dec 18 16:58:59 ixodes kernel: EFLAGS: 00010282
> > > Dec 18 16:58:59 ixodes kernel: EIP is at __exitfn+0xd/0x4c [parport_pc]
> > 
> > Actually, you had an oops in the parport_pc code, in
> > cleanup_module().  Now, *why* that oopsed, I don't know...
> 
> It looks like it might end up calling request_module() from within
> cleanup_module(). Is that going to be a problem?

Yes, it would be a problem.  But I don't think that's the problem
here, and I don't think it can actually happen (it's a pretty insane
idea).

BTW, I can't reproduce your problem, maybe because I can't unload
parport_pc here:

Module parport cannot be unloaded due to unsafe usage in drivers/parport/init.c:234
Module parport_pc cannot be unloaded due to unsafe usage in drivers/parport/parport_pc.c:1239

A little confused,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
