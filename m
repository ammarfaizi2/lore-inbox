Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDMUTf>; Fri, 13 Apr 2001 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRDMUT0>; Fri, 13 Apr 2001 16:19:26 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:16078 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S131733AbRDMUTP>; Fri, 13 Apr 2001 16:19:15 -0400
Date: Fri, 13 Apr 2001 16:16:58 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD61258.4E8567D8@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0104131611400.8043-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Andrew Morton wrote:
> Rod Stewart wrote:
> >
> > On Thu, 12 Apr 2001, Andrew Morton wrote:
> > > Rod Stewart wrote:
> > > >
> > > > Hello,
> > > >
> > > > Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
> > > > thread for each device we have; if the driver is built into the kernel.
> > > > If the driver is built as a module, no defunct threads appear.
> > >
> > > What is the parent PID for the defunct tasks?  zero?
> >
> > According to ps, 1
>
> Ah.  Of course.  All (or most) kernel initialisation is
> done by PID 1.  Search for "kernel_thread" in init/main.c
>
> So it seems that in your setup, process 1 is not reaping
> children, which is why this hasn't been reported before.
> Is there something unusual about your setup?

I found the difference which causes this.  If I build my kernel with
IP_PNP (IP: kernel level autoconfiguration) support I get a defunt thread
for each 8139too device.  If I don't build with IP_PNP support I don't get
any, defunct ethernet threads.

This make any sense?  Here is the relevant diff from a working config to a
bad one:
[root@stewart-nw34 conf]# diff -u config-p5-good config-p6-bad
--- config-p5-good      Fri Apr 13 16:07:10 2001
+++ config-p6-bad       Fri Apr 13 16:12:21 2001
@@ -173,7 +173,9 @@
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
-# CONFIG_IP_PNP is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set

Thanks,
-Rms

