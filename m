Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUAQG2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 01:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUAQG2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 01:28:13 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:45973 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265463AbUAQG2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 01:28:09 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: KGDB documentation [Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface]
Date: Sat, 17 Jan 2004 11:57:26 +0530
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@suse.de>, kgdb-bugreport@lists.sourceforge.net,
       mpm@selenic.com
References: <200401161759.59098.amitkale@emsyssoft.com> <200401162045.59591.amitkale@emsyssoft.com> <20040116155223.GA258@elf.ucw.cz>
In-Reply-To: <20040116155223.GA258@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171157.27534.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I extracted this part of Pavel the patch he had submitted for 2.0.3 and 
appended it to README file. Since Pavel has't noticed it, I am assuming that 
most people won't notice it either.

Do people think pushing documentation into Documentation/kgdb directory is a 
better idea?

Another note about kgdb documentation - 
There is a lot of documentation at kgdb.sourceforge.net. It's more of howto 
type rather than manpages. Will it be too much as a documentation in kernel 
sources.

Any ideas on which things to put into Documentation/kgdb and which to have on 
a website.

On Friday 16 Jan 2004 9:22 pm, Pavel Machek wrote:
> Hi!
>
> > > int kgdbeth_event(struct notifier_block * self, unsigned long val,
> > > void * data)
> > > {
> > >         if (strcmp(((struct net_device *)data)->name, "eth0")) {
> > >                 goto out;
> > >         }
> > >         if (val!= NETDEV_UP)
> > >                 goto out;
> > >
> > > Do I read it correctly as "eth0 is not to be used for debugging"? So
> > > if I only have eth0 here, I have to comment it out, right?
> >
> > No. It uses only "eth0" for debugging. If you have only eth0, it'll use
> > that for debugging.
>
> Perhaps this is good idea? It should be documented
> somewhere... Please apply,
> 								Pavel
>
> --- /dev/null	2003-09-12 10:38:14.000000000 +0200
> +++ linux/Documentation/kgdb/ethernet.txt	2004-01-16 16:43:34.000000000
> +0100 @@ -0,0 +1,15 @@
> +Some notes about kgdb over ethernet
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> + 2004 Pavel Machek <pavel@suse.cz>
> +
> +Pass this on kernel commandline:
> +
> +	kgdbeth=interfacenum,localmac,listenport,remoteip,remotemac gdb
> +
> +Boot local machine. At the point where you enable eth0, machine will
> +hang, waiting for remote gdb to connect. At that point, type this on
> +remote machine:
> +
> +   $ gdb ./vmlinux
> +   (gdb) target remote udp:HOSTNAME:6443

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

