Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbVLOE45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbVLOE45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVLOE45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:56:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:13483 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161051AbVLOE44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:56:56 -0500
Subject: Re: [BUG] Xserver startup locks system... git bisect results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051215043212.GA4479@jupiter.solarsys.private>
References: <20051215043212.GA4479@jupiter.solarsys.private>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 15:53:03 +1100
Message-Id: <1134622384.16880.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 23:32 -0500, Mark M. Hoffman wrote:
> Hello:
> 
> git bisect said:
> > 47807ce381acc34a7ffee2b42e35e96c0f322e52 is first bad commit
> > diff-tree 47807ce381acc34a7ffee2b42e35e96c0f322e52 (from 0e670506668a43e1355b8f10c33d081a676bd521)
> > Author: Dave Airlie <airlied@linux.ie>
> > Date:   Tue Dec 13 04:18:41 2005 +0000
> > 
> >     [drm] fix radeon aperture issue
> 
> With this one applied, my machine locks up tight just after starting the
> Xserver.  Some info (dmesg, lspci, config) is here:
> 
> http://members.dca.net/mhoffman/lkml-20051214/
> 
> I can put a serial console on it if necessary, but not until about this
> time tomorrow.

You have to love this X radeon driver ... you can't fix one bug without
breaking something else, it's one of the worst piece of crap I've ever
seen...

What would be useful now is the X version and maybe trying a little hack
in the X driver. Do you have ways to rebuild the X driver at all ?

The problem is, that patch actually fixes some users... Ah, also, could
you maybe add some printk's around the code that is modified by that
patch and try to catch the value it tries to use before the lockup ?

That is, print the values of:

dev_priv->fb_location

and

RADEON_READ(RADEON_CONFIG_APER_SIZE)

Thanks,
Ben.


