Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTEWSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTEWSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:21:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3077 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264125AbTEWSVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:21:55 -0400
Date: Fri, 23 May 2003 19:34:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, LW@KARO-electronics.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030523193458.B4584@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Hugh Dickins <hugh@veritas.com>, LW@KARO-electronics.de,
	linux-kernel@vger.kernel.org
References: <20030523175413.A4584@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain> <20030523112926.7c864263.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030523112926.7c864263.akpm@digeo.com>; from akpm@digeo.com on Fri, May 23, 2003 at 11:29:26AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 11:29:26AM -0700, Andrew Morton wrote:
> Vague statement of principle: The device driver layer takes care of these
> issues for DMA transfers, and hence should also take care of them for PIO. 
> Is this sensible and/or possible?

I'd err on the side of caution about extending this principle.  The
device driver layer's issue for DMA transfers seems to cover the device <->
kernel cache consistency, not the device <-> user space or kernel <->
user space cache consistency.

The kernel <-> user space consistency issue seems to be one for the MM
layer to deal with.  There are other situations where this view can go
out of sync - for instance, when you have a page of a file mmap'd, and
you use sys_write() to that page of file.  This is the issue which
flush_dcache_page() seems to be addressing, and it's the same issue
with PIO from IDE.

So no, I don't think it is a device driver issue at all.

DaveM?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

