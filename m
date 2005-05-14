Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVENURn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVENURn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVENURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 16:17:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43240 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261483AbVENURk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 16:17:40 -0400
Date: Sat, 14 May 2005 22:17:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF: how to make it work
Message-ID: <20050514201759.GA3598@elf.ucw.cz>
References: <20050512233902.GA3157@elf.ucw.cz> <1115942337.18499.86.camel@pegasus> <20050513004606.GA1957@elf.ucw.cz> <1115975517.18499.100.camel@pegasus> <20050513101739.GI1780@elf.ucw.cz> <20050514001050.GA1896@elf.ucw.cz> <1116071705.8886.15.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116071705.8886.15.camel@pegasus>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have no idea what USB have to do with it and why you posted it to
> LKML, but it seems you got it.

Oops, that was typo, I meant "Billionton bluetooth CF". I posted lkml
so that it gets archived on easy-to-search place.

> > Okay, so the magic sequence seems to be:
> > 
> > # Take 2.6.12-rc3-mm3
> > #
> > # PCMCIA config:
> > # card "Cyber-blue Compact Flash Card"
> > #   manfid 0x0279, 0x950b
> > #   bind "serial_cs"
> > #
> > killall hciattach
> > sleep .1
> > setserial /dev/ttyS4 baud_base 921600
> > hciattach -s 921600 /dev/ttyS4 bcsp
> > hciconfig
> > hciconfig hci0 up
> > hciconfig
> 
> Verfied with my card and a 2.6.12-rc4.

Good. [Actually it does *not* work for me in -rc4, but it seems to be
pcmcia problem.]

> hci0:   Type: UART
>         BD Address: 00:10:60:xx:xx:xx ACL MTU: 192:8 SCO MTU: 64:8
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
>                 <power control> <transparent SCO> 
>         HCI 16.14
>         Chip version: BlueCore02-External
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> > It took me a hour trying to debug weird stuff before I realized that I
> > need to do hciconfig up... to see some results...
> 
> Or make sure that hcid is running. It will bring up your device.

Yes, I was just confused. I'm normally only starting hcid just before
talking to the phone, and I did not try it when I was BD address of
all zeros.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
