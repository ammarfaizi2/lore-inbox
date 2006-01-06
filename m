Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWAFSx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWAFSx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWAFSx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:53:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3345 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751588AbWAFSx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:53:58 -0500
Date: Fri, 6 Jan 2006 18:53:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Platform device matching, & weird strncmp usage
Message-ID: <20060106185352.GG16093@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1136527179.4840.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136527179.4840.120.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:59:39PM +1100, Benjamin Herrenschmidt wrote:
> static int platform_match(struct device * dev, struct device_driver * drv)
> {
> 	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> 
> 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
> }
> 
> As far as I know, strncmp() is _NOT_ supposed to return 0 if one string
> is shorter than the other and they match until that point. Thus the
> above will never match unless the <name> portion of pdev->name is
> exactly of size BUS_ID_SIZE which is obviously not the case...

pdev->name is just the <name> part - it's pdev->dev.name which has
both the <name> and <instance>.  I think the strncmp is unnecessary,
and it can be replaced by a plain strcmp.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
