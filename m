Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSKUXWt>; Thu, 21 Nov 2002 18:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSKUXWt>; Thu, 21 Nov 2002 18:22:49 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:3319 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265995AbSKUXWt>;
	Thu, 21 Nov 2002 18:22:49 -0500
Date: Thu, 21 Nov 2002 18:29:49 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Neil Cafferkey <caffer@cs.ucc.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Setting MAC address in ewrk3 driver
Message-ID: <20021121232949.GA4654@www.kroptech.com>
References: <20021121195417.A18859@cuc.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121195417.A18859@cuc.ucc.ie>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 07:54:17PM +0000, Neil Cafferkey wrote:
> Hi,
> 
> I think I may have found a bug in the ewrk3 network driver. When I try to
> change the MAC address of a Digital DE205 NIC using "ifconfig eth0 hw
> ether XX:XX:XX:XX:XX:XX", it appears to work ("ifconfig eth0" reports the
> new address), but in fact it isn't sending or receiving packets any more.
> I'm using kernel version 2.4.10.

Try the driver from 2.4.20-rc2. There are some locking updates in the
ioctl code for setting the hw address. I'm running 2.5 (approx same
driver as 2.4.20-rc2) here and I observe that the address really does
change (i.e. I see packets on the wire with the new MAC addr) but the
kernel oopses shortly thereafter somewhere in the network stack. I'm
blaming this on 2.5 instability for the moment but will fix it if it
turns out to be ewrk3's fault.

--Adam

