Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVGaX7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVGaX7m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVGaX7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:59:42 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:7851 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262162AbVGaX7l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:59:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dIJEJC/QiF3RwJTXg6GeKiyD9kQFJCzKgO7H3ReQXPBI5TRmQpbah3Ybsp/KBRsgHiyeV4G2mzNCG8W4qPij3lumLfKUW7HMX9iM0dI73ggLH6EiRTKEfhI3VP0kcn1ip3AlIcIeK5EF08L2ywcKJARE/Qn5cixDV7T5JqRCXnI=
Message-ID: <21d7e9970507311659259e5560@mail.gmail.com>
Date: Mon, 1 Aug 2005 09:59:37 +1000
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: revert yenta free_irq on suspend
Cc: Pavel Machek <pavel@ucw.cz>, ambx1@neo.rr.com,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
	 <20050731230507.GE27580@elf.ucw.cz>
	 <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
	 <20050731232735.GF27580@elf.ucw.cz>
	 <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> If an interrupt is screaming due to lack of initialization and gets turned
> off, just make sure it gets re-enabled when it is being initialized.
> 

That still doesn't handle the case where a device has an interrupt
handler on a shared IRQ and another device on the chain interrupts it
after it has suspended its device,

we need to either fix *for all drivers* (otherwise people sharing IRQs
will have breakages that people not sharing them won't see ... )

a) add request/free irq sets
b) add code to the interrupt handlers to make sure we aren't in a
powerdown state...

I don't really mind which is the recommended one I'd just prefer we do
it the same way everwhere... so I still believe the yenta_irq patch is
correct if we are doing a, or if not we need to do b....

Dave.
