Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUAPPxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUAPPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:53:41 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:7808 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265413AbUAPPws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:52:48 -0500
Date: Fri, 16 Jan 2004 16:52:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, mpm@selenic.com,
       discuss@x86-64.org, george@mvista.com
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116155223.GA258@elf.ucw.cz>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401161951.51597.amitkale@emsyssoft.com> <20040116144736.GF2535@elf.ucw.cz> <200401162045.59591.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401162045.59591.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > int kgdbeth_event(struct notifier_block * self, unsigned long val,
> > void * data)
> > {
> >         if (strcmp(((struct net_device *)data)->name, "eth0")) {
> >                 goto out;
> >         }
> >         if (val!= NETDEV_UP)
> >                 goto out;
> >
> > Do I read it correctly as "eth0 is not to be used for debugging"? So
> > if I only have eth0 here, I have to comment it out, right?
> 
> No. It uses only "eth0" for debugging. If you have only eth0, it'll use that 
> for debugging.

Perhaps this is good idea? It should be documented
somewhere... Please apply,
								Pavel

--- /dev/null	2003-09-12 10:38:14.000000000 +0200
+++ linux/Documentation/kgdb/ethernet.txt	2004-01-16 16:43:34.000000000 +0100
@@ -0,0 +1,15 @@
+Some notes about kgdb over ethernet
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ 2004 Pavel Machek <pavel@suse.cz>
+
+Pass this on kernel commandline:
+
+	kgdbeth=interfacenum,localmac,listenport,remoteip,remotemac gdb
+
+Boot local machine. At the point where you enable eth0, machine will
+hang, waiting for remote gdb to connect. At that point, type this on
+remote machine:
+
+   $ gdb ./vmlinux
+   (gdb) target remote udp:HOSTNAME:6443


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
