Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTDXIdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTDXIdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:33:53 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10624 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261835AbTDXIdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:33:53 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304240848.h3O8meB2000455@81-2-122-30.bradfords.org.uk>
Subject: Re: Fix SWSUSP & !SWAP
To: akpm@digeo.com (Andrew Morton)
Date: Thu, 24 Apr 2003 09:48:40 +0100 (BST)
Cc: rddunlap@osdl.org (Randy.Dunlap), ncunningham@clear.net.nz, cat@zip.com.au,
       pavel@ucw.cz, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030423173837.08202f0b.akpm@digeo.com> from "Andrew Morton" at Apr 23, 2003 05:38:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That may be simple for you, but for lots of users, adding a partition
> > (to a ususally full disk drive) isn't simple.  It means backups,
> > shrink a filesystem, shrink a partition, add a partition, and run
> > mkswap on it.   Yes, the latter 2 are simple, but the former ones
> > are not.
> 
> Yeah.  swsusp is pretty much the only reason why you would want to have a
> swap partition at all in a 2.5/2.6 kernel.

A lot of users still follow the 'swap space twice the size of physical
RAM' rule of thumb.

Now that physical RAM sizes have increased by an order of magnitude
since that advice was given, there are a lot of systems with far more
swap than they need, which provides the solution to our problem - if
there is a single swap partition which is twice the size of physical
RAM, just split it in to SWAP and SWSUSP slices, (not separate
partitions, slices in the same way BSD subdivides a partition).

2.4 kernels will see a big swap area, and use all of it as swap, 2.5
kernels will see a smaller swap area, (equal to physical RAM size, and
therefore sufficient in a lot of cases), and a SWSUSP area the same
size as physical RAM.

John.
