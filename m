Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTEMA5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbTEMA5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:57:50 -0400
Received: from dp.samba.org ([66.70.73.150]:10919 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263073AbTEMA5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:57:48 -0400
Date: Tue, 13 May 2003 11:10:25 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>
Subject: Re: New irq stuff on airo/hermes + SMP
Message-ID: <20030513011025.GC2941@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	jt@hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Benjamin Reed <breed@almaden.ibm.com>,
	Javier Achirica <achirica@ttd.net>
References: <20030512182840.GC24830@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512182840.GC24830@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:28:40AM -0700, Jean Tourrilhes wrote:
[snip]
> hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
> orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
> eth0: Station identity 001f:0001:0007:001c
> eth0: Looks like a Lucent/Agere firmware version 7.28
> eth0: Ad-hoc demo mode supported
> eth0: IEEE standard IBSS ad-hoc mode supported
> eth0: WEP supported, 104-bit key
> eth0: MAC address 00:60:1D:F0:3A:8A
> eth0: Station name "HERMES I"
> eth0: ready
> eth0: index 0x01: Vcc 5.0, irq 5, io 0x0100-0x013f
> eth0: New link status: Connected (0001)
> orinoco_lock() called with hw_unavailable (dev=cb6ca800)
> irq 5: nobody cared!
> Call Trace:
>  [<c010a998>] handle_IRQ_event+0x94/0xf8
>  [<c010aba6>] do_IRQ+0x96/0x100
>  [<c0106d70>] default_idle+0x0/0x34
>  [<c0105000>] _stext+0x0/0x48
>  [<c0109570>] common_interrupt+0x18/0x20
>  [<c0106d70>] default_idle+0x0/0x34
>  [<c0105000>] _stext+0x0/0x48
>  [<c0106d9c>] default_idle+0x2c/0x34
>  [<c0106e23>] cpu_idle+0x37/0x48
>  [<c0105045>] _stext+0x45/0x48
>  [<c030c738>] start_kernel+0x13c/0x144
> 
> handlers:
> [<cc877074>] (orinoco_interrupt+0x0/0x25c [orinoco])
> orinoco_lock() called with hw_unavailable (dev=cb6ca800)

Jean, I think this was a mistake in the original adaption of the
driver to the new irq stuff (which I didn't do).  It mistakenly
returns IRQ_NONE if hw_unavailable is set in the interrupt handler
(wrong based on the "return IRQ_HANDLED" if in doubt rule).  Does this
still happen with 0.13e?  I've properly implemented the new IRQ stuff
there.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
