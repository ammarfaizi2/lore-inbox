Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTDGJbR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTDGJbQ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:31:16 -0400
Received: from [203.197.168.150] ([203.197.168.150]:3844 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263366AbTDGJbO (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:31:14 -0400
Message-ID: <3E91488F.1E331C14@tataelxsi.co.in>
Date: Mon, 07 Apr 2003 15:14:47 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: registration function of Cardbus driver
References: <3E913335.96D0DAEA@tataelxsi.co.in> <1049707222.592.17.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:

> On Mon, 2003-04-07 at 10:13, Prasanta Sadhukhan wrote:
> > Hi,
> >     Our Cardbus driver was using register_driver/unregister_driver
> > function  of cb_enabler.c    for registration and unregistration in
> > RH7.1
> > But in RH 8.0 , we are not able to find cb_enabler.o file in
> > /modules/pcmcia directory even when we compile the kernel with PCMCIA
> > CARDBUS support.
>
> If my memory serves me well, you need an external project named
> "pcmcia-cs" that you can download from http://pcmcia-cs.sourceforge.net.
> This project has alternative PCMCIA/CardBus support and it has the
> cb_enabler module you're looking for.
>

We downloaded pcmcia-cs 3.2.4 from the same site and downloaded.
But it will only generate and install cb_enabler.o file if CONFIG_PCMCIA is
disabled in the kernel configuration.
In that case our driver is compiling well but it is is giving Kernel panic
when we are hotplugging it out. The following is the dump
But the driver was working in RH7.1, only in RH 8.0 it is behaving in this
way.

Has some kernel interrupt handling routine has been changed?


[<c28801fe>] cb_release [cb_enabler] 0xee (0xc02e5e38))
[<c2880e20>] bus_table [cb_enabler] 0x0 (0xc02e5e50))
[<c2880268>] cb_event [cb_enabler] 0x5e (0xc02e5e58))
[<c01ab820>] multiwrite_intr [kernel] 0x0 (0xc02e5e64))
[<c286178e>] send_event [pcmcia-core] 0x46 (0xc02e5e88))
[<c2861867>] parse_event [pcmcia-core] 0x11f (0xc02e5eb8))
[<c28876d2>] common_housekeeping [mtok] 0x3a (0xc02e5ecc))
[<c2875db4>] socket [i82365] 0x54 (0xc02e5ed8))
[<c286d211>] pcic_interrupt [i82365] 0x17d (0xc02e5ee8))
[<c0109d5d>] handle_IRQ_event [kernel] 0x3d (0xc02e5f28))
[<c2875d60>] socket [i82365] 0x0 (0xc02e5f30))
[<c0109ee8>] do_IRQ [kernel] 0x78 (0xc02e5f48))
[<c010c378>] call_do_IRQ [kernel] 0x5 (0xc02c5f68))
[<c0113326>] apm_bios_call_simple [kernel] 0x56 (0xc02e5f94))
[<c011330d>] apm_bios_call_simple [kernel] 0x3d (0xc02e5fa0))
[<c0113422>] apm_do_idle [kernel] 0x12 (0xc02e5fbc))
[<c0113543>] apm_cpu_idle [kernel] 0xb3 (0xc02e5fd4))
[<co105000>] stext [kernel] 0x0 (0xc02e5fe4))
[<c0106e8b>] cpu_idle [kernel] 0x1b (0xc02e5fec))

Code: 0f 0b ae 00 9b 5f 22 c0 58 5a e9 7c fe ff ff 90 90 8d b4 26
<0>Kernel panic: Aiee, killing interrupt handler'
In interrupt handler - not syncing

But if we explicitly gives "cardctl eject" and then plug it out then it is not
panicking.Does it mean pcmcia-cs tree does not support hot swappability for
Cardbus.
because we have to explicitly free the resources allocated by pcmcia by "soft
ejecting" and then plug it out.

Please help
Thanks & regards
Prasanta


>
> Linux Registered User #287198
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




