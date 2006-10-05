Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWJEIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWJEIvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJEIvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:51:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWJEIvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:51:21 -0400
Date: Thu, 5 Oct 2006 01:50:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Message-Id: <20061005015052.4b4f14e8.akpm@osdl.org>
In-Reply-To: <20061005082348.GA30940@elte.hu>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	<20061005011608.b69e3461.akpm@osdl.org>
	<20061005011909.3e1a9fec.akpm@osdl.org>
	<20061005082348.GA30940@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 10:23:48 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > It just did something:
> > 
> > [   12.112000] kjournald starting.  Commit interval 5 seconds
> > [   12.160000] EXT3-fs: recovery complete.
> > [   12.164000] EXT3-fs: mounted filesystem with ordered data mode.
> > [   12.980000] audit(1160010604.980:2): enforcing=1 old_enforcing=0 auid=4294967295
> > [   18.808000] security:  3 users, 6 roles, 1417 types, 151 bools, 1 sens, 256 cats
> > [   18.812000] security:  57 classes, 41080 rules
> > [   18.816000] SELinux:  Completing initialization.
> > [   18.816000] SELinux:  Setting up existing superblocks.
> > [   18.824000] SELinux: initialized (dev sda6, type ext3), uses xattr
> > [   18.860000] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> > 
> > 
> > Those "six seconds" took at least three minutes.  With luck I'll have 
> > a login prompt tomorrow morning.
> 
> as per your previous stats, the ratio between expected and real local 
> APIC timer IRQs is 3:250. So if your normal bootup takes 1 minute, you 
> should be up and running in an hour or so :-/
> 
> you should be seeing similar symptoms when booting the x86 SMP kernel on 
> that box. Or is the anomalously slow LOC count only an artifact of the 
> hres tree?
> 

The stock kernel shows a local-apic interrupt rate of 18Hz (HZ=250).  Other
times I've seen 13Hz.

With this patch series applied, disabling the local apic in config fixes
things up (using the PIT).

With the stock kernel and SMP, the system is slow, but not _as_ slow. 
Bootup takes maybe twice as long, but not all week.  This time the local
APIC interrupt rate is 8Hz, so something peculiar is happening here -
nothing is proportional.

It'd be nice to fix the local apic rather than working around it.  Any idea
why it's doing this?
