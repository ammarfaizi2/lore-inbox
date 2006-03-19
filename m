Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWCSSpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWCSSpD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCSSpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:45:03 -0500
Received: from main.gmane.org ([80.91.229.2]:26542 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932162AbWCSSpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:45:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 20:44:38 +0200
Message-ID: <dvk8qa$l8o$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com> <dvjsa6$i92$1@sea.gmane.org> <yw1xslpez928.fsf@agrajag.inprovide.com> <dvk4tv$9j9$1@sea.gmane.org> <yw1xbqw2z50o.fsf@agrajag.inprovide.com> <dvk79k$hf4$1@sea.gmane.org> <yw1x3bhez3gu.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.226
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> It is the BIOS that disables the onboard sound if it detects a PCI
> sound card.  Chances are other vendors use different BIOS
> configurations that do not automatically disable things.  I don't know
> if messing with those bits might do something bad on another board.
> 

Yes, this might be a case, but you never know if ASUS engineers realize that
they can enable the board even if there is a PCI card and will include in
the next bios (as I wrote, they say it is impossible, but you never know).
So checking for ASUS will be wrong starting from that BIOS version.
When I first saw this bug on my system I searched a lot to see if I made a
wrong decision by buying ASUS and not another brand and everywhere on the
forums the same issue was described for other brands as well.

>From the code I would say that 
       pci_read_config_byte(dev, 0x50, &val);
       if (val & 0xc0) {

is the test if it's enabled by the bios or not, as after trying to enable
with 
pci_write_config_byte(dev, 0x50, val & (~0xc0));
it reads again the same byte and checks if the correct bits are enabled.

I see no harm here, but as I said I am not a hardware guy, just a desktop
programmer. ;-)

Andras

-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


