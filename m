Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVH3D7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVH3D7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVH3D7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:59:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42691 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751124AbVH3D7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:59:35 -0400
Date: Tue, 30 Aug 2005 00:53:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050830035338.GA5755@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4313D4D6.7080108@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 11:39:02PM -0400, Jeff Garzik wrote:
> Marcelo Tosatti wrote:
> >+static int voltage_set(int slot, int vcc, int vpp)
> >+{
> >+	u_int reg = 0;
> >+
> >+	switch(vcc) {
> >+	case 0: break;
> >+	case 33:
> >+		reg |= BCSR1_PCVCTL4;
> >+		break;
> >+	case 50: 
> >+		reg |= BCSR1_PCVCTL5;
> >+		break;
> >+	default: 
> >+		return 1;
> >+	}
> >+
> >+	switch(vpp) {
> >+	case 0: break;
> >+	case 33: 
> >+	case 50:
> >+		if(vcc == vpp)
> >+			reg |= BCSR1_PCVCTL6;
> >+		else
> >+			return 1;
> >+		break;
> >+	case 120: 
> >+		reg |= BCSR1_PCVCTL7;
> >+	default:
> >+		return 1;
> >+	}
> >+
> >+	if(!((vcc == 50) || (vcc == 0)))
> >+		return 1;
> >+
> >+	/* first, turn off all power */
> >+
> >+	*((uint *)RPX_CSR_ADDR) &= ~(BCSR1_PCVCTL4 | BCSR1_PCVCTL5
> >+				     | BCSR1_PCVCTL6 | BCSR1_PCVCTL7);
> >+
> >+	/* enable new powersettings */
> >+
> >+	*((uint *)RPX_CSR_ADDR) |= reg;
> 
> Should use bus read/write functions, such as foo_readl() or iowrite32().

The memory map structure which contains device configuration/registers
is _always_ directly mapped with pte's (the 8xx is a chip with builtin
UART/network/etc functionality).

I don't think there is a need to use read/write acessors.

> Don't use weird types in kernel code such as 'uint'.  Use the more 
> explicitly-sized u32.

OK, will fix the types and address the rest of your comments.

Thanks!
