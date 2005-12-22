Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVLVS1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVLVS1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVLVS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:27:48 -0500
Received: from waste.org ([64.81.244.121]:65231 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030255AbVLVS1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:27:47 -0500
Date: Thu, 22 Dec 2005 12:26:22 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linux-tiny@selenic.com
Message-Id: <1.150843412@selenic.com>
Subject: [PATCH 0/20] inflate: refactor boot-time inflate code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refactored version of the lib/inflate.c:

- clean up some really ugly code
- clean up atrocities like '#include "../../../lib/inflate.c"'
- drop a ton of cut and paste code from the kernel boot
- move towards making the boot decompressor pluggable
- move towards unifying the multiple inflate implementations
- save space

Recent changes include:

- use proper pointer types for minimal malloc arena
- fix up static const usage to make ARM happy
- fix compile with CONFIG_MODVERSIONS

This touches 11 architectures, which makes things slightly
interesting. Rather than break the patches out by arch, I've gone the
route of making a number of small incremental changes that sweep
across the tree. Patches that touch the per-arch code are marked
"(arch)".

I've been primarily testing this on x86, but various versions of this
code have gotten testing on a variety of architectures as part of my
linux-tiny tree.

(This work was sponsored in part by the CE Linux Forum.)
