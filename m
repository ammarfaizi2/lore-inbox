Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264014AbVCXUK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264014AbVCXUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbVCXUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:10:29 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:43781 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263333AbVCXUIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:08:43 -0500
Date: Thu, 24 Mar 2005 21:09:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-Id: <20050324210906.727543f6.khali@linux-fr.org>
In-Reply-To: <3LFzj-40t-15@gated-at.bofh.it>
References: <3LxV3-5Is-25@gated-at.bofh.it>
	<3LE0y-2Kn-55@gated-at.bofh.it>
	<3LFg5-3MJ-37@gated-at.bofh.it>
	<3LFzj-40t-15@gated-at.bofh.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ho all,

> > Aparently backing out the changes to via's tlb_flush routine fixed
> > it for one VIA user. I've not had a chance to look into it just yet.
> > Worse case we can just drop those changes for 2.6.12

I am that one.

> You mean these changes?
> 
> --- a/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
> +++ b/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
> @@ -83,8 +83,10 @@
>  
>         pci_read_config_dword(agp_bridge->dev, VIA_GARTCTRL, &temp);
>         temp |= (1<<7);
> +       temp &= ~0x7f;
>         pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
>         temp &= ~(1<<7);
> +       temp &= ~0x7f;
>         pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
>  }

Exactlty. I had to revert this one since 2.6.11-bk3, or starting X kills
the machine. By "kill", I mean the real thing, black screen, dead
network, reset is the only choice. This is a (surprise!) VIA-based
motherboard (Asus A7V133-C) with Radeon 9200-based graphics adapter.
Dave Airlie was asking for a tester with such a configuration. I can
test whatever you want. Just tell me what we are looking for :)

With the patch above reverted, 2.6.12-rc1-mm2 seems to work just fine
for me. glxgears is OK and I just had a game of UT (first of the name).
However, I am not a regular gamer so I'm not sure what to look for.

Thanks,
-- 
Jean Delvare
