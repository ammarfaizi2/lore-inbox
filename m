Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSKLRzx>; Tue, 12 Nov 2002 12:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSKLRzx>; Tue, 12 Nov 2002 12:55:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39881 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266749AbSKLRzu>;
	Tue, 12 Nov 2002 12:55:50 -0500
Date: Tue, 12 Nov 2002 10:02:34 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>
Subject: Re: [BUG] Oopsen with pcmcia aironet wireless (2.5.47)
Message-ID: <20021112180234.GB10986@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5860000.1037069226@localhost.localdomain> <3DD07FF4.2E1BC593@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD07FF4.2E1BC593@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 08:13:40PM -0800, Andrew Morton wrote:
> Andrew McGregor wrote:
> > 
> > I see lots of oopsen when I insert an Aironet PC4800 802.11 card.
> 
> They are debug warnings, not oopses.
> 
> > ...
> > Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdb, sector 0
> > Nov 12 15:40:39 localhost last message repeated 3 times
> > Nov 12 15:40:39 localhost kernel: end_request: I/O error, dev hdc, sector 0
> > Nov 12 15:40:39 localhost last message repeated 2 times
> 
> hm.  IDE sick?
> 
> > Nov 12 15:40:39 localhost kernel: Debug: sleeping function called from
> > illegal context at include/asm/semaphore.h:145
> > Nov 12 15:40:39 localhost kernel: Call Trace:
> > Nov 12 15:40:39 localhost kernel:  [<e1a59215>] PC4500_readrid+0x55/0x160
> 
> airo_get_stats is called under the read_lock(&dev_base_lock); which was
> taken in dev_get_info.  So it may not call sleeping functions (ie:
> down_interruptible()).
> 
> It would appear that no netdevice->get_stats() method is allowed to sleep,
> which seems pretty dumb, IMVHO.

	Forwarded to airo maintainer.

	Javier :
	Most drivers collect stats based on Tx/Rx packets (they just
increment counters). Look at other driver for details. If you really
want to get stats out of the firmware, you may use the techinique I
used in orinoco for wireless stats, which is to use previous stats and
only call async the stat function.
	Have fun...

	Jean
