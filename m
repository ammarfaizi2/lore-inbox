Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269743AbUICTXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269743AbUICTXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbUICTW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:22:59 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:43702 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S269747AbUICTUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:20:01 -0400
Date: Fri, 03 Sep 2004 15:19:57 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
In-reply-to: <1094238777.9913.278.camel@plars.austin.ibm.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Brian Somers <Brian.Somers@Sun.COM>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <4138C3DD.1060005@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
 <200408162049.FFF09413.8592816B@anet.ne.jp>
 <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
 <20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
 <20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
 <20040830161126.585a6b62.davem@davemloft.net>
 <1094238777.9913.278.camel@plars.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Larson wrote:
> I tried this patch alone on top of 2.6.9-rc1 and tg3 is still broken for
> me on JS20 blades.  Was there another patch I should have applied in
> conjunction with this?
>

Is this with or without autonegotiation enabled on the switch?

> Thanks,
> Paul Larson
>
> On Mon, 2004-08-30 at 18:11, David S. Miller wrote:
>
>>Michael Chan at Broadcom spotted the bug.
>>
>>Things are totally broken if the switch/hub does not support
>>autonegotiation.  Checking for the MAC_STATUS_SIGNAL_DET bit
>>in the tg3 polling timer fixes the problem.
>>
>>This is probably why it worked for you and doesn't with the
>>IBM blades as blades are more likely to be connected to
>>non-autoneg'ing devices.
>>
>>===== drivers/net/tg3.c 1.199 vs edited =====
>>--- 1.199/drivers/net/tg3.c	2004-08-18 19:52:35 -07:00
>>+++ edited/drivers/net/tg3.c	2004-08-30 15:08:07 -07:00
>>@@ -5602,7 +5602,8 @@
>> 				need_setup = 1;
>> 			}
>> 			if (! netif_carrier_ok(tp->dev) &&
>>-			    (mac_stat & MAC_STATUS_PCS_SYNCED)) {
>>+			    (mac_stat & (MAC_STATUS_PCS_SYNCED |
>>+					 MAC_STATUS_SIGNAL_DET))) {
>> 				need_setup = 1;
>> 			}
>> 			if (need_setup) {
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOMPcdQs4kOxk3/MRAoJiAJoCZV1AKTQcOiOz0jNX1eZq9ZkiYACfaYDc
lWGl0C2xVNRuPuaKqt8/J90=
=mWO4
-----END PGP SIGNATURE-----
