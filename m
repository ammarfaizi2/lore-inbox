Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWBRG0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWBRG0F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 01:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBRG0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 01:26:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbWBRG0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 01:26:03 -0500
Date: Fri, 17 Feb 2006 22:24:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brian Hall <brihall@pcisys.net>
Cc: linux-kernel@vger.kernel.org, linux@syskonnect.de
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060217222428.3cf33f25.akpm@osdl.org>
In-Reply-To: <20060217222720.a08a2bc1.brihall@pcisys.net>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Hall <brihall@pcisys.net> wrote:
>
> I have just built a new system, based on an Asrock 939Dual-Sata
>  motherboard. It only has 100MB built-in networking (uli526x), so I
>  purchased a D-Link DGE-560T PCI-e gigabit NIC ($81 at Newegg) thinking
>  it was supported by Linux. Looking at the card, it appears to be a
>  Marvell chip, but neither the sk98lin or skge drivers worked. I tried
>  other GBe drivers as well, they didn't recognize it either.
> 
>  Is there a place where I can just add this card's ID and use one of the
>  sk* drivers? I paged through the source but didn't see an obvious place
>  to add a card ID, but it must be in there somewhere.
> 
>  I'm not subscribed to linux-kernel, please CC: me on replies, thanks.
> 
>  Here's the info from the card:
>  big M on the chip (Marvell I assume)
>  88E8052-NNC
>  GMAA17011A1
>  0442 A2P
> 
>  and on the back of the card:
> 
>  00005A708649 0592
>  DLink
>  531CL00467 DGE-560T 70-13-001-001
> 
>  from lspci:
> 
>  02:00.0 0200: 1186:4b00 (rev 11)
>  	Subsystem: 1186:4b00

See drivers/net/sk98lin/skge.c:skge_pci_tbl[]:

/* DLink card does not have valid VPD so this driver gags
 *	{ PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 */

That's your card, except yours is 0x4b00.

You can try it, but it might gag...

Also see drivers/net/skge.c:skge_id_table[]:

	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, PCI_DEVICE_ID_DLINK_DGE510T), },

That's the same device as in sk98lin/skge.c.  Try adding a line

	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00), },

