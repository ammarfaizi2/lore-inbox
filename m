Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWGXWmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWGXWmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGXWmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:42:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:2209 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932308AbWGXWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:42:16 -0400
Subject: vxfs_readdir locking incorrect: add lock_kernel() or remove
	unlock_kernel()?
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 15:42:17 -0700
Message-Id: <1153780937.31581.13.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b2fd697427e73c81d5fa659efd91bd07d303b0e in the historical GIT
tree stopped calling the readdir member of a file_operations struct with
the big kernel lock held, and fixed up all the readdir functions to do
their own locking.  However, that change added calls to unlock_kernel()
in vxfs_readdir (fs/freevxfs/vxfs_lookup.c), but no call to
lock_kernel().  Should vxfs_readdir call lock_kernel(), or should the
calls to unlock_kernel() go away?

- Josh Triplett


