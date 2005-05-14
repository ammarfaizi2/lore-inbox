Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVENLzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVENLzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVENLzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:55:05 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:2994 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262746AbVENLy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:54:58 -0400
Subject: Re: Billionton bluetooth USB: how to make it work
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050514001050.GA1896@elf.ucw.cz>
References: <20050512233902.GA3157@elf.ucw.cz>
	 <1115942337.18499.86.camel@pegasus> <20050513004606.GA1957@elf.ucw.cz>
	 <1115975517.18499.100.camel@pegasus> <20050513101739.GI1780@elf.ucw.cz>
	 <20050514001050.GA1896@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 14 May 2005 13:55:05 +0200
Message-Id: <1116071705.8886.15.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I have no idea what USB have to do with it and why you posted it to
LKML, but it seems you got it.

> Okay, so the magic sequence seems to be:
> 
> # Take 2.6.12-rc3-mm3
> #
> # PCMCIA config:
> # card "Cyber-blue Compact Flash Card"
> #   manfid 0x0279, 0x950b
> #   bind "serial_cs"
> #
> killall hciattach
> sleep .1
> setserial /dev/ttyS4 baud_base 921600
> hciattach -s 921600 /dev/ttyS4 bcsp
> hciconfig
> hciconfig hci0 up
> hciconfig

Verfied with my card and a 2.6.12-rc4.

hci0:   Type: UART
        BD Address: 00:10:60:xx:xx:xx ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <power control> <transparent SCO> 
        HCI 16.14
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

> It took me a hour trying to debug weird stuff before I realized that I
> need to do hciconfig up... to see some results...

Or make sure that hcid is running. It will bring up your device.

Regards

Marcel


