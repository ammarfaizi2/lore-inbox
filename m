Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVECSeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVECSeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVECSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:34:22 -0400
Received: from palrel12.hp.com ([156.153.255.237]:39635 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261558AbVECSdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:33:44 -0400
Date: Tue, 3 May 2005 11:33:35 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@zuzulu.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, chessing@users.sourceforge.net
Subject: Re: [PATCH] dynamic wep keys for airo.c
Message-ID: <20050503183335.GA19691@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Reed wrote :
> 
> I'm resubmitting a patch for the 2.6.11.8 aironet driver (airo.c) that will 
> enable dynamic wep keying without disabling the MAC. It allows 
> us to use xsupplicant with the driver.
> 
> Aironet provides the ability to set WEP keys permanently or 
> temporarily. There is a special IW_ENCODE_TEMP flag for selecting
> which type of key you are setting. However, apart from iwconfig, 
> nobody seems to use this flag. When a permanent WEP key is set, 
> the MAC must be disabled. I have added a module parameter to skip
> disabling the MAC even if a permanent WEP key is set. Using this 
> flag allows xsupplicant to work without modification.

	Hmm... I don't know why you are so afraid of submitting a
patch to xsupplicant (and wpa_supplicant). Having xsupplicant *always*
setting IW_ENCODE_TEMP would be worthwhile. Have you even try to
submit a patch to the author of xsupplicant ?
	There was other driver having issues with with not reseting
the MAC while changing the WEP key. For example, some Lucent firmware
may lock up if you set WEP without fully reseting the MAC. So, having
IW_ENCODE_TEMP in xsupplicant would mean that the driver could support
802.1x properly if the firmware is sane and remain conservative while
setting static WEP keys, i.e. the best of both words. Driver that are
sane (moder hardware) can just ignore IW_ENCODE_TEMP.
	With respect to airo, I think it would be nice if xsupplicant
did not pollute the WEP EEprom, so that next time you roam to a static
WEP AP, you can resuse the EEprom keys.

	In summary, I believe that a correct solution is not so
difficult to implement (just a 2 line patch for xsupplicant and
wpa_supplicant), therefore I don't beleive we should go with
workarounds.

	Have fun...

	Jean

