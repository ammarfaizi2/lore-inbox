Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbSLSCfN>; Wed, 18 Dec 2002 21:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbSLSCfN>; Wed, 18 Dec 2002 21:35:13 -0500
Received: from dp.samba.org ([66.70.73.150]:22187 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267496AbSLSCfM>;
	Wed, 18 Dec 2002 21:35:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modules oops in 2.5.52 
In-reply-to: Your message of "18 Dec 2002 17:14:05 -0800."
             <1040260444.1316.4.camel@ixodes.goop.org> 
Date: Thu, 19 Dec 2002 13:11:21 +1100
Message-Id: <20021219024313.759EC2C075@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1040260444.1316.4.camel@ixodes.goop.org> you write:
> Hi,
> 
> I just had an oops in the modules code:
> 
> Dec 18 16:58:59 ixodes kernel: Unable to handle kernel paging request at virt
ual address f8980924
> Dec 18 16:58:59 ixodes kernel:  printing eip:
> Dec 18 16:58:59 ixodes kernel: f896756d
> Dec 18 16:58:59 ixodes kernel: *pde = 01bfc067
> Dec 18 16:58:59 ixodes kernel: *pte = 00000000
> Dec 18 16:58:59 ixodes kernel: Oops: 0000
> Dec 18 16:58:59 ixodes kernel: CPU:    0
> Dec 18 16:58:59 ixodes kernel: EIP:    0060:[<f896756d>]    Not tainted
> Dec 18 16:58:59 ixodes kernel: EFLAGS: 00010282
> Dec 18 16:58:59 ixodes kernel: EIP is at __exitfn+0xd/0x4c [parport_pc]

Actually, you had an oops in the parport_pc code, in
cleanup_module().  Now, *why* that oopsed, I don't know...

> Now, any process which touches /proc/modules hangs, I guess because a
> lock was being held.

Yes.  Changing this would be particularly interesting, since you don't
want a simultaneous "modprobe" to fail.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
