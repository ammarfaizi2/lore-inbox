Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267834AbUG3U1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267834AbUG3U1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUG3U1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:27:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38617 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267831AbUG3U0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:26:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Martin Mares <mj@ucw.cz>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 13:25:53 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040730194634.GA4851@ucw.cz> <20040730201052.GA5249@ucw.cz> <20040730201357.GA5391@ucw.cz>
In-Reply-To: <20040730201357.GA5391@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301325.53695.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 1:13 pm, Martin Mares wrote:
> > Do I understand it correctly that the ROM-in-sysfs hack is intended only
> > for debugging? If it is so, I do not see why we should do anything
> > complicated in order to avoid root shooting himself in the foot.
>
> ... for which the config space access code already sets the precedent --
> there exist (rare) devices which have configuration registers with side
> effects on reads, making it possible to produce SCSI errors or even crash
> the system by just dumping the config space. Even on these devices, the
> kernel does not attempt to forbid reading of these registers via sysfs.

Well, this is what I initially argued with willy...

I think typical usage will be:
  o dri fires off hotplug event
  o userland card POSTing tool reads the ROM, saving it off for future use,
    and POSTs the card
  o userland tool calls back into dri saying that the card is ready
  o dri driver operates happily

So dealing with users accessing the rom file after a driver is up and running 
may not be worth the trouble.

Jesse
