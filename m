Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290931AbSASLCX>; Sat, 19 Jan 2002 06:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290932AbSASLCN>; Sat, 19 Jan 2002 06:02:13 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:36009 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S290931AbSASLB5>; Sat, 19 Jan 2002 06:01:57 -0500
Date: Sat, 19 Jan 2002 13:01:43 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: VIA KT133 & HPT 370 IDE disk corruption
Message-ID: <20020119110143.GB135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org,
	Jani Forssell <jani.forssell@viasys.com>
In-Reply-To: <00c201c1a033$1cf46700$b71c64c2@viasys.com> <3C48BF64.FBF58C7C@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C48BF64.FBF58C7C@bigfoot.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 04:35:48PM -0800, you [Tim Moore] claimed:
> Jani Forssell wrote:
> > 
> > It turned out that the main culprit was the NIC that was attached to PCI
> > slot 4. Moving it to slot 3 resolved the disk corruption as well as the
> > oopses that occured. Other PCI slots to avoid for the NIC were 5 and 6.
> > Slot 4 & 6 shares an IRQ with the VIA USB controller, but I did try
> > disabling it from the BIOS but it didn't help (lspci didn't show the
> > device after it had been disabled). Slot 5 shares and IRQ with the
> > Highpoint controller.
> 
> My BP6's [hpt366] had similar sustained I/O lockup issues, especially
> when running a RAID stripe.  From the v1.01 BP6 manual:
> ...
> PCI slots 4 and 5 use the same bus master control signal.
> 
> PCI slot 3 shares IRQ signals with the HPT366 IDE controller
> (Ultra ATA/66).  The driver for the HPT 366 IDE controller
> supports IRQ sharing with other PCI devices. But if you
> install a PCI card that doesn t allow IRQ sharing with other
> devices into PCI slot 3, you may encounter some problems.

Note that culprit wasn't the slot that shares an irq with the highpoint
controllers (HPT370 on this board). We knew to avoid that slow from the
beginning (I have a BP6 at home), but I think we tried slot 5 out of
interest after we had verified slot 3 works. I think slot 5 showed the
problem as well - Jani?

Anyhow, we were more puzzled as to how the VIA USB controller, that is
disabled in both BIOS and kernel config can cause these problems. Or is
there something else wrong with the board's pci routing?

As regards to BP6, I find it bearably stable after upgrading to latest bios
ages ago (was it RU or what that solved the lock up issue).  It still locks
up once or twice a month - which I can live with.  But I digress.


-- v --

v@iki.fi
