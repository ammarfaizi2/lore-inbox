Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272995AbTHFGkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHFGkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:40:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:62620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272995AbTHFGkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:40:39 -0400
Date: Tue, 5 Aug 2003 23:42:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: torvalds@osdl.org
Cc: misha@nasledov.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-Id: <20030805234212.081c0493.akpm@osdl.org>
In-Reply-To: <200308060559.h765xhI05860@mail.osdl.org>
References: <20030804232204.GA21763@nasledov.com>
	<20030805144453.A8914@flint.arm.linux.org.uk>
	<20030806045627.GA1625@nasledov.com>
	<200308060559.h765xhI05860@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSDL <torvalds@osdl.org> wrote:
>
> Misha Nasledov wrote:
> > 
> > I am attaching the dmesg output after booting 2.6.0-test2; this does
> > not include the insertion of the Orinoco card as the console freezes
> > immediately after the event. I inspected my logs after a reboot and
> > there were no messages whatsoever regarding the event of the insertion
> > of the Orinoco card.
> 
> Can you try with PnP and the i82365 support _disabled_. I find this sequence
> very suspicious:
> 
>         Intel PCIC probe: PNP <6>pnp: Device 00:17 activated.
>         invalid resources ?
>         pnp: Device 00:17 disabled.
>         not found.
> 
> and I bet it messes up some of the register state that the yenta probe had
> just set up.
> 
> You should try with just CONFIG_YENTA - the 82365 stuff is for the old
> 16-bit only controllers.

I have an IBM A21P which has the same problem.

The controller is a PCI1450 (rev 03)

The symptoms are that insertion of a PCMCIA or Cardbus card causes the
machine to lock up: it is calling yenta_interrupt() a zillion times per
second.  Presumably the IRQ isn't getting cleared.

Disabling i82635 in config fixes it up.

2.5.70 does not lock up.  2.5.71 does lock up.

dmesg and .config are at

	http://www.zip.com.au/~akpm/linux/patches/a21p-lockup/


