Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJAGyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTJAGyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:54:08 -0400
Received: from yate.wa.csiro.au ([130.116.131.40]:16901 "EHLO
	yate.nexus.csiro.au") by vger.kernel.org with ESMTP id S262009AbTJAGyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:54:03 -0400
Subject: i7505 locks up too (Was: iTyan i7501 Pro (S2721-533) lock-up
	(e1000?))
From: Frank Horowitz <frank.horowitz@csiro.au>
To: linux-kernel@vger.kernel.org
Cc: jfbeam@bluetronic.net
Content-Type: text/plain
Message-Id: <1064991240.2271.70.camel@bonzo.ned.dem.csiro.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 14:54:00 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam writes:

> I have a pair of these critters (one single, one dual Xeon) that
> constantly
> lock up with any volume of traffic hits them. It doesn't appear to
> matter
> which kernel version (2.4.20, 2.6.0 bk+) -- they all eventually
> lockup.
> 
> I've tried with "acpi=off", "pci=noacpi", etc. In gig mode, it'll
> lockup
> within seconds (with 25Mbps thrown at it.) In 100M/Full, it'll last a
> few minutes. And at 100M/half, it'll last hours. Of course, they're
> being ultra helpful by simply freezing without a single blip of why.
> 
> Anyone else seeing similar problems with the i7501 pro?

I'm seeing a similar problem with a (bunch of) Supermicro i7505 boards
(X5DAL-G's if it matters). All with e1000 onboard (but running at
100Mbps full-duplex through Cisco 2900-series and 4000-series switches).
All locking up under heavy load (openMosix process migrations). 

All are running 2.4.x series kernels, patched with matching openMosix
versions.

The problem persists with vanilla kernel e1000 drivers, or the latest
from the intel site.

All boxes have had their physical cat5e cabling tested and are showing
within spec. 

Moshe Bar (lead developer on openMosix) claims that the instability
behaviors I am seeing are "almost always" networking related.

AFAIK, the two chipsets share the 82870P2 PCI/PCI-X Controller Hub2 (AKA
P64H2). In my Supermicro boards, the e1000 (82545EM) hangs directly off
of the P64H2 (according to the boards' block diagram). After downloading
your board's manual from Tyan, I see that you have a dual e1000 chip
(82546) hanging directly off of the P64H2 also. 

Obviously, the MCH's differ (one being the E7501 and the other being the
E7505).

All boxes have had memtest86 run on them with repeated passes and are
showing fine.
 
The i7505s have 82801DB's onboard (AKA ICH4) while the i7501s have
82801CA's onboard (AKA ICH3).  Question: You aren't by any chance seeing
funkiness showing up as IDE problems, are you? This would point towards
ICH* problems (too?)...

I'm obviously delighted to help anyone with better kernel debugging
skills than I have to try and track this problem down. It's making life
pretty unbearable with instability in our openMosix cluster.

	Cheers,
		Frank
 

