Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSGJIql>; Wed, 10 Jul 2002 04:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGJIqk>; Wed, 10 Jul 2002 04:46:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317505AbSGJIqj>;
	Wed, 10 Jul 2002 04:46:39 -0400
Date: Wed, 10 Jul 2002 10:49:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Thomas Tonino <ttonino@users.sf.net>
Cc: linux-kernel@vger.kernel.org, "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Terrible VM in 2.4.11+?
Message-ID: <20020710084904.GH3185@suse.de>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <3D2BF3CC.3040409@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2BF3CC.3040409@users.sf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10 2002, Thomas Tonino wrote:
> J.A. Magallon wrote:
> 
> >Seriously, if you have that kind of problems, take the -aa kernel and use 
> >it.
> >I use it regularly and it behaves as one would expect, and fast.
> >And please, report your results...
> 
> I run a 2 cpu server with 16 disks and around 5 megabytes of writes a 
> second. With plain 2.4.18 (using the feral.com qlogic driver) and 2GB 
> ram, this seemed okay. Upgrading to 4GB ram slowed the system down, and 
> normal shell commands became quite unresponsive with 4GB.
> 
> So we built a second server, with 2.4.19-pre9-aa2 using the qlogic 
> driver in the kernel. That driver needs patching, as it will otherwise 
> get stuck in a 'no handle slots' condition. Used a patch that I posted 
> to linux-scsi a while ago.

That's probably not just a mm issue, if you use stock 2.4.18 with 4GB
ram you will spend oodles of time bounce buffering i/o. 2.4.19-pre9-aa2
includes the block-highmem stuff, which enables direct-to-highmem i/o,
if you enabled the CONFIG_HIGHIO option.

In short, not an apples-to-apples comparison :-)

-- 
Jens Axboe

