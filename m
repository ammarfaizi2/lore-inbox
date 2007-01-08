Return-Path: <linux-kernel-owner+w=401wt.eu-S1750978AbXAHVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXAHVTp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXAHVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:19:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:35931 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbXAHVTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:19:44 -0500
Subject: Re: 2.6.20-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	 <200701051723.08112.m.kozlowski@tuxland.pl>
	 <1168030536.22458.28.camel@localhost.localdomain>
	 <20070105131516.bd9d8f45.akpm@osdl.org>
	 <1168032284.22458.33.camel@localhost.localdomain>
	 <20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 08:19:18 +1100
Message-Id: <1168291158.22458.224.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The idea behind this is to have a probing thread for each device that
> does the actual work (call probe for the matching drivers) so that
> multiple devices can be probed in parallel. The decision to do this can
> only be made at the bus level.
> 
> Previously, the code made it possible to have a probing thread for each
> matching driver for the same device in parallel. I didn't see any
> benefit in that, but maybe I'm just dense...

Hrm... I see. Well, I was using it from the driver because I have a
driver that needs to wait in it's probe() routing for another driver to
show up for another device (they are linked in some ways, but that is
not expressed via bus bindings).

I suppose I'll just have probe() fire off a kthread instead.

Cheers,
Ben.


