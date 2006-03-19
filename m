Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWCSPLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCSPLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWCSPLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:11:21 -0500
Received: from main.gmane.org ([80.91.229.2]:34026 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932105AbWCSPLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:11:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 17:11:13 +0200
Message-ID: <dvjsa6$i92$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.146
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> This is the interesting bit.  Curiously enough, it is exactly the same
> as mine.  I can't see any reason why it shouldn't match on your board.
> 
> Try sticking some printk()s in there and find out what values are
> actually seen.


I found why it didn't work on my PC before. I wrote that I not only enabled
for every PCI id, but removed the following check:

      if (likely(!asus_hides_ac97))
                return;

This was the bit which made it work. After putting some debugging
information it turned out that asus_hides_ac97_lpc was called *before*
asus_hides_ac97_device, so the asus_hides_ac97 remained 0 in that check.

As far as I know this problem appears on all VT8237 boards (I found in
several forums), I suggest to completely drop the asus_hides_ac97_device
function and the above if clause.

See the debug outputs:

Inside asus_hides_ac97_lpc
asus_hides_ac97=0
device: 0x3227
PCI: enabled onboard AC97/MC97 devices
Inside asus_hides_ac97_device
vendor 0x1043
device 0x3227

Andras


-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


