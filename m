Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWALRHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWALRHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWALRHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:07:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:41151 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751365AbWALRHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:07:13 -0500
Content-Type: multipart/mixed; boundary="===============0213864877=="
MIME-Version: 1.0
Subject: [PATCH 0 of 2] MMIO copy patches, the next generation
Message-Id: <patchbomb.1137085530@eng-12.pathscale.com>
Date: Thu, 12 Jan 2006 09:05:30 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, ak@suse.de
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0213864877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

After another round of review, here is a revised set of MMIO copy patches.

These have switched the name of the copy routine to __iowrite32_copy,
to match the naming convention in include/asm-generic/iomap.h, and at
Andi's request.  The name is double-underscored to make it clear that
the routine does not guarantee the order of writes or perform a memory
barrier; the kernel doc also explicitly states this.

These define the generic __iowrite32_copy as a weak symbol, which
arches are free to override.  We provide a specialised implementation
for x86_64.  In a change from prior versions of these patches, the x86_64
version no longer makes any assumptions about the bus breaking up 64-bit
transactions, and uses 32-bit copies directly.

We also introduce include/linux/io.h, which is tiny now, but a candidate
for later cleanups of all the per-arch asm-*/{io,iomap}.h files.

These patches should apply cleanly against current -git, and have been
tested on i386 and x86_64.

The patch series is as follows:

iomap_copy.patch
  Introduce the generic MMIO 32-bit copy routine.

x86_64-iomap_copy.patch
  Add a faster __iowrite32_copy routine to x86_64.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

--===============0213864877==--
