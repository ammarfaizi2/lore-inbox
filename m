Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUKSWuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUKSWuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKSWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:48:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:18575 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261671AbUKSWqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:46:53 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: brking@us.ibm.com
Cc: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <419E72EF.4010100@us.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <20041119213232.GB13259@kroah.com>  <419E72EF.4010100@us.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 09:46:42 +1100
Message-Id: <1100904402.3811.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 16:25 -0600, Brian King wrote:

> I thought about that when writing up this patch, but decided against it.
> I figured it was overkill and was going to make the patch more complicated
> than it needed to be to solve the main problem I have seen, which is
> userspace code, usually hotplug/coldplug scripts, reading config space
> when an adapter is running BIST.

How so ? Why would it be more complicated to do the workaround in
drivers/pci/access.c macros instead and not touch all the wrappers ? It
would actually make a much smaller patch...

> If you think there are usages of the pci_bus_* functions in the
> kernel after the adapter device driver gets loaded, from callers other
> than adapter device drivers and userspace APIs, I would have to agree
> with you. I was hoping to keep this patch as simple as possible.
> 
> Having to protect the pci_bus_* functions requires a lookup in these
> functions to find the pci_dev to get the saved_config_space, which
> I was hoping to avoid.
> 
> Ben - do you have any concerns with this limitation for the use you have
> for this set of APIs?

If we ever endup rescanning the bus segment, indeed... I'd rather play
safe, it's easy to move the blocking to the bus access functions and
have the BIST function use the low level bus callbacks directly.

Ben.


