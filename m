Return-Path: <linux-kernel-owner+w=401wt.eu-S1755250AbXABDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbXABDnm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbXABDnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:43:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:51150 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250AbXABDnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:43:41 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: jengelh@linux01.gwdg.de, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
In-Reply-To: <20061231.124531.125895122.davem@davemloft.net>
References: <459714A6.4000406@firmworks.com>
	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
	 <20061231.124531.125895122.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 14:43:26 +1100
Message-Id: <1167709406.6165.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm incredibly surprised how much resistence there is from the
> i386 OFW folks to do this right.  It would be like 80 lines of
> code to suck the device tree into kernel memory, or if they don't
> want to do that they can use inline function wrappers to provide
> the clean C-language interface to all of this and the cost to
> i386-OFW would be zero with the benefit that other platforms could
> use the code potentially.
>
> Doing the same thing 3 different ways, knowingly, is just very bad
> engineering.  That is how you end up with a big fat pile of
> unmaintainable poo instead of a clean maintainable source tree.  If we
> fix a bug in one of these things, the other 2 are so different that if
> the bug is in the others we'll never know and it's not easy to check
> so people won't do it.
> 
> So please do this crap right.

I strongly agree. Nowadays, both powerpc and sparc use an in-memory copy
of the tree (wether you use the flattened format during the trampoline
from OF runtime to the kernel or not is a different matter, we created
that for the sake of kexec and embedded devices with no real OF, but the
end result is the same, a kernel based tree structure).

There is already powerpc's /proc/device-tree and sparc's openpromfs, I'm
all about converging that to a single implementation (a filesystem is
fine) that uses the in-memory tree.

Ben.



