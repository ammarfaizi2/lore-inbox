Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSLVVGF>; Sun, 22 Dec 2002 16:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSLVVGF>; Sun, 22 Dec 2002 16:06:05 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8114 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265396AbSLVVGE>; Sun, 22 Dec 2002 16:06:04 -0500
Date: Sun, 22 Dec 2002 13:14:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH]Timer list init is done AFTER use
Message-ID: <14540000.1040591645@titus>
In-Reply-To: <3E0579F8.CF1D94A9@digeo.com>
References: <3E02D81F.13A5A59D@mvista.com> <3E02F073.BF57207C@digeo.com>
 <3E0350CA.6B99F722@mvista.com> <3E0370C1.21909EF5@digeo.com>
 <3E03772A.D5D85171@mvista.com> <3E0579F8.CF1D94A9@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The boot cpu is set online extremely late.  Strangely late.  Why
> is this?
>
> How about something like the below?  We mark the boot cpu
> online in generic code as soon as it has initialised its per-cpu
> storage (seems appropriate?)

I seem to recall some related problem with the topology stuff ...
anyway, I tested your patch on a 16-way NUMA-Q and it works just fine.
Thanks for fixing that up ....

> This will then allow that cpu to actually start calling into console
> drivers, if they have been registered.  If those drivers do a mod_timer()
> (as the vga console does) then that will work OK.

Would be nice to shift generic console_init earlier, if that's what
you're implying, but we still need early_printk for setup_arch.

M.

