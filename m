Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUKRTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUKRTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUKRTgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:36:12 -0500
Received: from mail.timesys.com ([65.117.135.102]:18408 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262924AbUKRTey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:34:54 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Andy Fleming <afleming@freescale.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com>
	 <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Nov 2004 14:34:49 -0500
Message-Id: <1100806489.14467.47.camel@jmcmullan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 11:52 -0600, Andy Fleming wrote:
> 1) How should we pass initialization information from the system to the 
> bus.  Information like which irq to use for each PHY, and what the 
> address space for the bus's controls is.  I would like to enforce 
> encapsulation so that the ethernet drivers don't need to know this 
> information, or pass it to the bus.

(Just an off-the-cuff answer here)

In line with the OCP->platform work I've been doing, I would think
that creating 'phy' devices on the platform bus would be appropriate,
with 'platform_data' that describes (a) the platform device ethernet
it's bus is on and (b) it's PHY ID on that bus. The PHY's IRQ would
be in it's platform resources.

> 2) How should we reflect the dependency of the ethernet driver on the 
> mii bus driver?

Hmm. Don't really know from a sysfs perspective...


> 3) How should we bind ethernet drivers to PHY drivers?

A PHY 'platform_data' struct like:

struct phy_device_data {
	struct {
		const char *name;
		int id;
	} ethernet_platform_device_parent;
	int	phy_id;
}
	
> Oh, and a 4th side-issue:
> Should each PHY have its own file? 

Actually, each PHY should have it's own device directory, like every
other device. Eventually, PHYs should have /dev/phy* entries, where
user-space can read/write PHY registers.

-- 
Jason McMullan <jason.mcmullan@timesys.com>
