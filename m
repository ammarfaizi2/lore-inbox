Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUHWUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUHWUYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUHWUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:23:47 -0400
Received: from ee.oulu.fi ([130.231.61.23]:7413 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S267490AbUHWTeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:34:18 -0400
Date: Mon, 23 Aug 2004 22:34:16 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 4401 problem
Message-ID: <20040823193416.GA21390@ee.oulu.fi>
References: <20040822205346.GA17895@em.ca> <20040822221734.GA10372@ee.oulu.fi> <20040823155712.GA21840@em.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040823155712.GA21840@em.ca>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 09:57:12AM -0600, Bruce Guenter wrote:
> On Mon, Aug 23, 2004 at 01:17:34AM +0300, Pekka Pietikainen wrote:
> > Could you try the driver from http://www.ee.oulu.fi/~pp/b44-095-2.tgz ,
> > which has some fixes that have been submitted but not yet merged.
> In order to try to get it to compile, I removed the PCI table entry for
> the BCM4713 and made every conditional that depends on it false (by
> removing the appropriate code).  However, when trying to ifconfig the
> interface I get:
> 	SIOCSIFFLAGS: Cannot allocate memory
> 	SIOCSIFFLAGS: Cannot allocate memory
Oh right... Yea, the code assumes that someone added the 4713 id (0x4713 ;)
) to pci_ids.h. Interesting that it runs out of memory though. The new
version does use quite a bit of GFP_DMA (== memory under 16MB since there's
no way of allocating memory under 1GB, which would do.). Apart from some
legacy ISA stuff I don't think anything else should be sucking it up, so
there should be enough, at least after a fresh boot.
> > If that
> > doesn't help, the broadcom driver 
> > ( http://www.broadcom.com/drivers/downloaddrivers.php ) might be
> > worth a try.
> The Broadcom Linux driver version 3.0.7 also locks up on me, but it
> doesn't support "ethtool -A", so I have to stop and start the interface
> completely to get it working again.
Whew, maybe it's not a driver issue. Only thing I can think of is trying a
few different kernels (say 2.6.7, 2.4.x if that fails), acpi=off, pci=noacpi
on the command line etc.

-- 
Pekka Pietikainen
