Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEFpu>; Fri, 5 Jan 2001 00:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEFpk>; Fri, 5 Jan 2001 00:45:40 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:63762 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129183AbRAEFp1>;
	Fri, 5 Jan 2001 00:45:27 -0500
Message-ID: <3A556E47.522FCE7@candelatech.com>
Date: Thu, 04 Jan 2001 23:48:39 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jgarzik@mandrakesoft.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  8139too.c patch to allow setting of MAC address to actually 
 work.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was gleaned from conversations with Donald Becker w/regard
to why:   ifconfig eth1 hw ether a:b:c:d:e:f
fails to work with the RTL drivers.

This fixes the problem, at least on my machine:

(The new line has ### in front of it..)

8139too.c, line 1229, from kernel 2.4.prerelease:

	/* Check that the chip has finished the reset. */
	for (i = 1000; i > 0; i--)
		if ((RTL_R8 (ChipCmd) & CmdReset) == 0)
			break;

	/* Restore our idea of the MAC address. */
###        RTL_W8_F  (Cfg9346, 0xC0); /* Fix provided by Becker */
	RTL_W32_F (MAC0 + 0, cpu_to_le32 (*(u32 *) (dev->dev_addr + 0)));
	RTL_W32_F (MAC0 + 4, cpu_to_le32 (*(u32 *) (dev->dev_addr + 4)));


The 2.2.18 driver is broken too, but I think Donald is going to send
the fixes for it.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
