Return-Path: <linux-kernel-owner+w=401wt.eu-S1754850AbXABVrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbXABVrh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXABVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:47:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:46944 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbXABVrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:47:36 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
In-Reply-To: <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
	 <20061231.124531.125895122.davem@davemloft.net>
	 <1167709406.6165.6.camel@localhost.localdomain>
	 <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
	 <1167768494.6165.63.camel@localhost.localdomain>
	 <459ABC7C.2030104@firmworks.com>
	 <1167770882.6165.76.camel@localhost.localdomain>
	 <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 08:47:18 +1100
Message-Id: <1167774438.6165.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All should converge on the same interface.  That does not
> ab initio mean we should converge on what you currently
> have (although that might eventually be that case).

Well, Dave and I will happen to be in the same place in a few weeks for
LCA so we might spend some time having a look there if we don't have any
better to do :-)

> Leaving aside the issue of in-memory or not, I don't think
> it is realistic to think any completely common implementation
> will work for this -- it might for current SPARC+PowerPC+OLPC,
> but more stuff will be added over time...

And ? I don't see why a mostly common implementations wouldn't work,
provided that we provide hooks in the right place.

It's pretty clear to me that the actual construction of the in-memory
tree will remain platform specific (powerpc has this flattened format
used for the trampoline for example and so far, I don't think other
platforms plan to use it, though it might be a good idea too :-) sparc
has "issues" related to firmwares that aren't quite OF, etc...)

But it's also clear that the in-kernel representation, accessors and
filesystem could/should be totally identical, including all we build on
top, like prom_parse, of_device/of_platform device stuff etc.. (for
which I need to re-sync with davem too btw, as he did some fixes that I
didn't backport to powerpc... sigh)

The other -one- thing that has to be different is the write back for
properties that can be changed (/options typically) where the write back
mecanism is definitely platform specific.

Ben.


