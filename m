Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbVCKP4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbVCKP4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbVCKP4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:56:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263435AbVCKPyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:54:07 -0500
Date: Fri, 11 Mar 2005 16:54:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Fabio Coatti <fabio.coatti@wseurope.com>
Cc: Simone Piunno <simone.piunno@wseurope.com>, Baruch Even <baruch@ev-en.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Message-ID: <20050311155400.GL28188@suse.de>
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111514.34949.simone.piunno@wseurope.com> <20050311151644.GJ28188@suse.de> <200503111650.07336.fabio.coatti@wseurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503111650.07336.fabio.coatti@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11 2005, Fabio Coatti wrote:
> Alle 16:16, venerdì 11 marzo 2005, Jens Axboe ha scritto:
> > On Fri, Mar 11 2005, Simone Piunno wrote:
> > > Alle 14:29, venerdì 11 marzo 2005, Baruch Even ha scritto:
> > > > echo t > /proc/sysrq-trigger
> > >
> > > Before killing bonnie:
> >
> > I'm guessing your problem is that bonnie dirtied tons of data before you
> > killed it, so it has to flush it out. If you run out of request entries,
> > you will get to sleep uninterruptibly on those while the data is
> > flushing. I don't see anything unexpected here, it is normal behaviour.
> 
> The real issue here is that under heavy I/O activity (bonnie is a good
> way to emphasize the concept), even caused by only one task, the
> system becomes quite unresponsive and "sluggish". The same can be seen
> under a gentoo "emerge --metadata", and slocate has the same effect.
> The problem is not only related to desktop, but i.e. on a dual opteron
> il takes several seconds to have an "ls" output (on a nearly empty
> dir) or simply to log in using ssh.  It seems to me that I/O scheduler
> gives high priority to the running process and any other request is
> delayed to the point that the responsiveness of a desktop becomes poor
> (say, to open a "K" menu takes several seconds on a pIV 2.8G HT).  In
> every case, we seen that the I/O bound processes are stuck in "D"
> state, the same stands for pdflush and kswapd.

I'd guess that your problem is queueing, if you have a ton of pending
requests in the hardware it will take forever to get a new request
through. There's nothing the io scheduler can do to help you there,
really. The /proc/driver/cciss/cciss0 you originall posted, was that
from before or after running bonnie++? I have no latency experience with
cciss, at least IDE/SATA/SCSI should work alright.

Actually the CFQ that will be in the next -mm release could help you
out, it limits the hardware queue for latency reasons.

-- 
Jens Axboe

