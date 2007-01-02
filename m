Return-Path: <linux-kernel-owner+w=401wt.eu-S1755263AbXABE6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbXABE6k (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbXABE6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:58:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:47401 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263AbXABE6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:58:39 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
In-Reply-To: <20070101.203043.112622209.davem@davemloft.net>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
	 <20070101.005714.35017753.davem@davemloft.net>
	 <1167710760.6165.32.camel@localhost.localdomain>
	 <20070101.203043.112622209.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 15:57:05 +1100
Message-Id: <1167713825.6165.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think there is high value in an OFW filesystem representation
> that gives you _EXACTLY_ what the OFW command line prompt does
> when you try to traverse the device tree from there, and that
> is what openpromfs tries to do.

Except that every OFW implementation I have here shows you different
things for the same original binary data :-)

> If you want raw access, use a character device or a similar auxilliary
> access to the data items.  Another idea is to provide a seperate file
> operation (such as ioctl) on the OFW property files in order to fetch
> things raw and in binary.
> 
> When I get some binary data out of a procfs or sysfs file I feel like
> strangling somebody.  I'm grovelling around in a filesystem from the
> command line so that I can get some information as a user.  If you
> don't give me text I can't tell what the heck it is.
> 
> Simple system tools should not need to interpret binary data in
> order to provide access to simple structured data like this, that's
> just stupid.

I would agree with you if the data was properly typed in the first place
but it's not, thus you end up with heuristics and I hate heuristics in
the kernel :-) Now, that's also why everybody on ppc has "lsprop" at
hand which does the "pretty printing" thing.

I like being able to have a simple way (ie. tar /proc/device-tree) to
tell user to send me their DT and have in the end an exact binary
representation so I can actually dig for problems, like a wrong phandle
in an interrupt-map or stuff like that...

Cheers,
Ben.


