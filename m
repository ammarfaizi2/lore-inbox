Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWCJAnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWCJAnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWCJAmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:42:54 -0500
Received: from mx.pathscale.com ([64.160.42.68]:61581 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752144AbWCJAfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:44 -0500
Content-Type: multipart/mixed; boundary="===============0088723486=="
MIME-Version: 1.0
Subject: [PATCH 0 of 20] [RFC] ipath driver - another round for review
Message-Id: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:30 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0088723486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

I posted these patches for review this morning, but due to a bug in my
posting script, only Roland actually received them.  In fact, this version
of these patches contains a few changes in response to his comments.

Thanks, Roland!

The original text from this morning follows.

Here is another set of ipath driver patches for review.  The list of
changes compared to the last patch set I posted is huge, so I won't go
into it here.  Suffice it to say that we've taken every reviewer
comment into account, and done a *lot* of work to clean things up.

I'll point out a few things that I think are worth attention.

  - We've introduced support for our PCI Express chips, so the driver
    is no longer HyperTransport-specific.  It's still a 64-bit driver,
    because 32-bit platforms don't implement readq or writeq.  (It
    does compile cleanly on i386, but of course fails to link.)

  - We've added an ethernet emulation driver so that if you're not
    using Infiniband support, you still have a high-performance net
    device (lower latency and higher bandwidth than IPoIB) for IP
    traffic.

  - There are no longer any fixed tables of device structures.
    Instead we allocate device structures dynamically using
    pci_alloc_consistent or dma_alloc_coherent, and use the
    <linux/idr.h> stuff to number them.

  - There are no more ioctls anywhere.

  - Huge source files have been split up into digestible, logical
    chunks.

  - A few more sparse annotations.

  - Buckets of other cleanups.  Code reformatting, comment
    reformatting, trimming code to <= 76 cols, you name it.

There are still a few things left to do that I know of.

  - Since the core driver isn't really an IB driver at all, perhaps it
    belongs in drivers/char instead of drivers/infiniband/hw?

  - Our hardware only supports MSI interrupts.  I don't know how to
    program it to interrupt us if CONFIG_PCI_MSI is not set.  Right
    now, we have a timer-based hack in place to emulate interrupts.

  - Not all of the code is 80- or 76-col clean yet.  I'm working on
    this.

  - I guess we need to face the music and use sysfs binary attributes
    in the two cases where we're not at the moment :-)

  - There's clearly something wrong with the way we're pinning some
    pages into memory, but I don't actually know what it is.  I'm
    pretty sure our use of get_user_pages is correct, so I suspect it
    must be the code that's doing SetPageReserved (see ipath_driver.c
    and ipath_file_ops.c).

    I've spent some time trying to figure out what the problem is, but
    am stumped.  If someone knows what we should be doing instead, I'd
    be delighted to hear from them.

If you have any comments or suggestions, please let me know.

	<b

--===============0088723486==--
