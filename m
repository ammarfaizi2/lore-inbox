Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTL2Tvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbTL2Tuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:50:39 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:13440 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263937AbTL2TsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:48:21 -0500
Date: Mon, 29 Dec 2003 14:37:11 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20031229143711.GA3176@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Amit Gurdasani <amitg@alumni.cmu.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312261610200.1798@athena>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 04:51:53PM +0400, Amit Gurdasani wrote:
> I have a PROLiNK 1456VH internal Rockwell-based ISA PnP K56flex fax modem
> whose EISA ID seems not to be known to 8250_pnp.c. The ID is AEI0250 as
> reported in /sys/devices/pnp1/01:01/01:01.00/id and adding this into the
> pnp_dev_table[] allows the device to be found and enabled properly by the
> 8250 serial driver.
>
> A query: I'm using the serial IRQ autodetection and sharing support. In
> 2.4.23, the serial driver was able to get the first serial port (ttyS0) and
> this modem (ttyS2) to share IRQ 4. Now this is not happening, and each port
> (and modem) is claiming a unique IRQ. Am I doing anything wrong?

Without special hardware modifications, it is usually unsafe to share irqs
between isa devices.

>
> The reason I ask is that I also have a jumpered SB16 on IRQ 5, and loading
> the 8250 driver before the snd_sb16 driver results in the SB16's IRQ being
> allocated for the modem, which prevents the SB16 driver from loading.
> Loading the SB16 driver first results in resource starvation for the modem,
> and the 8250 driver is only able to set up the onboard serial ports ttyS0
> and ttyS1.

You may want to try changing the jumper on your SB16 to allow for PnP
autoconfiguration.

>
> In the meantime, I'm using the isapnptools to set up the modem with IRQ 4
> before loading either driver. The result is that the SB16 driver gets IRQ 5
> as needed, and ttyS0 is set up with IRQ 0 (is this OK?), but I'd really like
> to use the kernel ISA PnP support.

Could I please see a copy of your /proc/interrupts.

>
> (Kernel 2.4.23's kernel ISA PnP support and serial driver would
> automatically assign IRQ 4 to both ttyS0 and the modem [ttyS2].)

The 2.4 series was not always aware of motherboard devices such as serial ports.
Were you able to use ttyS0 and your modem at the same time?

Thanks,
Adam
