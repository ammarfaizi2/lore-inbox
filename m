Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWAFVi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWAFVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWAFVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:38:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:54151 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750951AbWAFVi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:38:26 -0500
Subject: Re: Platform device matching, & weird strncmp usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060106185352.GG16093@flint.arm.linux.org.uk>
References: <1136527179.4840.120.camel@localhost.localdomain>
	 <20060106185352.GG16093@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 08:38:12 +1100
Message-Id: <1136583493.4840.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 18:53 +0000, Russell King wrote:
> On Fri, Jan 06, 2006 at 04:59:39PM +1100, Benjamin Herrenschmidt wrote:
> > static int platform_match(struct device * dev, struct device_driver * drv)
> > {
> > 	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
> > 
> > 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
> > }
> > 
> > As far as I know, strncmp() is _NOT_ supposed to return 0 if one string
> > is shorter than the other and they match until that point. Thus the
> > above will never match unless the <name> portion of pdev->name is
> > exactly of size BUS_ID_SIZE which is obviously not the case...
> 
> pdev->name is just the <name> part - it's pdev->dev.name which has
> both the <name> and <instance>.  I think the strncmp is unnecessary,
> and it can be replaced by a plain strcmp.

Ah indeed, I got confused by having both strings.

Ben.


