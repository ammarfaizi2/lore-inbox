Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVA1B5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVA1B5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVA1B5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:57:05 -0500
Received: from orb.pobox.com ([207.8.226.5]:14480 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261382AbVA1B5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:57:02 -0500
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100,
	xircom_tulip_cb, iph5526
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: "David S. Miller" <davem@davemloft.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, greg@kroah.com,
       akpm@osdl.org
In-Reply-To: <20050127164843.08bdb307.davem@davemloft.net>
References: <41F952F4.7040804@pobox.com>
	 <20050127225725.F3036@flint.arm.linux.org.uk>
	 <20050127153114.72be03e2.davem@davemloft.net>
	 <20050128001430.C22695@flint.arm.linux.org.uk>
	 <20050127164843.08bdb307.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1106877517.18167.311.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 Jan 2005 17:58:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 16:48, David S. Miller wrote:
> On Fri, 28 Jan 2005 00:14:30 +0000
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > The fact of the matter is that eepro100.c works on ARM, e100.c doesn't.
> > There's a message from me back on 30th June 2004 at about 10:30 BST on
> > this very list which generated almost no interest from anyone...
> 
> I see.  Since eepro100 just uses a fixed set of RX buffers in the
> ring (ie. the DMA links are never changed) it works.

eepro100 does a copy if pkt_len < rx_copybreak, otherwise it send up the
skb and allocates and links a new one in it's place (see
speedo_rx_link).

So I would say e100 and eepro100 are the same for >= rx_copybreak.  Why
does one work and not the other?  Is it because the RFD is aligned in
eepro100?

Russell, what happens with modprobe eepro100 rx_copybreak=0?

-scott

