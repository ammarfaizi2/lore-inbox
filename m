Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUBGGL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUBGGL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:11:56 -0500
Received: from fmr04.intel.com ([143.183.121.6]:52707 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266475AbUBGGLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:11:53 -0500
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
From: Len Brown <len.brown@intel.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E89C2@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E89C2@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076134307.2562.1553.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Feb 2004 01:11:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you isolate this regression to a specific release?  There have been
several changes to arch/i386/kernel/irq.c since 2.6.0-test7.  Also, it
would be interesting to know if it also happens with CONFIG_SMP=n (but
with the IOAPIC still enabled)  Plus, a sanity check of the rate of
interrutps reported by /proc/interrupts might yield a clue.

thanks,
-Len

ps.
You can avoid the symptom by booting with "noirqdebug" or having the
interrupt handling always return IRQ_HANDLED.  But then we'd lose the
means to find out why the driver is receiving interrupts for which it
can find no cause.

On Fri, 2004-02-06 at 23:42, Daniel Jacobowitz wrote:
> I've started getting this, every 24 hours or so:
> 
> irq 19: nobody cared!
> Call Trace:
>  [<c010d38a>] __report_bad_irq+0x2a/0x90
>  [<c010d480>] note_interrupt+0x70/0xb0
>  [<c010d7c0>] do_IRQ+0x160/0x1a0
>  [<c0105000>] _stext+0x0/0x60
>  [<c010b8d8>] common_interrupt+0x18/0x20
>  [<c0108990>] default_idle+0x0/0x40
>  [<c0105000>] _stext+0x0/0x60
>  [<c01089bc>] default_idle+0x2c/0x40
>  [<c0108a4b>] cpu_idle+0x3b/0x50
>  [<c04b64a0>] unknown_bootoption+0x0/0x120
>  [<c04b6926>] start_kernel+0x1a6/0x1f0
>  [<c04b64a0>] unknown_bootoption+0x0/0x120
> 
> handlers:
> [<f886b290>] (au_isr+0x0/0xb0 [au8830])
> Disabling IRQ #19
> 
> and then sound doesn't work for a while.
> 
> There's a good chance this is my fault.  IRQ 19 is:
> 
>  19:   18500001          0   IO-APIC-level  au88xx
> 
> and the au88xx driver is an out-of-tree driver that was developed on
> 2.4/early-2.5, and I ported it to 2.6 myself.  It worked flawlessly on
> 2.6.0-test7; has something changed in how interrupt handlers are
> required to
> behave?
> 
> [Just ask if you actually want the source to this driver... I don't
> know
> enough about the card to actually submit it to Linus's tree and the
> driver's
> original authors aparently didn't care to.]
> 
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

