Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTI3O1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTI3O1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:27:49 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:50751 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S261507AbTI3O1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:27:47 -0400
Date: Tue, 30 Sep 2003 16:27:31 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test6] Troubles with ALSA via82xx
Message-ID: <20030930142731.GA3406@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhe2ubner.wl@alsa2.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nell'articolo <s5hhe2ubner.wl@alsa2.suse.de> hai scritto:
>At Mon, 29 Sep 2003 19:04:37 +0200,
>Kronos wrote:
>> 
>> Hi,
>> 
>> I have trouble with linux-2.6.0-test6 and via82xx. With default
>> parameters I'm unable to play sound. I've tracked down the problem to
>> this change:
>> 
>>    - use dxs_support=3 (48k fixed) as default, since there are so many
>>      problems with dxs_support=0.
>> 
>> Loading module I see this:
>> 
>> via82xx: Assuming DXS channels with 48k fixed sample rate.
>>          Please try dxs_support=1 option and report if it works on your machine.
>> PCI: Setting latency timer of device 0000:00:11.5 to 64
>
>please try the attached patch?
>
>diff -u -r1.60 via82xx.c
>--- linux/sound/pci/via82xx.c	22 Sep 2003 10:10:29 -0000	1.60
>+++ linux/sound/pci/via82xx.c	30 Sep 2003 10:02:13 -0000
>@@ -2038,16 +2038,17 @@
>				break;
> 			}
> 		}
>-		if (dxs_support[dev] == VIA_DXS_AUTO)
>-			dxs_support[dev] = check_dxs_list(pci);
>-		/* force to use VIA8233 or 8233A model according to
>-		 * dxs_support module option
>-		 */
>-		if (dxs_support[dev] == VIA_DXS_DISABLE)
>-			chip_type = TYPE_VIA8233A;
>-		else
>-			chip_type = TYPE_VIA8233;
>-
>+		if (chip_type != TYPE_VIA8233A) {
>+			if (dxs_support[dev] == VIA_DXS_AUTO)
>+				dxs_support[dev] = check_dxs_list(pci);
>+			/* force to use VIA8233 or 8233A model according to
>+			 * dxs_support module option
>+			 */
>+			if (dxs_support[dev] == VIA_DXS_DISABLE)
>+				chip_type = TYPE_VIA8233A;
>+			else
>+				chip_type = TYPE_VIA8233;
>+		}
> 		if (chip_type == TYPE_VIA8233A)
> 			strcpy(card->driver, "VIA8233A");
> 		else
>

Great, now it works! Thank you.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Quando un uomo porta dei fiori a sua moglie senza motivo, 
un motivo c'e`.
