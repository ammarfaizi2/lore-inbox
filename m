Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUHYPmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUHYPmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHYPmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:42:51 -0400
Received: from palrel12.hp.com ([156.153.255.237]:14759 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264903AbUHYPms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:42:48 -0400
Date: Wed, 25 Aug 2004 08:42:37 -0700
From: Grant Grundler <iod00d@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
Message-ID: <20040825154237.GA19447@cup.hp.com>
References: <412AD123.8050605@jp.fujitsu.com> <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org> <1093417267.2170.47.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093417267.2170.47.camel@gaston>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 05:01:08PM +1000, Benjamin Herrenschmidt wrote:
...
> Most drivers already have such a low level lock though, so we may end
> up replacing it with a bridge-based lock... but depending on the architecture,
> that would end up sync'ing lots of drivers on the same lock, which may not
> be good especially if we have no checking to do... 

multiple drivers acquiring the same bridge lock? ugh.

Which bridge sees an error may be a parent (or child) of the PCI bridge
we are monitoring. I suspect we will have to live with multiple
devices being impacted by errors on a bus and the error recovery
notify/resyncronize with all impacted devices.

Does anyone expect to recover from devices attempting unmapped DMA?
Ie an IOMMU which services multiple PCI busses getting a bad DMA address
will cause the next MMIO read by any of the (grandchildren) PCI devices to 
see an error (MCA on IA64). I'm asking only to determine if this is
outside the scope of what the PCI error recovery is trying to support.

> I don't know what is the best thing to do here... The arch is the one to
> know what is the granularity of the error management (per slot ? per segment
> or per domain ?) and so to know what kind of lock is needed...

Yeah...I guess my comments are along the same vein.

grant
