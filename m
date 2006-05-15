Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWEOWA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWEOWA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWEOWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:00:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6670 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965265AbWEOWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:00:55 -0400
Date: Mon, 15 May 2006 23:00:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060515220044.GA14849@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	linux@dominikbrodowski.net
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org> <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org> <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147730828.26686.165.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 11:07:08PM +0100, Alan Cox wrote:
> On Llu, 2006-05-08 at 17:34 +0100, Russell King wrote:
> > > So 8250 is requesting an IRQ for non-sharing mode and it's actually
> > > failing, because something else is already using that IRQ.  The difference
> > > is that the kernel now generates a warning when this happens.
> > 
> > Maybe someone is clearing the UPF_SHARE_IRQ flag?  Which port is this?
> 
> Its a bug in the PCMCIA code. Its the one I hit with the IDE code.
> Asking for a private IRQ is not always honoured.

Not in this case - the call trace is definitely a result of setserial
being used.  serial_cs _always_ registers ports with 8250 with the
share IRQ flag set.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
