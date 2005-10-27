Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVJ0QhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVJ0QhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJ0QhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:37:02 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:26299 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751237AbVJ0Qg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:36:59 -0400
Date: Thu, 27 Oct 2005 10:36:58 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rolandd@cisco.com>
Cc: gregkh@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20051027163658.GA8201@parisc-linux.org>
References: <524q799p2t.fsf@cisco.com> <20051022233220.GA1463@parisc-linux.org> <52hdb3yp36.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdb3yp36.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 08:08:45AM -0700, Roland Dreier wrote:
>     Matthew> Perhaps the right thing to do is to change pad2 (in
>     Matthew> struct pci_bus) to bus_flags and make bit 0
>     Matthew> PCI_BRIDGE_FLAGS_NO_MSI ?
> 
> Seems reasonable, but I'm still not sure how to implement this.  Where
> does this bit get set and propagated to secondary buses?

We can propagate it to secondary busses in pci_alloc_child_bus().
We inherit parent->ops and parent->sysdata at this point, we can also
inherit parent->whatever_flags_we_like.

Setting it from the quirk is a bit more yucky.  I *think* we're going
to have to walk the PCI tree, given that it's a FIXUP_FINAL.  Maybe it
needs to not be a FIXUP_FINAL ... a FIXUP_HEADER might get it set early
enough for it to propagate through that mechanism.
