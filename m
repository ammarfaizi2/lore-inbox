Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUDMGAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 02:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbUDMGAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 02:00:19 -0400
Received: from [203.197.98.4] ([203.197.98.4]:55569 "EHLO avmx.iitkgp.ernet.in")
	by vger.kernel.org with ESMTP id S263380AbUDMGAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 02:00:05 -0400
Subject: Re: KGDB problem
From: "kernel@cc.iitkgp.ernet.in" <kernel@cc.iitkgp.ernet.in>
Reply-To: kernel@cc.iitkgp.ernet.in
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
In-Reply-To: <200404131009.35464.amitkale@emsyssoft.com>
References: <1081829314.4021.11.camel@cs-rs-221.cse.iitkgp.ernet.in>
	 <200404131009.35464.amitkale@emsyssoft.com>
Content-Type: text/plain
Organization: IIT Kharagpur
Message-Id: <1081835876.23747.2.camel@cs-rs-221.cse.iitkgp.ernet.in>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Apr 2004 11:27:56 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

***********************************************
This Mail is Certified to be Virus Free.

CIC Network Security Group, IIT Kharagpur
***********************************************

Hi,

Here's a sample gdb output:

(gdb) symbol-file vmlinux
Reading symbols from vmlinux...done.
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
breakpoint () at kgdbstub.c:1005
1005                    atomic_set(&kgdb_setting_breakpoint, 0);
(gdb) br boomerang_rx
Breakpoint 1 at 0xc01c5709: file 3c59x.c, line 2397.
(gdb) br netif_rx
Breakpoint 2 at 0xc0285bc3: file current.h, line 9.
(gdb) c
Continuing.
[New Thread 32768]
 
Breakpoint 1, boomerang_rx (dev=0xc7e4bc00) at 3c59x.c:2397
2397            struct vortex_private *vp = (struct vortex_private
*)dev->priv;
(gdb) c
Continuing.
 
Breakpoint 2, netif_rx (skb=0xc796d04e) at current.h:9
9               __asm__("andl %%esp,%0; ":"=r" (current) : "0"
(~8191UL));
(gdb) s
1276    {
(gdb) s
9               __asm__("andl %%esp,%0; ":"=r" (current) : "0"
(~8191UL));
(gdb) s
7       {
(gdb) s
1281            if (skb->stamp.tv_sec == 0)
(gdb) s
1282                    do_gettimeofday(&skb->stamp);
(gdb) bt
#0  netif_rx (skb=0xc78c05e0) at dev.c:1282
(gdb)

Regards.



On Tue, 2004-04-13 at 10:09, Amit S. Kale wrote:
> Can you send the gdb output?
> 
> -Amit
> 
> On Tuesday 13 Apr 2004 9:38 am, kernel@cc.iitkgp.ernet.in wrote:
> > ***********************************************
> > This Mail is Certified to be Virus Free.
> >
> > CIC Network Security Group, IIT Kharagpur
> > ***********************************************
> >
> > I have a problem using kgdb.
> >
> > My test kernel is 2.4.24 and I am using the kgdb patch
> > linux-2.4.23-kgdb-1.9.patch downloaded from kgdb.sourceforge.net.
> >
> > The problem is that whenever I break at a function [say netif_rx() in a
> > net driver interrupt routine] and step into it, the "bt" (backtrace)
> > command never shows the entire stack trace - it only shows the current
> > function. Moreover, the "up" command does not work. Could anybody tell
> > me what could be the problem?
> >
> > Regards.


