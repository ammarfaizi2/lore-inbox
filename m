Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290812AbSAYVDL>; Fri, 25 Jan 2002 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSAYVDB>; Fri, 25 Jan 2002 16:03:01 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:54027 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290809AbSAYVCv>; Fri, 25 Jan 2002 16:02:51 -0500
Subject: Re: OOPS in 2.5.3-pre5 -- kernel BUG at slab.c:1101!
From: Miles Lane <miles@megapathdsl.net>
To: David Brownell <david-b@pacbell.net>
Cc: Ingo Molnar <mingo@elte.hu>, Greg KH <greg@kroah.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <03aa01c1a5d8$1d4d2ac0$6800000a@brownell.org>
In-Reply-To: <1011939163.1540.18.camel@stomata.megapathdsl.net>
	<1011986299.1370.77.camel@stomata.megapathdsl.net> 
	<03aa01c1a5d8$1d4d2ac0$6800000a@brownell.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 25 Jan 2002 13:01:39 -0800
Message-Id: <1011992500.1251.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 11:39, David Brownell wrote:
> > David and Greg, I think this OOPS may be related to the
> > new EHCI/ohci-hcd code.  This machine has an early NEC
> > USB 2.0 host controller and an USB OHCI host controller:
> 
> Configure with CONFIG_DEBUG_SLAB and it should go
> away.  Or, tweak drivers/usb/hcd/ohci-mem.c line 45 to
> be #ifdef CONFIG_DEBUG_SLAB.  A patch is pending,
> but it's included with some other updates to that code
> and I wanted to re-test.
> 
> Or a more fundamental fix would be to remove those
> #ifdefs from the EHCI and OHCI HCD code and just
> change drivers/pci/pci.c at about line 1065 to poison
> based on CONFIG_DEBUG_SLAB rather than using
> CONFIG_PCIPOOL_DEBUG ... that #ifdef predates
> CONFIG_DEBUG_SLAB.

Thanks, that worked.

	Miles


