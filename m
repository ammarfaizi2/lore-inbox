Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUHYRtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUHYRtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUHYRtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:49:39 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:58079 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S268182AbUHYRtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:49:11 -0400
Date: Wed, 25 Aug 2004 13:48:49 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
In-reply-to: <20040816143824.15238e42.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Tetsuo Handa <a5497108@anet.ne.jp>, linux-kernel@vger.kernel.org
Message-id: <412CD101.4050406@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
 <200408162049.FFF09413.8592816B@anet.ne.jp>
 <20040816143824.15238e42.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
> On Mon, 16 Aug 2004 20:51:03 +0900
> Tetsuo Handa <a5497108@anet.ne.jp> wrote:
>
>
>> From 2.4.26 till 2.4.27-rc3 were all OK.
>>This trouble happens with 2.4.27-rc4 and later.
>
>
> It's Sun's buggy 5704 Fiber auto-negotiation changes.
>
> Here is a hacky possible fix, can you try it?

Tetsuo posted his lscpi -vv output and he has an A2.  The hardware
autoneg patch was written and tested against an A3.

Would it make sense to do (hand-edited):



===== drivers/net/tg3.c 1.190 vs edited =====
- --- 1.190/drivers/net/tg3.c	2004-07-21 14:14:20 -07:00
+++ edited/drivers/net/tg3.c	2004-08-16 14:24:53 -07:00
@@ -5266,6 +5266,7 @@
 	tw32_f(MAC_LOW_WMARK_MAX_RX_FRAME, 2);

 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
+	    tp->pci_chip_rev_id == CHIPREV_ID_5704_A3 &&
 	    tp->phy_id == PHY_ID_SERDES) {
 		/* Enable hardware link auto-negotiation */
 		u32 digctrl, txctrl;


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
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLNEBdQs4kOxk3/MRAm0rAJwKKfpzuy3EoJuujODZwHPyg8oD/wCfTGiH
Xg4pbO71QGfZFKXGEkJH/IA=
=PA+X
-----END PGP SIGNATURE-----
