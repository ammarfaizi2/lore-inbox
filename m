Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVECWhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVECWhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVECWhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:37:07 -0400
Received: from optimus.nocdirect.com ([69.73.171.5]:60068 "EHLO
	optimus.nocdirect.com") by vger.kernel.org with ESMTP
	id S261878AbVECWe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:34:26 -0400
Message-ID: <32958.198.4.83.52.1115159671.squirrel@zuzulu.com>
In-Reply-To: <20050503183335.GA19691@bougret.hpl.hp.com>
References: <20050503183335.GA19691@bougret.hpl.hp.com>
Date: Tue, 3 May 2005 17:34:31 -0500 (CDT)
Subject: Re: [PATCH] dynamic wep keys for airo.c
From: breed@zuzulu.com
To: jt@hpl.hp.com
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>, chessing@users.sourceforge.net
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - optimus.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32338 32338] / [47 12]
X-AntiAbuse: Sender Address Domain - zuzulu.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

There is no patch to xsupplicant that will work without patching the
airo.c driver. The current airo.c driver always disables the MAC before
setting the WEP key whether it is temporary or permanent. This is
incorrect. When the MAC is disabled the card disassociates causing the
whole handshake to start over again.

ben

> Benjamin Reed wrote :
>>
>> I'm resubmitting a patch for the 2.6.11.8 aironet driver (airo.c) that
>> will
>> enable dynamic wep keying without disabling the MAC. It allows
>> us to use xsupplicant with the driver.
>>
>> Aironet provides the ability to set WEP keys permanently or
>> temporarily. There is a special IW_ENCODE_TEMP flag for selecting
>> which type of key you are setting. However, apart from iwconfig,
>> nobody seems to use this flag. When a permanent WEP key is set,
>> the MAC must be disabled. I have added a module parameter to skip
>> disabling the MAC even if a permanent WEP key is set. Using this
>> flag allows xsupplicant to work without modification.
>
>  Hmm... I don't know why you are so afraid of submitting a
> patch to xsupplicant (and wpa_supplicant). Having xsupplicant *always*
> setting IW_ENCODE_TEMP would be worthwhile. Have you even try to
> submit a patch to the author of xsupplicant ?
>  There was other driver having issues with with not reseting
> the MAC while changing the WEP key. For example, some Lucent firmware
> may lock up if you set WEP without fully reseting the MAC. So, having
> IW_ENCODE_TEMP in xsupplicant would mean that the driver could support
> 802.1x properly if the firmware is sane and remain conservative while
> setting static WEP keys, i.e. the best of both words. Driver that are
> sane (moder hardware) can just ignore IW_ENCODE_TEMP.
>  With respect to airo, I think it would be nice if xsupplicant
> did not pollute the WEP EEprom, so that next time you roam to a static
> WEP AP, you can resuse the EEprom keys.
>
>  In summary, I believe that a correct solution is not so
> difficult to implement (just a 2 line patch for xsupplicant and
> wpa_supplicant), therefore I don't beleive we should go with
> workarounds.
>
>  Have fun...
>
>  Jean
>
>

