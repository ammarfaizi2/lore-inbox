Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUGNEEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUGNEEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUGNEEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:04:08 -0400
Received: from havoc.gtf.org ([216.162.42.101]:57016 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263772AbUGNEEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:04:05 -0400
Date: Wed, 14 Jul 2004 00:04:03 -0400
From: David Eger <eger@havoc.gtf.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
Message-ID: <20040714040403.GA29729@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org> <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089692194.1845.38.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 11:16:34PM -0500, Benjamin Herrenschmidt wrote:
> On Mon, 2004-07-12 at 19:39, David Eger wrote:
> > Dear Ben,
> > 
> > This patch fixes the Zilog driver so it doesn't freak on my TiBook.
> > [patch that initializes port->lock in pmac_zilog.c
>
> The spinlock should be initialized by the serial core when registering
> the ports ... can you find out for me how do you end up with the
> port not registered but still trying to use the lock ? 

After some testing, I found that the pmac_zilog Oops (which claims we've
not initialized port->lock) only occurs when I also enable 8250/16550
serial support (CONFIG_SERIAL_8250)

I'll try to track down what's going on on the plane tomorrow, but I'm 
curious to hear if any of the recent csets might have caused this...
(hence the cc: rmk)

> > ( of course, it still spews diahrea of 'IN from bad port XXXXXXXX'
> >   but then, I don't have the hardware.... still, seems weird that OF
> >   would report that I do have said hardware :-/ )
> 
> The IN from bad port is a different issue, it's probably issued by
> another driver trying to tap legacy hardware, either serial.o or
> ps/2 kbd, I suppose, check what else of that sort you have in your
>  .config

Sure enough, the "IN from bad port XXXXXXXX" ended up being the i8042
serial PC keyboard driver, enabled with CONFIG_SERIO_I8042.  Don't know
why that's in ppc defconfig....

-dte
