Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbUA2NDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 08:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUA2NDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 08:03:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9228 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266093AbUA2NC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 08:02:56 -0500
Date: Thu, 29 Jan 2004 13:02:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
Message-ID: <20040129130251.A23935@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet> <20040128212115.A2027@infradead.org> <Pine.LNX.4.58L.0401282203170.2163@logos.cnet> <20040129090222.A20867@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040129090222.A20867@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jan 29, 2004 at 09:02:22AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 09:02:22AM +0000, Russell King wrote:
> If _any_ PCI ID table which is part registered as part of a driver is
> marked using __devinitdata or __initdata, this will either cause the
> kernel to read invalid data (possibly entering a long loop) or oops.

After doing some more digging, I don't think __devinitdata is a problem
anymore.

There seem to be two scenarios where we look at the PCI device ID tables:

- when a new PCI device is added
- when the drivers newid file is written to

The first case should only ever occur if CONFIG_HOTPLUG is set (and
indeed we only compile PCMCIA/Cardbus if it is.)

The second case is disabled if CONFIG_HOTPLUG is not set.

Therefore, I think marking PCI device ID tables with __devinitdata
should theoretically be fine, but marking them with __initdata is
most definitely unsafe.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
