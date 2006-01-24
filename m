Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWAXEmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWAXEmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWAXEmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:42:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11716
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030327AbWAXEmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:42:39 -0500
Date: Mon, 23 Jan 2006 20:42:13 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Carlo E. Prelz" <fluido@fluido.as>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060124044213.GA22270@kroah.com>
References: <20060120123202.GA1138@epio.fluido.as> <20060122074034.GA1315@epio.fluido.as> <20060121235546.68f50bd5.akpm@osdl.org> <200601231101.25268.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601231101.25268.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 11:01:25AM -0800, David Brownell wrote:
> This moves the previously widely-used ehci-pci.c BIOS handoff
> code into the pci-quirks.c file, replacing the less widely used
> "early handoff" version that seems to cause problems lately.
> 
> One notable change:  the "early handoff" version always enabled
> an SMI IRQ ... and did so even if the pre-Linux code said it was
> not using EHCI (and not expecting EHCI SMIs).  Looks like a goof
> in a workaround for some unknown BIOS version.
> 
> This merged version only forcibly enables those IRQs when pre-Linux
> code says it's using EHCI.  And now it always forces them off "just
> in case".

Thanks for posting this, it fixes my EHCI + APIC error, and makes my
laptop work just fine.

Turns out that 2.6.14 worked for it, but 2.6.15 didn't.  git bisect a
zillion times later narrowed it down to the usb early handoff stuff but
due to merge issues, it was tough to track down the exact patch.

For fun I tried this one on top of the latest -mm, and it works!

So, care to clean it up to make it feel better to you and send it to me
again so I can add it to my tree?  I know the next SuSE kernel will need
it :)

thanks,

greg k-h
