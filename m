Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbRFBMbh>; Sat, 2 Jun 2001 08:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbRFBMb2>; Sat, 2 Jun 2001 08:31:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:53958 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262545AbRFBMbN>;
	Sat, 2 Jun 2001 08:31:13 -0400
Date: Sat, 2 Jun 2001 14:30:59 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106021230.OAA182199.aeb@vlet.cwi.nl>
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: rtl8139too in 2.4.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My RTL8139 (Identified 8139 chip type 'RTL-8139A')
was fine in 2.4.3 and doesnt work in 2.4.5.
Copying the 2.4.3 version of 8139too.c makes things work again.

Since lots of people complained about this, I have not tried to
debug - maybe a fixed version already exists?

One remark:
2.4.5 says "eth1: media is unconnected, link down, or incompatible connection"
coming from 8139too.c line 1367. The code there is

	if (mii_reg5) {
		printk(KERN_INFO"%s: Setting %s%s-duplex based on"
			" auto-negotiated partner ability %4.4x.\n", dev->name,
			mii_reg5 == 0 ? "" :
			(mii_reg5 & 0x0180) ? "100mbps " : "10mbps ",
			tp->full_duplex ? "full" : "half", mii_reg5);
	} else {
		printk(KERN_INFO"%s: media is unconnected, link down, "
			"or incompatible connection\n",
			dev->name);
	}

where mii_reg5 is tested against zero inside a conditional
where we know that it is nonzero.
Probably the outer test is wrong.

Andries
