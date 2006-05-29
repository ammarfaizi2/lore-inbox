Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWE2Wva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWE2Wva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWE2Wva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:51:30 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:46481 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S932070AbWE2Wv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:51:29 -0400
To: Michael Hunold <hunold@linuxtv.org>
Cc: Christer Weinigel <christer@weinigel.se>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       video4linux-list@redhat.com, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Nathan Laredo <laredo@gnu.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	<1148825088.1170.45.camel@praia>
	<d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
	<1148837483.1170.65.camel@praia> <m3k686hvzi.fsf@zoo.weinigel.se>
	<447AECC6.60408@linuxtv.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 30 May 2006 00:51:28 +0200
In-Reply-To: <447AECC6.60408@linuxtv.org>
Message-ID: <m3fyisigwf.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> writes:

> Up to now, this problem did not show up so drastically. On the one hand,
> just a few dozen people use the MXB, a handful use the hexium_orion and
> the dpc7146 is really rare. All these users then simply tweaked their
> environment so that it works for the next boot.
> 
> In order to fix this, these drivers should not be autoloaded because
> there is no sane way to autodetect these cards. In theory, you could do
> an i2c bus scan and check if all devices are there. But since MXB and
> dpc7146 both use the saa7111 video decoder on address 0x11 IIRC, the
> dpc7146 will grab any MXB device if loaded before.

Ouch.   Oh well, that means that those cards will need some kind of
manual intervention.

> Distributions probably should keep these drivers from being autoloaded.

I'm not too sure of how the module autoloading works, but would it
help just remove the line with:

    MODULE_DEVICE_TABLE(pci, pci_tbl);

from those drivers?  If I understand correctly, the contens of
MODULE_DEVICE_TABLE is what ends up in modules.pcimap.  That should
fix it for most distributions and the owners of those cards have to
add a manual modprobe command to their rc.local.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
