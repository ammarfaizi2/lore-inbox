Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132063AbRAKT0r>; Thu, 11 Jan 2001 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132648AbRAKT0h>; Thu, 11 Jan 2001 14:26:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3085 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S132063AbRAKT0Z>;
	Thu, 11 Jan 2001 14:26:25 -0500
Message-ID: <3A5E08CE.1F67629@mandrakesoft.com>
Date: Thu, 11 Jan 2001 14:26:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  8139too.c patch to allow setting of MAC address to actually 
 work.
In-Reply-To: <3A556E47.522FCE7@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> This was gleaned from conversations with Donald Becker w/regard
> to why:   ifconfig eth1 hw ether a:b:c:d:e:f
> fails to work with the RTL drivers.
> 
> This fixes the problem, at least on my machine:
> 
> (The new line has ### in front of it..)
> 
> 8139too.c, line 1229, from kernel 2.4.prerelease:
> 
>         /* Check that the chip has finished the reset. */
>         for (i = 1000; i > 0; i--)
>                 if ((RTL_R8 (ChipCmd) & CmdReset) == 0)
>                         break;
> 
>         /* Restore our idea of the MAC address. */
> ###        RTL_W8_F  (Cfg9346, 0xC0); /* Fix provided by Becker */
>         RTL_W32_F (MAC0 + 0, cpu_to_le32 (*(u32 *) (dev->dev_addr + 0)));
>         RTL_W32_F (MAC0 + 4, cpu_to_le32 (*(u32 *) (dev->dev_addr + 4)));
> 
> The 2.2.18 driver is broken too, but I think Donald is going to send
> the fixes for it.

I have updated 8139too to include this and other changes.  The new
version can be downloaded from the SourceForge project page
(http://sourceforge.net/projects/gkernel/), and hopefully it should show
up in a release kernel eventually...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
