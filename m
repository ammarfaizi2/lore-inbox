Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUBNWfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBNWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 17:35:10 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:54199 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263510AbUBNWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 17:35:06 -0500
Subject: Re: [Patch] dma_sync_to_device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402140328350.17970-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0402140328350.17970-100000@notebook.home.mdiehl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Feb 2004 17:34:51 -0500
Message-Id: <1076798095.1611.4.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-14 at 03:51, Martin Diehl wrote:
> Ok, will do.
> 
> Just to make sure I got you right, your concern is people mixing up the 
> effect of this call with some means to sync with posted writes on iomem 
> mapped memory location provided by some device on the bus? I.e. the 
> situation where they probably want to use readl() or similar to force the 
> posted writes to complete in contrast to sync_to_device which ensures the 
> modified system memory gets synced before the busmastering starts?

Yes, that's it.

> If so, wouldn't this concern be related to the pci_dma api as a whole, not 
> only the new pci_dma_sync_to_device call particularly? I mean, none of the 
> api functions to deal with consistent or streaming maps of system memory 
> are applicable for flushing posted writes to iomem on the bus. Maybe the 
> confusion comes from the fact on some archs the pci_dma_sync call would 
> have to flush posted writes _from_ the busmaster device to system memory?

Well ... people did ask, even in the old api.  The excuse always was
that the cache coherency aspect deals exclusively with the CPU cache. 
Now you're adding an API specifically to deal with possible bus caches,
I just wanted it to be crystal clear that you can't use the bus cache
API for flushing posted writes.

James


