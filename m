Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933263AbWFZXSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263AbWFZXSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbWFZWhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53663 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933216AbWFZWhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:07 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:37:06 +1000
Subject: [Suspend2][ 00/32] Block i/o patches.
Message-Id: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches contains routines in kernel/power/block_io.c.

The routines use struct block_device * pointers and lists of blocks
for each block_device. The blocks, in turn, are stored as chains
of extents.

Multiple swap devices can thus be supported trivially, and the
position at which each part of the image starts can be described
in terms of which device/chain is used, what actual value we're
sitting on and (for optimisation) which extent in the chain is
current.

On top of this, we implement support for asynchronous I/O and
readahead when synchronous I/O is required (ie when reading
compressed data at resume time).

The swapwriter and filewriter can then use a really simple
interface where they don't have to worry at all about what
device or block is the target.

Oh, and we handle variable blocksizes too.
