Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269856AbTGOXCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbTGOXCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:02:00 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:35339 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S269926AbTGOXBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:01:55 -0400
Date: Tue, 15 Jul 2003 18:16:41 -0500
From: Art Haas <ahaas@airmail.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030715231641.GA17444@artsapartment.org>
References: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 12:58:53AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Can you try this patch?  It seems
> 

You're messages seems to have been cut. I should have sent the following
along with my initial posting:

$ lspci -v
00:00.0 Host bridge: ALi Corporation M1531 [Aladdin IV] (rev b3)
	Subsystem: ALi Corporation M1531 [Aladdin IV]
	Flags: bus master, slow devsel, latency 32

00:02.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Flags: bus master, medium devsel, latency 0

00:05.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Flags: bus master, medium devsel, latency 64
	Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at ebff0000 [disabled] [size=64K]

00:06.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
	Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ec00 [size=256]
	Memory at ebfeff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0b.0 IDE interface: ALi Corporation M5229 IDE (rev 20) (prog-if fa)
	Flags: bus master, medium devsel, latency 32
	I/O ports at ffa0 [size=16]

$

If I'm reading the lspci output correctly the patch won't have any effect
on my machine because the m5229 interface is at rev 0x20, so the test in
the if block will succeed and the atapi_dma variable is set to 1 just
like it is currently. I'll still recompile and try if you like; let me
know.

> --- alim15x3.c.orig	2003-04-20 04:49:10.000000000 +0200
> +++ alim15x3.c	2003-07-16 00:39:15.351639072 +0200
> @@ -753,7 +753,8 @@
>  		return;
>  	}
> 
> -	hwif->atapi_dma = 1;
> +	if (m5229_revision <= 0x20)
> +		hwif->atapi_dma = 1;
> 
>  	if (m5229_revision > 0x20)
>  		hwif->ultra_mask = 0x3f;
> 

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
