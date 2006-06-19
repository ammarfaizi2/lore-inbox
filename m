Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWFSIbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWFSIbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWFSIbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:31:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43178 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751169AbWFSIbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:31:49 -0400
Date: Mon, 19 Jun 2006 18:30:12 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       neilb@suse.de, jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Message-ID: <20060619083012.GU2795448@melbourne.sgi.com>
References: <20060601095125.773684000@hasse.suse.de> <17539.35118.103025.716435@cse.unsw.edu.au> <20060616155120.GA6824@hasse.suse.de> <17555.12234.347353.670918@cse.unsw.edu.au> <20060618235654.GB2114946@melbourne.sgi.com> <17557.61307.364404.640539@cse.unsw.edu.au> <20060619010013.GC2114946@melbourne.sgi.com> <17557.64512.496195.714144@cse.unsw.edu.au> <20060619055523.GS2795448@melbourne.sgi.com> <20060618233339.dba0fc86.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618233339.dba0fc86.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 11:33:39PM -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2006 15:55:23 +1000
> David Chinner <dgc@sgi.com> wrote:
> > 
> > The boot warnings:
> > 
> > ....
> >     eth3      device: S2io Inc. Xframe 10 Gigabit Ethernet PCI-X (rev 03)
> >     eth3      configuration: eth-id-00:0c:fc:00:02:c8
> > irq 60, desc: a0000001009a2d00, depth: 1, count: 0, unhandled: 0
> > ->handle_irq():  0000000000000000, 0x0
> > ->chip(): a000000100a0fe40, irq_type_sn+0x0/0x80
> > ->action(): e00000b007471b80
> > ->action->handler(): a0000002059373d0, s2io_msi_handle+0x1510/0x660 [s2io]    eth3
> > IP address: 192.168.1.248/24
> > Unexpected irq vector 0x3c on CPU 3!
> 
> I guess that's where things start to go bad.  genirq changes?

Seems likely. Plain 2.6.17-rc6 doesn't give this error.

> > BUG: warning at drivers/serial/sn_console.c:976/sn_sal_console_write()
> 
> There's a warning patch in -mm which shouts when someone does a busywait
> delay of over a millisecond, and sn_sal_console_write() is doing
> mdelay(150).
> 
> And it's doing that mdelay because it thinks port->sc_port.lock is already
> held.  I don't know why.

Ok, that explains why I haven't seen it before...

> > ip is at kmem_freepages+0x100/0x200
....
> 
> slab got messed up - I don't know what did this, either.

2.6.17-rc6 seems fine here as well. I've run with slab debuging
turned on and got the same panic, so it's not something obvious....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
