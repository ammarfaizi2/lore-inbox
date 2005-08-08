Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVHHVj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVHHVj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVHHVjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:39:25 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:13072 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932273AbVHHVjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:39:25 -0400
Date: Mon, 8 Aug 2005 17:38:43 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808213842.GA9010@tuxdriver.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
	ralf@linux-mips.org, linux-kernel@vger.kernel.org,
	linville@redhat.com
References: <20050808.103304.55507512.davem@davemloft.net> <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com> <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808194249.GA6729@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:42:49PM -0700, Greg KH wrote:
> On Mon, Aug 08, 2005 at 12:32:09PM -0700, David S. Miller wrote:

> > And lo' and behold, we find the answer in the PCI probing code.
> > It initializes every PCI device's PCI power state to "unknown":
> >  
> > 	/* "Unknown power state" */
> > 	dev->current_state = 4;
> > 
> > and thus makes this test ">= D3hot" pass in the pci_set_power_state()
> > code.
> 
> Crap, gotta love >= checks on enumerated types...

The "dev->current_state = 4" is what prompted the ">= D3hot" in the
first place... :-)

I had seen a patch from earlier this year that changed the probing
code to actually get the power state from the device (and added a
pci_get_power_state API).  I don't know why that never got merged,
but since it didn't I had to account for the case of the power state
being unknown (i.e dev->current_state == 4).

So, w/ Dave's patch for Sparc64 to use setup-res.c, does the patch
stay?  Is there anything else I need to do?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
