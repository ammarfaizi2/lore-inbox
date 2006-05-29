Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWE2Nns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWE2Nns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 09:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWE2Nns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 09:43:48 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:34223 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750865AbWE2Nns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 09:43:48 -0400
Message-ID: <447AFA88.1010700@linuxtv.org>
Date: Mon, 29 May 2006 15:43:36 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Jiri Slaby <jirislaby@gmail.com>, Nathan Laredo <laredo@gnu.org>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	 <1148825088.1170.45.camel@praia>	 <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>	 <1148837483.1170.65.camel@praia>  <m3k686hvzi.fsf@zoo.weinigel.se>	 <1148841654.1170.70.camel@praia>  <447AED3B.4070708@linuxtv.org> <1148909606.1170.94.camel@praia>
In-Reply-To: <1148909606.1170.94.camel@praia>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.137.188.36
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all	other
 SAA7146 drivers
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on 29.05.2006 15:33 Mauro Carvalho Chehab said the following:
> On bttv and other boards, were we have such conflicts, we have an option
> to specify what board is used (called card). When the driver locates a
> board without PCI subvendor ID, it shows a help msg at dmesg and exits
> (or load a generic handler). The user may then use card=xx (where xx is
> the number of the board). IMHO, this is the better for saa7146 boards.

bttv is a monolithic driver for all devices using Bt8x8 chipsets,
whereas saa7146 and saa7146_vv only hold the core infrastructure that is
common for all saa7146 cards.

saa7146 does not know anything about a card, but the so-called extension
driver (like mxb, hexium_orion or dpc7146) does. It holds the PCI IDs
and is responsible for telling the system what card it supports and do
any probing if necessary.

I don't know where to put the card=xx parameter in that case, because
the hexium_orion does not know mxb nor dpc7146. 8-(

Since these cards don't have subvendor/subdevice IDs, it's impossible to
find out which card is in the system.

CU
Michael.
