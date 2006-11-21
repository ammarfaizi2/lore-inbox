Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934344AbWKUGXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934344AbWKUGXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934341AbWKUGXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:23:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:19614 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S934345AbWKUGXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:23:08 -0500
Subject: Re: bus_id collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061120.221329.74747650.davem@davemloft.net>
References: <1164081736.8207.14.camel@localhost.localdomain>
	 <20061120.221329.74747650.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 17:23:41 +1100
Message-Id: <1164090222.5597.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 22:13 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 21 Nov 2006 15:02:16 +1100
> 
> > This has caused me some trouble with of_platform devices, which are
> > sort-of platform devices but linked to the Open Firmware device-tree, as
> > I generate their names based on the nodes in the tree which need not be
> > unique as long as they are unique under a given parent.
> > 
> > I've worked around it, but I though the comment might need to be
> > clarified.
> 
> BTW Ben, on sparc64 for of devices I use "%08x" and the PROM
> node ID as the bus_id[] to deal with this.

Yes, the phandle would have been a good option... 

Unfortunately, when we defined the simplified device-tree format for use
by platforms without a real Open Firmware (embedded etc...), we made the
phandle optional (the flat device-tree format that we defined doesn't
have it, it's added as an optional property linux,phandle only when a
node needs to be referenced by another one, like interrupt-map's
etc...). Part of the reason there was to please embedded folks who
scream at every single byte added anywhere :-)

I suppose I can still decide that it's also mandatory for nodes that are
to be used as of_platform_device's though... I need to discuss that with
the embedded folks.

(BTW. I still need to look into back-porting some of your changes to
that stuff and possibly having some of that code moved to a common
location... I hope I'll have some time for that early next year).

Ben.


