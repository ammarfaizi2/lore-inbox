Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUHDBSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUHDBSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUHDBSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:18:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56042 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267170AbUHDBSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:18:13 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
Date: Tue, 3 Aug 2004 18:18:02 -0700
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <1091207136.2762.181.camel@rohan.arnor.net> <200408031755.56833.jbarnes@engr.sgi.com> <1091581190.1862.48.camel@gaston>
In-Reply-To: <1091581190.1862.48.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031818.02836.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 5:59 pm, Benjamin Herrenschmidt wrote:
> All this could be very nicely dealt with by the kernel driver.

So what requirements have we collected so far?

  o device selection (presumably domain, bus, slot, function)
    i.e. select the device you'd like to manipulate
    ioctl?
  o per-domain & device VGA enable/disable
    need to disable VGA ports on cards in the same domain and/or bus
    ioctl?
  o legacy port I/O
    for properly routing I/O in multi-domain machines and machines where the
    kernel or firmware may need to trap master aborts
    read/write?
  o legacy memory mapping
    for mapping the legacy VGA framebuffer, may fail
    mmap?

Is that a complete list?  Of course, the interface mechanisms are up for 
debate too.  We might be able to do it with per-bus or per-domain files in 
sysfs for the legacy I/O and memory stuff, but that might not represent the 
fact that legacy devices have interdependencies very well (e.g. VGA ports 
must be disabled on device A before we poke device B, etc.).

Thanks,
Jesse
