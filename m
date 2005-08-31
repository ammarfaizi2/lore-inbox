Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVHaL03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVHaL03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVHaL03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:26:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34063 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750727AbVHaL02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:26:28 -0400
Date: Wed, 31 Aug 2005 12:26:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalhome@rbcmail.ru>
Cc: linux-kernel@vger.kernel.org,
       Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
Subject: Re: [PATCH] custom PM support for 8250
Message-ID: <20050831122622.B1118@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalhome@rbcmail.ru>,
	linux-kernel@vger.kernel.org,
	Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
References: <43159011.3060206@rbcmail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43159011.3060206@rbcmail.ru>; from vitalhome@rbcmail.ru on Wed, Aug 31, 2005 at 03:10:09PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 03:10:09PM +0400, Vitaly Wool wrote:
> please find the patch that allows passing the pointer to custom power 
> management routine (via platform_device) to 8250 serial driver.
> Please note that the interface to the outer world (i. e. exported 
> functions) remained the same.

I'd rather change the structure passed via the platform device to
something like:

struct platform_serial_data {
	void	(*pm)(struct uart_port *port, unsigned int state, unsigned int old);
	int	nr_ports;
	struct plat_serial8250_port *ports;
};

which also eliminates the empty plat_serial8250_port terminator from
all the serial8250 platform devices (which appears to have caused some
folk problems.)

It does mean that a set of 8250 ports (grouped by each platform device)
have a common power management method - which seems a logical restriction.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
