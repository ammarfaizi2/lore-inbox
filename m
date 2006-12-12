Return-Path: <linux-kernel-owner+w=401wt.eu-S932149AbWLLRPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWLLRPK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWLLRPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:15:08 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34651 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149AbWLLRPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:15:05 -0500
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix COW D-cache aliasing on fork
Date: Tue, 12 Dec 2006 17:14:53 +0000
Message-Id: <11659436971966-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of the patch series I posted a while ago updated for
today's kernel:

 o patch 1/4 allows an architecture to override the generic
   copy_user_highpage with an architecture specific implementation.  For
   details about the aliasing issue please see the log message of that
   patch.
 o patch 2/4 passes a vma argument to copy_user_highpage.  This allows
   an architecture to optimize its cache handling by looking at the
   vma's VM_EXEC flag.  On architecture that do not make use of this gcc
   will be able to optimize the argument passing away, so no overhead.
 o patch 3/4 uses the facilities of the first two patches to solve the
   alias issue for MIPS
 o patch 4/4 is not a cache alias fix but allows optimizing away the
   cache flush operation in dup_mm().  On a MIPS 34K this accelerates
   fork by 12.5%.
   Since this patch is logically separate from 1-3 it can be applied
   independantly.

  Ralf
