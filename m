Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVA1AQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVA1AQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVA1APS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:15:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3346 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261335AbVA1AOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:14:42 -0500
Date: Fri, 28 Jan 2005 00:14:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       greg@kroah.com, akpm@osdl.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100, xircom_tulip_cb, iph5526
Message-ID: <20050128001430.C22695@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	greg@kroah.com, akpm@osdl.org
References: <41F952F4.7040804@pobox.com> <20050127225725.F3036@flint.arm.linux.org.uk> <20050127153114.72be03e2.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050127153114.72be03e2.davem@davemloft.net>; from davem@davemloft.net on Thu, Jan 27, 2005 at 03:31:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:31:14PM -0800, David S. Miller wrote:
> Therefore the only missing sync would be of the new RX descriptor
> when linking things in like that, ie. at the end of e100_rx_alloc_skb()
> if rx->prev->skb is non-NULL.

And that is inherently unsafe, since the chip may be modifying the RFD
while the CPU is accessing it.  Adding extra sync calls does not fix
it because as far as I can see, there's nothing to tell the chip "don't
write to this RFD because any changes the CPU is making right now will
overwrite the chips own changes."

The fact of the matter is that eepro100.c works on ARM, e100.c doesn't.
There's a message from me back on 30th June 2004 at about 10:30 BST on
this very list which generated almost no interest from anyone...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
