Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWEPXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWEPXYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWEPXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:24:46 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:27301 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932279AbWEPXYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:24:46 -0400
Date: Tue, 16 May 2006 19:24:43 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Subject: swapper_space export
Message-ID: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to compile the Unionfs[1] to get it up to sync it up with
the kernel developments from the past few months. Anyway, long story
short...swapper_space (defined in mm/swap_state.c) is not exported
anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
apparently is not an issue for most modules. Troubles arise when the
modules include mm.h or any of its relatives.

One simply gets a linker error about swapper_space not being defined.
The problem is that it is used in mm.h.

I included a reverse patch to export the symbol again.

Josef "Jeff" Sipek.

[1] http://unionfs.filesystems.org


Export swapper_space because several include files reference it.

Signed-off-by: Josef Sipek <jsipek@cs.sunysb.edu>

--- a/mm/swap_state.c.orig	2006-05-16 18:23:38.000000000 -0400
+++ b/mm/swap_state.c		2006-05-16 18:22:57.000000000 -0400
@@ -43,6 +43,7 @@
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
 };
+EXPORT_SYMBOL(swapper_space);
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 
