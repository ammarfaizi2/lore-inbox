Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJ1XES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJ1XES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJ1XES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:04:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:2011 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750727AbVJ1XER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:04:17 -0400
Subject: Re: [PATCH] pci device wakeup flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Greg K-H <greg@kroah.com>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       david-b@pacbell.net
In-Reply-To: <Pine.LNX.4.64.0510280730450.4664@g5.osdl.org>
References: <11304810221338@kroah.com> <11304810223093@kroah.com>
	 <20051028035116.112ba2ca.akpm@osdl.org>
	 <Pine.LNX.4.64.0510280730450.4664@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 09:03:45 +1000
Message-Id: <1130540625.29054.136.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 07:31 -0700, Linus Torvalds wrote:
> 
> On Fri, 28 Oct 2005, Andrew Morton wrote:
> > 
> > This is the patch which I've been religiously dropping from -mm because it
> > kills my Mac G5.  What are we doing merging this?
> 
> Well, since my main machine is a Mac G5, we certainly /aren't/ merging it 
> if it kills it.

Yah, that's a known one, the problem is due to the removal of
device_initialize() from pci_device_add(). The breaks the new mecanism
on ppc64 that creates the PCI tree from the firmware instead of probing
the bus. In addition, even with that fixed, the code looking for PME#
will not be run on the pmac neither.

I'm not 100% what is the best fix at this point. I suppose it would be 2
things, let me know what you think about it:

 - Have the ppc64 PCI tree code call device_initialize() itself before
calling pci_device_add()

 - Move the search of PME# (and possibly other similar bits) from probe
to pci_device_add()

 Ben.


