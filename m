Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbUDFQrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbUDFQrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:47:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22031 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263900AbUDFQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:40:54 -0400
Date: Tue, 6 Apr 2004 17:40:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: racing anon_vma_prepares
Message-ID: <Pine.LNX.4.44.0404061730270.17300-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed that you rely on mmap_sem to protect anon_vma_prepare:
but it doesn't, since concurrent faults can both down_read(&mmap_sem).
I think the anon_vma_alloc should be done where you have anon_vma_prepare,
but some kind of set_anon_vma under page_table_lock to set or free it.

Hugh

