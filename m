Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUAPPQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUAPPQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:16:42 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:19354 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265336AbUAPPQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:16:40 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 20:45:59 +0530
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, mpm@selenic.com,
       discuss@x86-64.org, george@mvista.com
References: <200401161759.59098.amitkale@emsyssoft.com> <200401161951.51597.amitkale@emsyssoft.com> <20040116144736.GF2535@elf.ucw.cz>
In-Reply-To: <20040116144736.GF2535@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162045.59591.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 Jan 2004 8:17 pm, Pavel Machek wrote:
> Hi!
>
> > > > KGDB 2.0.3 is available at
> > > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> > > >
> > > > Ethernet interface still doesn't work. It responds to gdb for a
> > > > couple of packets and then panics. gdb log for ethernet interface is
> > > > pasted below.
> > >
> > > Did you add the fix for netpoll Jim posted?
> >
> > I am not using netpoll (yet). My patch doesn't require any driver
> > modifications, that the mm ethernet patch required.
>
> int kgdbeth_event(struct notifier_block * self, unsigned long val,
> void * data)
> {
>         if (strcmp(((struct net_device *)data)->name, "eth0")) {
>                 goto out;
>         }
>         if (val!= NETDEV_UP)
>                 goto out;
>
> Do I read it correctly as "eth0 is not to be used for debugging"? So
> if I only have eth0 here, I have to comment it out, right?

Hi Pavel,

No. It uses only "eth0" for debugging. If you have only eth0, it'll use that 
for debugging.

Bad code again. It should be using kgdb_netdev variable [after making it 
global].

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

