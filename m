Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWE2MpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWE2MpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWE2MpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:45:17 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:54692 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750799AbWE2MpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:45:15 -0400
Message-ID: <447AECC6.60408@linuxtv.org>
Date: Mon, 29 May 2006 14:44:54 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>, video4linux-list@redhat.com,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Laredo <laredo@gnu.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	<1148825088.1170.45.camel@praia>	<d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>	<1148837483.1170.65.camel@praia> <m3k686hvzi.fsf@zoo.weinigel.se>
In-Reply-To: <m3k686hvzi.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 84.137.188.36
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all other
 SAA7146 drivers
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry for jumping into this thread so late.

on 28.05.2006 19:58 Christer Weinigel said the following:
> Mauro Carvalho Chehab <mchehab@infradead.org> writes:
>>Em Dom, 2006-05-28 às 09:01 -0700, Nathan Laredo escreveu:

> dpc7146, hexium_orion and mxb don't match all PCI IDs, they only match
> boards with zero as a board ID.  So they won't conflict with
> non-broken boards that have valid subvendor IDs.  But they will
> conflict with each other.

That's unfortunately right.

> How may of these boards are broken and have zeroes in the
> subvendor/subdevice fields?  Apparently some of the dpc7146f,
> hexium_orion, mxb, and stradis boards are broken.

I would not call them broken.

They simply don't have subvendor/subdevice informations, but when these
informations are requested, the card gives back zeroes.

>  How many of the
> boards supported by the generic saa7146 driver are broken the same
> way?

I can confirm this for the dpc7146, the mxb and the hexium_orion.

> This still needs solving properly, but at least it makes it less of
> a problem for people with non-broken hardware.

Up to now, this problem did not show up so drastically. On the one hand,
just a few dozen people use the MXB, a handful use the hexium_orion and
the dpc7146 is really rare. All these users then simply tweaked their
environment so that it works for the next boot.

In order to fix this, these drivers should not be autoloaded because
there is no sane way to autodetect these cards. In theory, you could do
an i2c bus scan and check if all devices are there. But since MXB and
dpc7146 both use the saa7111 video decoder on address 0x11 IIRC, the
dpc7146 will grab any MXB device if loaded before.

Distributions probably should keep these drivers from being autoloaded.

>   /Christer

Best regards
Michael.
