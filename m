Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUFJQJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUFJQJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUFJQJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:09:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:47271 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261897AbUFJQJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:09:49 -0400
Subject: Re: hdc (cdrom) irq timeout after awaking from sleep on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1086847896.24317.41.camel@localhost>
References: <1086847896.24317.41.camel@localhost>
Content-Type: text/plain
Message-Id: <1086883699.2975.141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 11:08:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-10 at 01:11, Soeren Sonnenburg wrote:
> Hi...
> 
> When I insert + mount a cdrom and then put this powerbook to sleep mode,
> I keep getting these messages in the kernel log when the machine wakes
> up. However I can still access the cdrom on its mount point as if
> everything was ok... but is it ?

Well... at least it lost the DMA which isn't good. But our driver tends
to be a bit nasty for that. We may probably want a smarter wakeup
sequence for ide-cd that the current one that does nothing (just use the
default IDE one which is to wait for BUSY to be gone). I suspect some
ATAPIs would love getting a new WIN_PIDENTIFY at least, and I've seen
some take time before actually _raising_ BUSY ... I'll look into it.

> This is kernel 2.6.7-rc2 on powerbook g4 1Ghz.
> 
> Please comment,
> Regards,
> Soeren.
> 
> VFS: busy inodes on changed media.
> hdc: irq timeout: status=0xc0 { Busy }
> hdc: irq timeout: error=0xc0LastFailedSense 0x0c 
> hdc: DMA disabled
> hdc: ATAPI reset complete
> VFS: busy inodes on changed media.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

